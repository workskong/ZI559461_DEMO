CLASS zi559461_cl_demo_ce DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    INTERFACES if_rap_query_provider.

    TYPES t_et_data TYPE TABLE OF zi559461_demo_ce.

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS get_data
      IMPORTING
        filter_cond        TYPE if_rap_query_filter=>tt_name_range_pairs OPTIONAL
        top                TYPE i OPTIONAL
        skip               TYPE i OPTIONAL
        is_data_requested  TYPE abap_bool
        is_count_requested TYPE abap_bool
      EXPORTING
        et_data            TYPE t_et_data
        count              TYPE int8
      RAISING
        /iwbep/cx_cp_remote
        /iwbep/cx_gateway
        cx_web_http_client_error
        cx_http_dest_provider_error
      .
ENDCLASS.



CLASS zi559461_cl_demo_ce IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lt_data TYPE t_et_data,
          count   TYPE int8.

    DATA: filter_conditions TYPE if_rap_query_filter=>tt_name_range_pairs,
          ranges_table      TYPE if_rap_query_filter=>tt_range_option.

    ranges_table      = VALUE #( ( sign = 'I' option = 'GE' low = 1 ) ).
    filter_conditions = VALUE #( ( name = 'ID' range = ranges_table ) ).

    TRY.
        get_data(
          EXPORTING
            filter_cond        = filter_conditions
            top                = 3
            skip               = 1
            is_count_requested = abap_true
            is_data_requested  = abap_true
          IMPORTING
            et_data            = lt_data
            count              = count
          ) .
        out->write( |Total number of records = { count }| ) .
        out->write( lt_data ).
      CATCH cx_root INTO DATA(exception).
        out->write( cl_message_helper=>get_latest_t100_exception( exception )->if_message~get_longtext( ) ).
    ENDTRY.

  ENDMETHOD.

  METHOD if_rap_query_provider~select.

    DATA: lt_data TYPE t_et_data,
          count   TYPE int8.

    DATA(top)              = io_request->get_paging( )->get_page_size( ).
    DATA(skip)             = io_request->get_paging( )->get_offset( ).
    DATA(requested_fields) = io_request->get_requested_elements( ).
    DATA(sort_order)       = io_request->get_sort_elements( ).

    TRY.
        DATA(filter_condition) = io_request->get_filter( )->get_as_ranges( ).

        get_data(
         EXPORTING
           filter_cond        = filter_condition
           top                = CONV i( top )
           skip               = CONV i( skip )
           is_data_requested  = io_request->is_data_requested( )
           is_count_requested = io_request->is_total_numb_of_rec_requested(  )
         IMPORTING
           et_data            = lt_data
           count              = count
         ) .

        IF io_request->is_total_numb_of_rec_requested(  ).
          io_response->set_total_number_of_records( count ).
        ENDIF.
        IF io_request->is_data_requested(  ).
          io_response->set_data( lt_data ).
        ENDIF.

      CATCH cx_root INTO DATA(exception).
        DATA(exception_message) = cl_message_helper=>get_latest_t100_exception( exception )->if_message~get_longtext( ).
    ENDTRY.

  ENDMETHOD.


  METHOD get_data.

    DATA: lt_data TYPE t_et_data,
          ls_data TYPE LINE OF t_et_data.

    lt_data = VALUE #( ( Id = 1 Name = 'Anna' City = 'Seoul' )
                       ( Id = 2 Name = 'Peter' City = 'Tokyo' ) ).

    ls_data-Id   = 3.
    ls_data-Name = 'Marc'.
    ls_data-City = 'Suwon'.
    APPEND ls_data TO lt_data.

    LOOP AT  filter_cond  INTO DATA(filter_condition).
      READ TABLE lt_data WITH KEY id = filter_condition-range[ 1 ]-low INTO ls_data-Id.
      IF sy-subrc = 0.
        DELETE lt_data WHERE id NE ls_data-Id.
      ENDIF.
    ENDLOOP.

    IF lt_data IS NOT INITIAL.
      et_data = lt_data.
    ENDIF.

    IF is_count_requested = abap_true.
      count = lines( lt_data ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
