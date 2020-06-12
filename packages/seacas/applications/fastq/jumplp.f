C    Copyright(C) 1999-2020 National Technology & Engineering Solutions
C    of Sandia, LLC (NTESS).  Under the terms of Contract DE-NA0003525 with
C    NTESS, the U.S. Government retains certain rights in this software.
C    
C    See packages/seacas/LICENSE for details

C $Log: jumplp.f,v $
C Revision 1.1  1990/11/30 11:10:38  gdsjaar
C Initial revision
C
C
CC* FILE: [.PAVING]JUMPLP.FOR
CC* MODIFIED BY: TED BLACKER
CC* MODIFICATION DATE: 7/6/90
CC* MODIFICATION: COMPLETED HEADER INFORMATION
C
      FUNCTION JUMPLP (MXND, MLN, LNODES, INOW, IJUMP)
C***********************************************************************
C
C  FUNCTION JUMPLP = JUMPS IJUMP STEPS FORWARD AROUND THE CLOSED LOOP
C
C***********************************************************************
C
      DIMENSION LNODES (MLN, MXND)
C
      JUMPLP = INOW
      DO 100 I = 1, IJUMP
         JUMPLP = LNODES (3, JUMPLP)
  100 CONTINUE
      RETURN
C
      END
