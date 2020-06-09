C Copyright(C) 1999-2020 National Technology & Engineering Solutions
C of Sandia, LLC (NTESS).  Under the terms of Contract DE-NA0003525 with
C NTESS, the U.S. Government retains certain rights in this software.
C 
C See packages/seacas/LICENSE for details

C $Log: grsymb.f,v $
C Revision 1.3  2009/03/25 12:36:45  gdsjaar
C Add copyright and license notice to all files.
C Permission to assert copyright has been granted; blot is now open source, BSD
C
C Revision 1.2  2005/07/27 19:29:34  gdsjaar
C On the 64-bit compile using the portland compiler on reddish; the
C construct "call function(float(intarg))" was passing an invalid value;
C probably due to a 32-bit vs 64-bit confusion.
C
C I changed it to "call function(1.0*intarg)" which performs an implicit
C conversion to real which I guess uses the correct 32-bit vs 64-bit.
C
C Revision 1.1  1994/04/07 20:02:51  gdsjaar
C Initial checkin of ACCESS/graphics/blotII2
C
c Revision 1.2  1990/12/14  08:51:59  gdsjaar
c Added RCS Id and Log to all files
c
C=======================================================================
      SUBROUTINE GRSYMB (LINTYP, ISYTYP, INDX)
C=======================================================================

C   --*** GRSYMB *** (GRPLIB) Set line type and symbol (PLT)
C   --   Written by Amy Gilkey - revised 02/14/86
C   --
C   --GRSYMB must first be called with a negative index to initialize
C   --the number of colors to be used (including black and white).
C   --
C   --GRSYMB sets the line type and symbol for PLTGRH depending on the
C   --passed index.  The line type and symbol are chosen consecutively
C   --(see LINTYP, ISYTYP), wrapping around if necessary.
C   --
C   --Parameters:
C   --   LINTYP - IN - the line type:
C   --      0 = no line
C   --     -n = vary line type (on INDX)
C   --      n = line type n
C   --   ISYTYP - IN - the symbol type:
C   --      0 = no symbol
C   --     -n = vary symbol type (on INDX)
C   --      n = symbol n
C   --   INDX - IN - the line type and symbol index

C   --Routines Called:
C   --   PLTSTG - (PLTLIB) Set graph parameter
C   --      6 = (KCOLIN) set line color for PLTGRH lines
C   --      44 = (KCOSYM) set symbol color for PLTGRH lines
C   --      5 = (KONLIN) set line type for PLTGRH lines
C   --      7 = (KONSYM) set symbol for PLTGRH lines

      PARAMETER (KCOLOR=1)
      PARAMETER (KCOLIN=6, KCOSYM=44, KONLIN=5, KONSYM=7)

      PARAMETER (NUMLIN=6, NUMSYM=6)
C      --NUMLIN - the number of line types
C      --NUMSYM - the number of symbols

      INTEGER INDX

      LOGICAL LDUM, PLTSTG
      INTEGER LSTLIN, LSTSYM
      SAVE LSTLIN, LSTSYM
C      --LSTLIN - the last line type set
C      --LSTSYM - the last symbol set

      DATA LSTLIN, LSTSYM / -999, -999 /

      IF ((LINTYP .LE. -1) .OR. (LINTYP .NE. LSTLIN)) THEN
         IF (LINTYP .LE. -1) THEN
            ILIN = MOD (INDX-1, NUMLIN) + 1
         ELSE
            ILIN = MIN (LINTYP, NUMLIN)
         END IF
         LDUM = PLTSTG (KONLIN,1.0*ILIN)
         LSTLIN = ILIN
      END IF
      IF ((ISYTYP .LE. -1) .OR. (ISYTYP .NE. LSTSYM)) THEN
         IF (ISYTYP .LE. -1) THEN
            ISYM = MOD (INDX-1, NUMSYM) + 1
         ELSE
            ISYM = MIN (ISYTYP, NUMSYM)
         END IF
         LDUM = PLTSTG (KONSYM, 1.0*ISYM)
         LSTSYM = ISYM
      END IF

      RETURN
      END
