! ( Last modified on 23 Dec 2000 at 22:01:38 )

!  ** FOR THE CRAY 2, LINES STARTING CDIR$ IVDEP TELL THE COMPILER TO
!     IGNORE POTENTIAL VECTOR DEPENDENCIES AS THEY ARE KNOWN TO BE O.K.

      SUBROUTINE DELGRD( N, NG, FIRSTG, ICNA, LICNA, ISTADA, LSTADA, &
                         IELING, LELING, ISTADG, LSTADG, ITYPEE, LITYPE, &
                         ISTAEV, LSTAEV, IELVAR, LELVAR, INTVAR, LNTVAR,  &
                         ISVGRP, LNVGRP, ISTAJC, LNSTJC, ISTAGV, LNSTGV,  &
                         A, LA, GVALS2, LGVALS, GUVALS, LGUVAL, GRAD, &
                         GSCALE, LGSCAL, ESCALE, LESCAL, GRJAC, LNGRJC,  &
                         WKPVAR, WKEVAR, LNWKEV, GXEQX, LGXEQX, INTREP,  &
                         LINTRE, RANGE )
      INTEGER, PARAMETER :: wp = KIND( 1.0D+0 )
      INTEGER :: N, NG, LA, LITYPE
      INTEGER :: LICNA, LSTADA, LELING, LSTADG, LSTAEV, LELVAR
      INTEGER :: LNTVAR, LNVGRP, LNSTJC, LNSTGV, LGVALS, LNWKEV
      INTEGER :: LGSCAL, LESCAL, LGXEQX, LINTRE, LGUVAL, LNGRJC
      LOGICAL :: FIRSTG
      INTEGER :: ICNA( LICNA ), ISTADA( LSTADA ), IELING( LELING )
      INTEGER :: ISTADG( LSTADG ), ISTAEV( LSTAEV )
      INTEGER :: IELVAR( LELVAR ), INTVAR( LNTVAR )
      INTEGER :: ISVGRP( LNVGRP ), ISTAJC( LNSTJC )
      INTEGER :: ISTAGV( LNSTGV ), ITYPEE( LITYPE )
      REAL ( KIND = wp ) :: A( LA ), GVALS2( LGVALS ), GUVALS( LGUVAL ),  &
                       GRAD( N ), GSCALE( LGSCAL ), ESCALE( LESCAL ),  &
                       GRJAC( LNGRJC ), WKPVAR( N ), WKEVAR( LNWKEV )
      LOGICAL :: GXEQX( LGXEQX ), INTREP( LINTRE )
      EXTERNAL :: RANGE 

!  CALCULATE THE GRADIENT OF EACH GROUP, GRJAC, AND THE GRADIENT OF THE
!  OBJECTIVE FUNCTION, GRAD.

!  NICK GOULD, 4TH JULY 1990.
!  FOR CGT PRODUCTIONS.

!  LOCAL VARIABLES.

      INTEGER :: I, IEL, IG, IG1, II,J, JJ, K, L, LL
      INTEGER :: NIN, NVAREL, NELOW, NELUP, ISTRGV, IENDGV
      REAL ( KIND = wp ) :: ZERO, GI, SCALEE
      LOGICAL :: NONTRV
!D    EXTERNAL         DSETVL, DSETVI

!  SET CONSTANT REAL PARAMETERS.

      PARAMETER ( ZERO = 0.0_wp )

!  INITIALIZE THE GRADIENT AS ZERO.

      CALL DSETVL( N, GRAD, 1, ZERO )

!  CONSIDER THE IG-TH GROUP.

      DO 160 IG = 1, NG
         IG1 = IG + 1
         ISTRGV = ISTAGV( IG )
         IENDGV = ISTAGV( IG1 ) - 1
         NELOW = ISTADG( IG )
         NELUP = ISTADG( IG1 ) - 1
         NONTRV = .NOT. GXEQX( IG )

!  COMPUTE THE FIRST DERIVATIVE OF THE GROUP.

         IF ( NONTRV ) THEN
            GI = GSCALE( IG ) * GVALS2( IG ) 
         ELSE
            GI = GSCALE( IG )
         END IF 

!  THIS IS THE FIRST GRADIENT EVALUATION OR THE GROUP HAS NONLINEAR
!  ELEMENTS.

         IF ( FIRSTG .OR. NELOW <= NELUP ) THEN
      CALL DSETVI( IENDGV - ISTRGV + 1, WKPVAR, ISVGRP( ISTRGV ), &
                         ZERO )

!  LOOP OVER THE GROUP'S NONLINEAR ELEMENTS.

            DO 30 II = NELOW, NELUP
               IEL = IELING( II )
               K = INTVAR( IEL )
               L = ISTAEV( IEL )
               NVAREL = ISTAEV( IEL + 1 ) - L
               SCALEE = ESCALE( II )
               IF ( INTREP( IEL ) ) THEN

!  THE IEL-TH ELEMENT HAS AN INTERNAL REPRESENTATION.

                  NIN = INTVAR( IEL + 1 ) - K
                  CALL RANGE ( IEL, .TRUE., GUVALS( K ), &
                               WKEVAR, NVAREL, NIN,  &
                               ITYPEE( IEL ), NIN, NVAREL )
!DIR$ IVDEP
                  DO 10 I = 1, NVAREL
                     J = IELVAR( L )
                     WKPVAR( J ) = WKPVAR( J ) + SCALEE * WKEVAR( I )
                     L = L + 1
   10             CONTINUE
               ELSE

!  THE IEL-TH ELEMENT HAS NO INTERNAL REPRESENTATION.

!DIR$ IVDEP
                  DO 20 I = 1, NVAREL
                     J = IELVAR( L )
                     WKPVAR( J ) = WKPVAR( J ) + SCALEE * GUVALS( K )
                     K = K + 1
                     L = L + 1
   20             CONTINUE
               END IF
   30       CONTINUE

!  INCLUDE THE CONTRIBUTION FROM THE LINEAR ELEMENT.

!DIR$ IVDEP
            DO 40 K = ISTADA( IG ), ISTADA( IG1 ) - 1
               J = ICNA( K )
               WKPVAR( J ) = WKPVAR( J ) + A( K )
   40       CONTINUE

!  FIND THE GRADIENT OF THE GROUP.

            IF ( NONTRV ) THEN

!  THE GROUP IS NON-TRIVIAL.

!DIR$ IVDEP
               DO 50 I = ISTRGV, IENDGV
                  LL = ISVGRP( I )
                  GRAD( LL ) = GRAD( LL ) + GI * WKPVAR( LL )

!  AS THE GROUP IS NON-TRIVIAL, ALSO STORE THE NONZERO ENTRIES OF THE
!  GRADIENT OF THE FUNCTION IN GRJAC.

                  JJ = ISTAJC( LL )
                  GRJAC( JJ ) = WKPVAR( LL )

!  INCREMENT THE ADDRESS FOR THE NEXT NONZERO IN THE COLUMN OF
!  THE JACOBIAN FOR VARIABLE LL.

                  ISTAJC( LL ) = JJ + 1
   50          CONTINUE
            ELSE

!  THE GROUP IS TRIVIAL.

!DIR$ IVDEP
               DO 60 I = ISTRGV, IENDGV
                  LL = ISVGRP( I )
                  GRAD( LL ) = GRAD( LL ) + GI * WKPVAR( LL )
   60          CONTINUE
            END IF

!  THIS IS NOT THE FIRST GRADIENT EVALUATION AND THERE IS ONLY A LINEAR
!  ELEMENT.

         ELSE

!  ADD THE GRADIENT OF THE LINEAR ELEMENT TO THE OVERALL GRADIENT

!DIR$ IVDEP
            DO 130 K = ISTADA( IG ), ISTADA( IG1 ) - 1
               LL = ICNA( K )
               GRAD( LL ) = GRAD( LL ) + GI * A( K )
  130       CONTINUE

!  THE GROUP IS NON-TRIVIAL; INCREMENT THE STARTING ADDRESSES FOR
!  THE GROUP  USED BY EACH VARIABLE IN THE (UNCHANGED) LINEAR
!  ELEMENT TO AVOID RESETTING THE NONZEROS IN THE JACOBIAN.

            IF ( NONTRV ) THEN
!DIR$ IVDEP
               DO 140 I = ISTRGV, IENDGV
                  LL = ISVGRP( I )
                  ISTAJC( LL ) = ISTAJC( LL ) + 1
  140          CONTINUE
            END IF
         END IF
  160 CONTINUE

!  RESET THE STARTING ADDRESSES FOR THE LISTS OF GROUP  USING
!  EACH VARIABLE TO THEIR VALUES ON ENTRY.

      DO 170 I = N, 2, - 1
         ISTAJC( I ) = ISTAJC( I - 1 )
  170 CONTINUE
      ISTAJC( 1 ) = 1
      RETURN

!  END OF ELGRD.

      END