      SUBROUTINE ALG07
C
      REAL LOSS,LAMI,LAMIP1,LAMIM1
C
      COMMON /UD300C/ NSTNS,NSTRMS,NMAX,NFORCE,NBL,NCASE,NSPLIT,NREAD,
     1NPUNCH,NPAGE,NSET1,NSET2,ISTAG,ICASE,IFAILO,IPASS,I,IVFAIL,IFFAIL,
     2NMIX,NTRANS,NPLOT,ILOSS,LNCT,ITUB,IMID,IFAIL,ITER,LOG1,LOG2,LOG3,
     3LOG4,LOG5,LOG6,IPRINT,NMANY,NSTPLT,NEQN,NSPEC(30),NWORK(30),
     4NLOSS(30),NDATA(30),NTERP(30),NMACH(30),NL1(30),NL2(30),NDIMEN(30)
     5,IS1(30),IS2(30),IS3(30),NEVAL(30),NDIFF(4),NDEL(30),NLITER(30),
     6NM(2),NRAD(2),NCURVE(30),NWHICH(30),NOUT1(30),NOUT2(30),NOUT3(30),
     7NBLADE(30),DM(11,5,2),WFRAC(11,5,2),R(21,30),XL(21,30),X(21,30),
     8H(21,30),S(21,30),VM(21,30),VW(21,30),TBETA(21,30),DIFF(15,4),
     9FDHUB(15,4),FDMID(15,4),FDTIP(15,4),TERAD(5,2),DATAC(100),
     1DATA1(100),DATA2(100),DATA3(100),DATA4(100),DATA5(100),DATA6(100),
     2DATA7(100),DATA8(100),DATA9(100),FLOW(10),SPEED(30),SPDFAC(10),
     3BBLOCK(30),BDIST(30),WBLOCK(30),WWBL(30),XSTN(150),RSTN(150),
     4DELF(30),DELC(100),DELTA(100),TITLE(18),DRDM2(30),RIM1(30),
     5XIM1(30),WORK(21),LOSS(21),TANEPS(21),XI(21),VV(21),DELW(21),
     6LAMI(21),LAMIM1(21),LAMIP1(21),PHI(21),CR(21),GAMA(21),SPPG(21),
     7CPPG(21),HKEEP(21),SKEEP(21),VWKEEP(21),DELH(30),DELT(30),VISK,
     8SHAPE,SCLFAC,EJ,G,TOLNCE,XSCALE,PSCALE,PLOW,RLOW,XMMAX,RCONST,
     9FM2,HMIN,C1,PI,CONTR,CONMX
C
      L1=I+NL1(I)
      L2=I+NL2(I)
      IW=NWORK(I)
      IL=NLOSS(I)
      XN=SPEED(I)*SPDFAC(ICASE)*PI/(30.0*SCLFAC)
      GO TO(100,250,270,290,440,440,440),IW
100   GO TO(110,190,210,110),IL
110   IF(L2.NE.I)GO TO 150
      DO 140 J=1,NSTRMS
      IF(IPASS.EQ.1.AND.ITER.EQ.0)GO TO 120
      IF(ITER.EQ.0)VV(J)=VM(J,I)
      X1=H(J,I)-(VV(J)**2+VW(J,I)**2)/(2.0*G*EJ)
      X2=H(J,I)-(VW(J,I)**2-(VW(J,I)-XN*R(J,I))**2)/(2.0*G*EJ)
      IF(X1.LT.HMIN)X1=HMIN
      IF(X2.LT.HMIN)X2=HMIN
      X3=1.0/(1.0+LOSS(J)*(1.0-ALG4(X1,S(J,I))/ALG4(X2,S(J,I))))
      GO TO 130
120   X3=1.0
130   H(J,I)=ALG2(S(J,L1),WORK(J)/X3)
140   S(J,I)=ALG3(WORK(J),H(J,I))
      GO TO 230
150   DO 180 J=1,NSTRMS
      IF(IPASS.EQ.1.AND.L2.GT.I)GO TO 160
      X1=H(J,L1)-(VW(J,L1)**2-(VW(J,L1)-XN*R(J,L1))**2)/(2.0*G*EJ)+XN**2
     1*(R(J,I)**2-R(J,L1)**2)/(2.0*G*EJ)
      IF(X1.LT.HMIN)X1=HMIN
      X2=H(J,L2)-(VM(J,L2)**2+VW(J,L2)**2)/(2.0*G*EJ)
      X3=H(J,L2)-(VW(J,L2)**2-(VW(J,L2)-XN*R(J,L2))**2)/(2.0*G*EJ)
      IF(X2.LT.HMIN)X2=HMIN
      IF(X3.LT.HMIN)X3=HMIN
      X4=1.0-LOSS(J)/ALG4(X1,S(J,L1))*(ALG4(X3,S(J,L2))-ALG4(X2,S(J,L2))
     1)
      GO TO 170
160   X4=1.0
170   H(J,I)=ALG2(S(J,L1),WORK(J)/X4)
180   S(J,I)=ALG3(WORK(J),H(J,I))
      GO TO 230
190   DO 200 J=1,NSTRMS
      H(J,I)=H(J,L1)+(ALG2(S(J,L1),WORK(J))-H(J,L1))/LOSS(J)
200   S(J,I)=ALG3(WORK(J),H(J,I))
      GO TO 230
210   DO 220 J=1,NSTRMS
      S(J,I)=S(J,L1)+LOSS(J)
220   H(J,I)=ALG2(S(J,I),WORK(J))
230   DO 240 J=1,NSTRMS
240   VW(J,I)=(XN*RIM1(J)*VW(J,I-1)+(H(J,I)-H(J,I-1))*G*EJ)/(XN*R(J,I))
      GO TO 570
250   DO 260 J=1,NSTRMS
      H(J,I)=WORK(J)
260   VW(J,I)=(XN*RIM1(J)*VW(J,I-1)+(H(J,I)-H(J,I-1))*G*EJ)/(XN*R(J,I))
      GO TO 330
270   DO 280 J=1,NSTRMS
280   VW(J,I)=WORK(J)/R(J,I)
      GO TO 310
290   DO 300 J=1,NSTRMS
300   VW(J,I)=WORK(J)
310   DO 320 J=1,NSTRMS
320   H(J,I)=H(J,I-1)+XN*(R(J,I)*VW(J,I)-RIM1(J)*VW(J,I-1))/(G*EJ)
330   GO TO(340,400,420,340),IL
340   IF(L2.NE.I)GO TO 370
      DO 360 J=1,NSTRMS
      IF(IPASS.EQ.1.AND.ITER.EQ.0)GO TO 350
      IF(ITER.EQ.0)VV(J)=VM(J,I)
      X1=H(J,I)-(VV(J)**2+VW(J,I)**2)/(2.0*G*EJ)
      X2=H(J,I)-(VW(J,I)**2-(VW(J,I)-XN*R(J,I))**2)/(2.0*G*EJ)
      IF(X1.LT.HMIN)X1=HMIN
      IF(X2.LT.HMIN)X2=HMIN
      X3=1.0/(1.0+LOSS(J)*(1.0-ALG4(X1,S(J,I))/ALG4(X2,S(J,I))))
      GO TO 360
350   X3=1.0
360   S(J,I)=ALG3(X3*ALG4(H(J,I),S(J,L1)),H(J,I))
      GO TO 570
370   DO 390 J=1,NSTRMS
      IF(IPASS.EQ.1.AND.L2.GT.I)GO TO 380
      X1=H(J,L1)-(VW(J,L1)**2-(VW(J,L1)-XN*R(J,L1))**2)/(2.0*G*EJ)+XN**2
     1*(R(J,I)**2-R(J,L1)**2)/(2.0*G*EJ)
      IF(X1.LT.HMIN)X1=HMIN
      X2=H(J,L2)-(VM(J,L2)**2+VW(J,L2)**2)/(2.0*G*EJ)
      X3=H(J,L2)-(VW(J,L2)**2-(VW(J,L2)-XN*R(J,L2))**2)/(2.0*G*EJ)
      IF(X2.LT.HMIN)X2=HMIN
      IF(X3.LT.HMIN)X3=HMIN
      X4=1.0-LOSS(J)/ALG4(X1,S(J,L1))*(ALG4(X3,S(J,L2))-ALG4(X2,S(J,L2))
     1)
      GO TO 390
380   X4=1.0
390   S(J,I)=ALG3(X4*ALG4(H(J,I),S(J,L1)),H(J,I))
      GO TO 570
400   DO 410 J=1,NSTRMS
410   S(J,I)=ALG3(ALG4(H(J,L1)+LOSS(J)*(H(J,I)-H(J,L1)),S(J,L1)),H(J,I))
      GO TO 570
420   DO 430 J=1,NSTRMS
430   S(J,I)=S(J,L1)+LOSS(J)
      GO TO 570
440   DO 450 J=1,NSTRMS
450   XI(J)=H(J,I-1)-XN*RIM1(J)*VW(J,I-1)/(G*EJ)
      GO TO(460,510,550,460),IL
460   IF(L2.NE.I)GO TO 490
      DO 480 J=1,NSTRMS
      X2=XI(J)+(XN*R(J,I))**2/(2.0*G*EJ)
      IF(IPASS.EQ.1.AND.ITER.EQ.0) GO TO 470
      IF(ITER.EQ.0) VV(J) = VM(J,I)
      X1=X2-VV(J)**2*(1.0+TBETA(J,I)**2)/(2.0*G*EJ)
      IF(X1.LT.HMIN)X1=HMIN
      IF(X2.LT.HMIN)X2=HMIN
      X3=1.0/(1.0+LOSS(J)*(1.0-ALG4(X1,S(J,I))/ALG4(X2,S(J,I))))
      GO TO 480
470   X3=1.0
480   S(J,I)=ALG3(X3*ALG4(X2,S(J,L1)),X2)
      GO TO 570
490   DO 500 J=1,NSTRMS
      X4=XI(J)+(XN*R(J,I))**2/(2.0*G*EJ)
      IF(X4.LT.HMIN)X4=HMIN
      X1=ALG4(X4,S(J,L1))
      IF(IPASS.EQ.1.AND.L2.GT.I)GO TO 500
      X2=XI(J)+(XN*R(J,L2))**2/(2.0*G*EJ)
      X3=H(J,L2)-(VM(J,L2)**2+VW(J,L2)**2)/(2.0*G*EJ)
      IF(X2.LT.HMIN)X2=HMIN
      IF(X3.LT.HMIN)X3=HMIN
      X1=X1-LOSS(J)*(ALG4(X2,S(J,L2))-ALG4(X3,S(J,L2)))
500   S(J,I)=ALG3(X1,X4)
      GO TO 570
510   IF(IPASS.EQ.1.AND.ITER.EQ.0)GO TO 530
      DO 520 J=1,NSTRMS
      IF(ITER.EQ.0)VV(J)=VM(J,I)
      X1=H(J,I-1)+XN*(VV(J)*(TBETA(J,I)+XN*R(J,I)/VV(J))*R(J,I)-RIM1(J)*
     1VW(J,I-1))/(G*EJ)
      IF(X1.LT.HMIN)X1=HMIN
      X2=ALG4(H(J,L1)+(X1-H(J,L1))*LOSS(J),S(J,L1))
520   S(J,I)=ALG3(X2,X1)
      GO TO 570
530   DO 540 J=1,NSTRMS
540   S(J,I)=S(J,L1)
      GO TO 570
550   DO 560 J=1,NSTRMS
560   S(J,I)=S(J,L1)+LOSS(J)
570   RETURN
      END
