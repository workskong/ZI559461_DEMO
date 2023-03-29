CLASS zi559461_cx_demo_ce DEFINITION
  PUBLIC
    INHERITING FROM cx_xco_runtime_exception
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      gc_msgid TYPE symsgid VALUE 'ZI559461_DEMO_CE_MSG',

      BEGIN OF generic_error,
        msgid TYPE symsgid VALUE 'ZI559461_DEMO_CE_MSG',
        msgno TYPE symsgno VALUE '000',
        attr1 TYPE scx_attrname VALUE 'ERROR_VALUE_1',
        attr2 TYPE scx_attrname VALUE 'ERROR_VALUE_2',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF generic_error,
      BEGIN OF root_cause_exception,
        msgid TYPE symsgid VALUE 'ZI559461_DEMO_CE_MSG',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'ERROR_VALUE_1',
        attr2 TYPE scx_attrname VALUE 'ERROR_VALUE_2',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF root_cause_exception.

    DATA error_value_1 TYPE string.
    DATA error_value_2 TYPE string.

    CLASS-METHODS class_constructor .
    METHODS constructor
      IMPORTING
        !textid        LIKE if_t100_message=>t100key OPTIONAL
        !previous      LIKE previous OPTIONAL
        !error_value_1 TYPE string OPTIONAL
        !error_value_2 TYPE string OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zi559461_cx_demo_ce IMPLEMENTATION.

  METHOD class_constructor.
  ENDMETHOD.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous
        textid   = textid.

    me->error_value_1 = error_value_1.
    me->error_value_2 = error_value_2.

    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
