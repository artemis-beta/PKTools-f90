MODULE PKVAR_MODULE
    IMPLICIT NONE
    PRIVATE
    PUBLIC :: PKVAR, GET_VAL, GET_ERROR
    PUBLIC :: OPERATOR(-), OPERATOR(+), OPERATOR(*), OPERATOR(/)

    TYPE PKVAR
        REAL(8) :: VALUE, ERROR
    END TYPE PKVAR
    INTERFACE OPERATOR(*)
        MODULE PROCEDURE PKVAR_PKVAR_MULTIPLY
    END INTERFACE

    INTERFACE OPERATOR(+)
        MODULE PROCEDURE PKVAR_PKVAR_ADD
    END INTERFACE

    INTERFACE OPERATOR(-)
        MODULE PROCEDURE PKVAR_PKVAR_SUB
    END INTERFACE

    INTERFACE OPERATOR(/)
        MODULE PROCEDURE PKVAR_PKVAR_DIV
    END INTERFACE   

CONTAINS
    REAL(8) FUNCTION GET_VAL(THIS)
        TYPE(PKVAR), INTENT(IN) :: THIS
        GET_VAL = THIS%VALUE
    END FUNCTION GET_VAL

    REAL(8) FUNCTION GET_ERROR(THIS)
        TYPE(PKVAR), INTENT(IN) :: THIS
        GET_ERROR = THIS%ERROR
    END FUNCTION GET_ERROR

    FUNCTION POWER(THIS, X) RESULT(THIS_POW_X)
        TYPE(PKVAR), INTENT(IN) :: THIS
        REAL(8), INTENT(IN) :: X
        TYPE(PKVAR) :: THIS_POW_X

        REAL(8) :: VAL, ERR

        IF( THIS%VALUE == 0D0 .AND. X < 1D0 ) THEN
            THIS_POW_X = PKVAR(THIS%VALUE, THIS%ERROR)
            RETURN
        END IF

        VAL = THIS%VALUE**X
        ERR = THIS%ERROR*X*THIS%VALUE**(X-1)

        THIS_POW_X%VALUE = VAL
        THIS_POW_X%ERROR = ERR
    END FUNCTION POWER

    FUNCTION SQRT(THIS) RESULT(THIS_SQRT)
        TYPE(PKVAR), INTENT(IN) :: THIS
        TYPE(PKVAR) :: THIS_SQRT
        THIS_SQRT = POWER(THIS, 0.5D0)
    END FUNCTION SQRT

    FUNCTION PKVAR_PKVAR_MULTIPLY(THIS1, THIS2) RESULT(THIS_PROD)
        TYPE(PKVAR), INTENT(IN) :: THIS1, THIS2
        TYPE(PKVAR) :: THIS_PROD

        REAL(8) :: ERR

        ERR = (THIS2%VALUE*THIS1%ERROR)**2 + (THIS1%VALUE*THIS2%ERROR)**2
        ERR = ERR**0.5D0

        THIS_PROD%VALUE = THIS1%VALUE*THIS2%VALUE
        THIS_PROD%ERROR = ERR
    END FUNCTION PKVAR_PKVAR_MULTIPLY

    FUNCTION PKVAR_PKVAR_DIV(THIS1, THIS2) RESULT(THIS_DIV)
        TYPE(PKVAR), INTENT(IN) :: THIS1, THIS2
        TYPE(PKVAR) :: THIS_DIV

        REAL(8) :: ERR

        ERR = (THIS1%ERROR/THIS2%VALUE)**2
        ERR = ERR + (THIS1%VALUE*THIS2%ERROR)**2*(THIS2%VALUE**(-4))
        ERR = ERR**0.5

        THIS_DIV%VALUE = THIS1%VALUE/THIS2%VALUE
        THIS_DIV%ERROR = ERR
    END FUNCTION

    FUNCTION PKVAR_PKVAR_ADD(THIS1, THIS2) RESULT(THIS_SUM)
        TYPE(PKVAR), INTENT(IN) :: THIS1, THIS2
        TYPE(PKVAR) :: THIS_SUM

        REAL(8) :: ERR

        ERR = THIS1%ERROR**2 + THIS2%ERROR**2

        ERR = ERR**0.5

        THIS_SUM%VALUE = THIS1%VALUE+THIS2%VALUE
        THIS_SUM%ERROR = ERR
    END FUNCTION

    FUNCTION PKVAR_PKVAR_SUB(THIS1, THIS2) RESULT(THIS_SUB)
        TYPE(PKVAR), INTENT(IN) :: THIS1, THIS2
        TYPE(PKVAR) :: THIS_SUB
    
        REAL(8) :: ERR

        ERR = THIS1%ERROR**2 + THIS2%ERROR**2

        ERR = ERR**0.5

        THIS_SUB%VALUE = THIS1%VALUE-THIS2%VALUE
        THIS_SUB%ERROR = ERR
    
    END FUNCTION

END MODULE PKVAR_MODULE