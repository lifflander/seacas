C Copyright(C) 1999-2020 National Technology & Engineering Solutions
C of Sandia, LLC (NTESS).  Under the terms of Contract DE-NA0003525 with
C NTESS, the U.S. Government retains certain rights in this software.
C 
C See packages/seacas/LICENSE for details

C $Log: pltli3.f,v $
C Revision 1.2  2000/10/25 18:55:02  gdsjaar
C In the pltli? functions, check for N==0 before doing any array
C accesses.
C
C Also changed all references to 'mask' to be arrays where they were
C scalars since downstream code seems to treat them as arrays.
C
C Revision 1.1  1993/07/16 16:48:39  gdsjaar
C Changed plt to library rather than single source file.
C
C=======================================================================
      SUBROUTINE PLTLI3(PLL,PUR,N,XV,YV,NO,XVO,YVO)
      DIMENSION PLL(2),PUR(2),XV(*),YV(*),XVO(*),YVO(*)
      DIMENSION P(2),S(2)
      CHARACTER*6 SUBNAM
      PARAMETER (SUBNAM='PLTLI3')
      LOGICAL INSIDE

      NMAX = NO
      NO = 0
      if (n .gt. 0) then
        S(1) = XV(N)
        S(2) = YV(N)
        DO 2260 I = 1,N
          P(1) = XV(I)
          P(2) = YV(I)
          INSIDE = P(2) .LE. PUR(2)
          IF (INSIDE) THEN
            INSIDE = S(2) .LE. PUR(2)
            IF (INSIDE) THEN
              NO = NO + 1
              IF (NO.GT.NMAX) THEN
                CALL PLTFLU
                CALL SIORPT(SUBNAM,
     *   'Not enough space for output vertices; polygon clip unfinished'
     *            ,2)
                RETURN

              END IF

              XVO(NO) = P(1)
              YVO(NO) = P(2)

            ELSE
              TEMP = PLL(1) - PUR(1)
              FP = (S(2)-PUR(2))*TEMP
              FQ = (P(2)-PUR(2))*TEMP
              XL = FQ/ (FQ-FP)
              NO = NO + 1
              IF (NO.GT.NMAX) THEN
                CALL PLTFLU
                CALL SIORPT(SUBNAM,
     *   'Not enough space for output vertices; polygon clip unfinished'
     *            ,2)
                RETURN

              END IF

              XVO(NO) = P(1) + XL* (S(1)-P(1))
              YVO(NO) = P(2) + XL* (S(2)-P(2))
              NO = NO + 1
              IF (NO.GT.NMAX) THEN
                CALL PLTFLU
                CALL SIORPT(SUBNAM,
     *   'Not enough space for output vertices; polygon clip unfinished'
     *            ,2)
                RETURN

              END IF

              XVO(NO) = P(1)
              YVO(NO) = P(2)
            END IF

          ELSE
            INSIDE = S(2) .LE. PUR(2)
            IF (INSIDE) THEN
              TEMP = PLL(1) - PUR(1)
              FP = (S(2)-PUR(2))*TEMP
              FQ = (P(2)-PUR(2))*TEMP
              XL = FQ/ (FQ-FP)
              NO = NO + 1
              IF (NO.GT.NMAX) THEN
                CALL PLTFLU
                CALL SIORPT(SUBNAM,
     *   'Not enough space for output vertices; polygon clip unfinished'
     *            ,2)
                RETURN

              END IF

              XVO(NO) = P(1) + XL* (S(1)-P(1))
              YVO(NO) = P(2) + XL* (S(2)-P(2))
            END IF

          END IF

          S(1) = P(1)
          S(2) = P(2)
 2260   CONTINUE
      end if
      RETURN

      END
