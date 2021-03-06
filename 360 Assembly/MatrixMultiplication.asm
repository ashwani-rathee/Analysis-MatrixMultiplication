*        Matrix multiplication     06/08/2015
MATRIXRC CSECT                     Matrix multiplication
         USING  MATRIXRC,R13
SAVEARA  B      STM-SAVEARA(R15)
         DC     17F'0'
STM      STM    R14,R12,12(R13)
         ST     R13,4(R15)
         ST     R15,8(R13)
         LR     R13,R15
         LA     R7,1               i=1
LOOPI1   CH     R7,M               do i=1 to m (R7)
         BH     ELOOPI1
         LA     R8,1               j=1
LOOPJ1   CH     R8,P               do j=1 to p (R8)
         BH     ELOOPJ1
         LR     R1,R7              i
         BCTR   R1,0
         MH     R1,P
         LR     R6,R8              j
         BCTR   R6,0
         AR     R1,R6
         SLA    R1,2
         LA     R6,0
         ST     R6,C(R1)           c(i,j)=0
         LA     R9,1               k=1
LOOPK1   CH     R9,N               do k=1 to n (R9)
         BH     ELOOPK1
         LR     R1,R7              i
         BCTR   R1,0
         MH     R1,P
         LR     R6,R8              j
         BCTR   R6,0
         AR     R1,R6
         SLA    R1,2
         L      R2,C(R1)           R2=c(i,j)
         LR     R10,R1             R10=offset(i,j)
         LR     R1,R7              i
         BCTR   R1,0
         MH     R1,N
         LR     R6,R9              k
         BCTR   R6,0
         AR     R1,R6
         SLA    R1,2
         L      R3,A(R1)           R3=a(i,k)
         LR     R1,R9              k
         BCTR   R1,0
         MH     R1,P
         LR     R6,R8              j
         BCTR   R6,0
         AR     R1,R6
         SLA    R1,2
         L      R4,B(R1)           R4=b(k,j)
         LR     R15,R3             a(i,k)
         MR     R14,R4             a(i,k)*b(k,j)
         LR     R3,R15
         AR     R2,R3              R2=R2+a(i,k)*b(k,j)
         ST     R2,C(R10)          c(i,j)=c(i,j)+a(i,k)*b(k,j)
         LA     R9,1(R9)           k=k+1
         B      LOOPK1
ELOOPK1  LA     R8,1(R8)           j=j+1
         B      LOOPJ1
ELOOPJ1  LA     R7,1(R7)           i=i+1
         B      LOOPI1
ELOOPI1  MVC    Z,=CL80' '         clear buffer
         LA     R7,1
LOOPI2   CH     R7,M               do i=1 to m
         BH     ELOOPI2
         LA     R8,1
LOOPJ2   CH     R8,P               do j=1 to p
         BH     ELOOPJ2
         LR     R1,R7              i
         BCTR   R1,0
         MH     R1,P
         LR     R6,R8              j
         BCTR   R6,0
         AR     R1,R6
         SLA    R1,2
         L      R6,C(R1)           c(i,j)
         LA     R3,Z
         AH     R3,IZ
         XDECO  R6,W
         MVC    0(5,R3),W+7        output c(i,j)
         LH     R3,IZ
         LA     R3,5(R3)
         STH    R3,IZ
         LA     R8,1(R8)           j=j+1
         B      LOOPJ2
ELOOPJ2  XPRNT  Z,80               print buffer
         MVC    IZ,=H'0'
         LA     R7,1(R7)           i=i+1
         B      LOOPI2
ELOOPI2  L      R13,4(0,R13)
         LM     R14,R12,12(R13)
         XR     R15,R15
         BR     R14
A        DC     F'1',F'2',F'3',F'4',F'5',F'6',F'7',F'8'  a(4,2)
B        DC     F'1',F'2',F'3',F'4',F'5',F'6'            b(2,3)
C        DS     12F                                      c(4,3)
N        DC     H'2'               dim(a,2)=dim(b,1) 
M        DC     H'4'               dim(a,1) 
P        DC     H'3'               dim(b,2)
Z        DS     CL80
IZ       DC     H'0'
W        DS     CL16
         YREGS  
         END    MATRIXRC