      SUBROUTINE ALG10
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
      IF(I.GT.1)GO TO 130
      V5=VISK**0.2
      VINH=0.0
      VINT=0.0
      IF(WWBL(1).GT.0.0)GO TO 100
      C1H=0.0
      C1T=0.0
      DELH(1)=0.0
      DELT(1)=0.0
      GO TO 150
100   IF(ISTAG.GT.0)GO TO 110
      X1=WWBL(1)*XL(NSTRMS,1)*(CPPG(1)+CPPG(NSTRMS))/4.0
      DELH(1)=X1
      DELT(1)=X1
      X1=X1/(SCLFAC*SHAPE)
      C1H=(X1*VM(1,1)**3.4/V5)**1.25
      C1T=(X1*VM(NSTRMS,1)**3.4/V5)**1.25
      GO TO 150
110   DELH(1)=0.0
      C1H=0.0
      IF(ABS(PHI(NSTRMS)).GT.PI/2.0-0.00015.AND.ABS(PHI(NSTRMS)).LT.PI/2
     1.0+0.00015)GO TO 120
      X1=(R(NSTRMS,1)-SQRT(R(NSTRMS,1)**2-COS(PHI(NSTRMS))*CPPG(NSTRMS)*
     1WWBL(1)*(R(NSTRMS,1)+R(1,1))*XL(NSTRMS,I)))/COS(PHI(NSTRMS))
      DELT(1)=X1
      C1T=(X1/(SHAPE*SCLFAC*V5)*VM(NSTRMS,1)**3.4)**1.25
      GO TO 150
120   DELT(1)=WWBL(1)*XL(NSTRMS,1)/CPPG(NSTRMS)
      C1T=(DELT(1)*VM(NSTRMS,1)**3.4/(V5*SCLFAC*SHAPE))**1.25
      GO TO 150
130   VINT=VINT+SQRT((X(NSTRMS,I)-X(NSTRMS,I-1))**2+(R(NSTRMS,I)-R(NSTRM
     1S,I-1))**2)*((VM(NSTRMS,I)+VM(NSTRMS,I-1))/2.0)**4/SCLFAC
      DELT(I)=V5*(C1T+0.016*VINT)**0.8/VM(NSTRMS,I)**3.4*SCLFAC*SHAPE
      DELH(I)=0.0
      IF(I.LE.ISTAG)GO TO 140
      VINH=VINH+SQRT((X(1,I)-X(1,I-1))**2+(R(1,I)-R(1,I-1))**2)*((VM(1,I
     1)+VM(1,I-1))/2.0)**4/SCLFAC
      DELH(I)=V5*(C1H+0.016*VINH)**0.8/VM(1,I)**3.4*SCLFAC*SHAPE
140   WWBL(I)=0.5*WWBL(I)+0.5*(((2.0*R(NSTRMS,I)-DELT(I)*COS(PHI(NSTRMS)
     1))*DELT(I)/CPPG(NSTRMS)+(2.0*R(1,I)+DELH(I)*COS(PHI(1)))*DELH(I)/C
     2PPG(1))/((R(NSTRMS,I)+R(1,I))*XL(NSTRMS,I)))
      IF(WWBL(I).GT.0.3)WWBL(I)=0.3
      IF(WWBL(I).LT.0.0)WWBL(I)=0.3
150   CONTINUE
      RETURN
      END
