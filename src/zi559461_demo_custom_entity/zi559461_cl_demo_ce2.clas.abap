CLASS zi559461_cl_demo_ce2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
*    INTERFACES if_oo_adt_classrun.
    INTERFACES if_rap_query_provider.

    TYPES t_data TYPE TABLE OF zi559461_demo_ce2.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS get_data
      IMPORTING
        filter_condition_string TYPE string OPTIONAL
        filter_condition_ranges TYPE if_rap_query_filter=>tt_name_range_pairs OPTIONAL
        top                     TYPE i OPTIONAL
        skip                    TYPE i OPTIONAL
        is_data_requested       TYPE abap_bool OPTIONAL
        is_count_requested      TYPE abap_bool OPTIONAL
      EXPORTING
        et_data                 TYPE t_data
        count                   TYPE int8.
ENDCLASS.


CLASS zi559461_cl_demo_ce2 IMPLEMENTATION.

  METHOD if_rap_query_provider~select.

    DATA: lt_data          TYPE t_data,
          lv_total_records TYPE int8.

    DATA(top) = io_request->get_paging( )->get_page_size( ).
    DATA(skip) = io_request->get_paging( )->get_offset( ).

    DATA(requested_fields) = io_request->get_requested_elements( ).
    DATA(sort_order) = io_request->get_sort_elements( ).

    TRY.
        DATA(filter_condition_string) = io_request->get_filter( )->get_as_sql_string( ).
        DATA(filter_condition_ranges) = io_request->get_filter( )->get_as_ranges( ).

      CATCH cx_root INTO DATA(exception).
        DATA(exception_message) = cl_message_helper=>get_latest_t100_exception( exception )->if_message~get_longtext( ).

        DATA(exception_t100_key) = cl_message_helper=>get_latest_t100_exception( exception )->t100key.

        RAISE EXCEPTION TYPE zi559461_cx_demo_ce
          EXPORTING
            textid   = VALUE #( msgid = exception_t100_key-msgid
                                msgno = exception_t100_key-msgno
                                attr1 = exception_t100_key-attr1
                                attr2 = exception_t100_key-attr2
                                attr3 = exception_t100_key-attr3
                                attr4 = exception_t100_key-attr4 )
            previous = exception.
    ENDTRY.

    IF top IS NOT INITIAL AND top > 0.
      DATA(max_index) = top + skip.
    ELSE.
      max_index = 0.
    ENDIF.

    IF sort_order IS NOT INITIAL.

      DATA order_by_string TYPE string.

      CLEAR order_by_string.
      LOOP AT sort_order INTO DATA(ls_orderby_property).
        IF ls_orderby_property-descending = abap_true.
          CONCATENATE order_by_string ls_orderby_property-element_name 'DESCENDING' INTO order_by_string SEPARATED BY space.
        ELSE.
          CONCATENATE order_by_string ls_orderby_property-element_name 'ASCENDING' INTO order_by_string SEPARATED BY space.
        ENDIF.
      ENDLOOP.

    ENDIF.

    get_data(
      EXPORTING
        filter_condition_string = filter_condition_string
        filter_condition_ranges = filter_condition_ranges
*        top                     =
*        skip                    =
*        is_data_requested       =
*        is_count_requested      =
      IMPORTING
        et_data                 = lt_data
        count                   = lv_total_records
    ).

    SELECT ebeln
      FROM @lt_data AS data_source_fields
     WHERE (filter_condition_string)
     ORDER BY (order_by_string)
     INTO TABLE @DATA(lt_temp)
     UP TO @max_index ROWS.

    DATA: lr_ebeln TYPE RANGE OF zi559461_demo_ce2-ebeln.

    LOOP AT lt_temp INTO DATA(ls_temp).
      APPEND VALUE #( sign = 'I' option = 'EQ' low = ls_temp-ebeln ) TO lr_ebeln.
    ENDLOOP.

    DELETE lt_data WHERE ebeln NOT IN lr_ebeln.
    IF skip IS NOT INITIAL.
      DELETE lt_data TO skip.
    ENDIF.

    io_response->set_total_number_of_records( lv_total_records ).
    io_response->set_data( lt_data ).

  ENDMETHOD.


  METHOD get_data.
    DATA lv_ebeln TYPE zi559461_demo_ce2-ebeln.

    DO 100000 TIMES.
      lv_ebeln = lv_ebeln + 1.

      APPEND VALUE #( ebeln = lv_ebeln
                      bukrs = '1000'
                      bstyp = 'A'
      ) TO et_data.
    ENDDO.

    IF filter_condition_string IS NOT INITIAL.
      SELECT *
        FROM @et_data AS data_source_fields
       WHERE (filter_condition_string)
       INTO TABLE @et_data.
    ENDIF.

    count = lines( et_data ).
  ENDMETHOD.

ENDCLASS.
