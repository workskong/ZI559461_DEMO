CLASS lhc_Root DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Root RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Root RESULT result.

    METHODS InputId FOR MODIFY
      IMPORTING keys FOR ACTION Root~InputId RESULT result.

ENDCLASS.

CLASS lhc_Root IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD InputId.
    DATA: InputIts TYPE TABLE FOR UPDATE zi559461_demo_abs_root.
    DATA(keys_with_valid) = keys.

    LOOP AT keys_with_valid ASSIGNING FIELD-SYMBOL(<key_with_valid_discount>)
                            WHERE %param-customer_id IS NOT INITIAL.
*      APPEND VALUE #( %tky = <key_with_valid_discount>-%tky ) TO failed-root.
*      APPEND VALUE #( %tky = <key_with_valid_discount>-%tky ) TO reported-root.
*      DELETE keys_with_valid.
    ENDLOOP.

    CHECK keys_with_valid IS NOT INITIAL.

    READ ENTITIES OF zi559461_demo_abs_root IN LOCAL MODE
        ENTITY Root
        FIELDS ( CustomerId CarrierId ConnectionId )
        WITH CORRESPONDING #( keys_with_valid )
        RESULT DATA(input).

    LOOP AT input ASSIGNING FIELD-SYMBOL(<input>).
      APPEND VALUE #( %tky         = <input>-%tky
                      CustomerId   = keys_with_valid[ 1 ]-%param-customer_id
                      CarrierId    = keys_with_valid[ 1 ]-%param-carrier_id
                      ConnectionId = keys_with_valid[ 1 ]-%param-connection_id
                    ) TO InputIts.

    ENDLOOP.

    MODIFY ENTITIES OF zi559461_demo_abs_root IN LOCAL MODE
        ENTITY Root
        UPDATE FIELDS ( CustomerId CarrierId ConnectionId )
        WITH InputIts.

    READ ENTITIES OF zi559461_demo_abs_root IN LOCAL MODE
        ENTITY Root
        ALL FIELDS WITH CORRESPONDING #( input )
        RESULT DATA(InputIt).

    result = VALUE #( FOR Root IN InputIt ( %tky   = Root-%tky
                                            %param = Root ) ).
  ENDMETHOD.

ENDCLASS.
