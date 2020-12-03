PROGRAM ADDPKVARS
    USE PKVAR_MODULE
    IMPLICIT NONE
    TYPE(PKVAR) :: X, Y, Z

    X = PKVAR(1D2, 1D1)
    Y = PKVAR(56D0, 34D-2)

    WRITE(*,*) "DEMONSTRATION OF PKVAR TYPE OF THE FORM (VALUE, ERROR):", &
               NEW_LINE('A')

    WRITE(*,*) "VECTOR 1: ", X
    WRITE(*,*) "VECTOR 2: ", Y, NEW_LINE('A')

    Z = X + Y
    WRITE(*,*) "ADDITION: ", Z, NEW_LINE('A')

    Z = X - Y
    WRITE(*,*) "SUBTRACTION: ", Z, NEW_LINE('A')

    Z = X * Y
    WRITE(*,*) "MULTIPLICATION: ", Z, NEW_LINE('A')

    Z = X / Y
    WRITE(*,*) "DIVISION: ", Z, NEW_LINE('A')

END PROGRAM ADDPKVARS