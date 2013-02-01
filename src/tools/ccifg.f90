! THIS VERSION: CUTEST 1.0 - 29/12/2012 AT 13:05 GMT.

!-*-*-*-*-*-*-  C U T E S T    C C I F G    S U B R O U T I N E  -*-*-*-*-*-*-

!  Copyright reserved, Gould/Orban/Toint, for GALAHAD productions
!  Principal authors: Ingrid Bongartz and Nick Gould

!  History -
!   fortran 2003 version released in CUTEst, 29th December 2012

      SUBROUTINE CUTEST_ccifg( status, n, icon, X, ci, GCI, grad )
      USE CUTEST
      INTEGER, PARAMETER :: wp = KIND( 1.0D+0 )

!  dummy arguments

      INTEGER, INTENT( IN ) :: n, icon
      INTEGER, INTENT( OUT ) :: status
      LOGICAL, INTENT( IN ) :: grad
      REAL ( KIND = wp ), INTENT( OUT ) :: ci
      REAL ( KIND = wp ), INTENT( IN ), DIMENSION( n ) :: X
      REAL ( KIND = wp ), INTENT( OUT ), DIMENSION( n ) :: GCI

!  -----------------------------------------------------------------
!  evaluate constraint function icon and possibly its gradient, for
!  constraints initially written in Standard Input Format (SIF).  
!  The constraint gradient is stored as a dense vector in array GCI;
!  that is, GCI(j) is the partial derivative of constraint icon with 
!  respect to variable j. (Subroutine CSCIFG performs the same 
!  calculations for a sparse constraint gradient vector.)
!  -----------------------------------------------------------------

      CALL CUTEST_ccifg_threadsafe( CUTEST_data_global,                        &
                                    CUTEST_work_global( 1 ),                   &
                                    status, n, icon, X, ci, GCI, grad )
      RETURN

!  end of subroutine CUTEST_ccifg

      END SUBROUTINE CUTEST_ccifg

!-*-*-  C U T E S T    C C I F G _ t h r e a d e d   S U B R O U T I N E  -*-*-

!  Copyright reserved, Gould/Orban/Toint, for GALAHAD productions
!  Principal authors: Ingrid Bongartz and Nick Gould

!  History -
!   fortran 2003 version released in CUTEst, 29th December 2012

      SUBROUTINE CUTEST_ccifg_threaded( status, n, icon, X, ci, GCI, grad,     &
                                        thread )
      USE CUTEST
      INTEGER, PARAMETER :: wp = KIND( 1.0D+0 )

!  dummy arguments

      INTEGER, INTENT( IN ) :: n, icon, thread
      INTEGER, INTENT( OUT ) :: status
      LOGICAL, INTENT( IN ) :: grad
      REAL ( KIND = wp ), INTENT( OUT ) :: ci
      REAL ( KIND = wp ), INTENT( IN ), DIMENSION( n ) :: X
      REAL ( KIND = wp ), INTENT( OUT ), DIMENSION( n ) :: GCI

!  -----------------------------------------------------------------
!  evaluate constraint function icon and possibly its gradient, for
!  constraints initially written in Standard Input Format (SIF).  
!  The constraint gradient is stored as a dense vector in array GCI;
!  that is, GCI(j) is the partial derivative of constraint icon with 
!  respect to variable j. (Subroutine CSCIFG performs the same 
!  calculations for a sparse constraint gradient vector.)
!  -----------------------------------------------------------------

!  check that the specified thread is within range

      IF ( thread < 1 .OR. thread > CUTEST_data_global%threads ) THEN
        IF ( CUTEST_data_global%out > 0 )                                      &
          WRITE( CUTEST_data_global%out, "( ' ** CUTEST error: thread ', I0,   &
         &  ' out of range [1,', I0, ']' )" ) thread, CUTEST_data_global%threads
        status = 4 ; RETURN
      END IF

!  evaluate using specified thread

      CALL CUTEST_ccifg_threadsafe( CUTEST_data_global,                        &
                                    CUTEST_work_global( thread ),              &
                                    status, n, icon, X, ci, GCI, grad )
      RETURN

!  end of subroutine CUTEST_ccifg_threaded

      END SUBROUTINE CUTEST_ccifg_threaded

!-*-  C U T E S T    C C I F G _ t h r e a d s a f e   S U B R O U T I N E  -*-

!  Copyright reserved, Gould/Orban/Toint, for GALAHAD productions
!  Principal authors: Ingrid Bongartz and Nick Gould

!  History -
!   fortran 77 version originally released in CUTE, September 1994
!   fortran 2003 version released in CUTEst, 28th November 2012

      SUBROUTINE CUTEST_ccifg_threadsafe( data, work,                          &
                                          status, n, icon, X, ci, GCI, grad )
      USE CUTEST
      INTEGER, PARAMETER :: wp = KIND( 1.0D+0 )

!  dummy arguments

      TYPE ( CUTEST_data_type ), INTENT( IN ) :: data
      TYPE ( CUTEST_work_type ), INTENT( INOUT ) :: work
      INTEGER, INTENT( IN ) :: n, icon
      INTEGER, INTENT( OUT ) :: status
      LOGICAL, INTENT( IN ) :: grad
      REAL ( KIND = wp ), INTENT( OUT ) :: ci
      REAL ( KIND = wp ), INTENT( IN ), DIMENSION( n ) :: X
      REAL ( KIND = wp ), INTENT( OUT ), DIMENSION( n ) :: GCI

!  -----------------------------------------------------------------
!  evaluate constraint function icon and possibly its gradient, for
!  constraints initially written in Standard Input Format (SIF).  
!  The constraint gradient is stored as a dense vector in array GCI;
!  that is, GCI(j) is the partial derivative of constraint icon with 
!  respect to variable j. (Subroutine CSCIFG performs the same 
!  calculations for a sparse constraint gradient vector.)
!  -----------------------------------------------------------------

!  local variables

      INTEGER :: i, j, iel, k, ig, ii, ig1, l, ll, neling
      INTEGER :: nin, nvarel, nelow, nelup, istrgv, iendgv, ifstat, igstat
      REAL ( KIND = wp ) :: ftt, gi, scalee
      LOGICAL :: nontrv
      INTEGER, DIMENSION( 1 ) :: ICALCG
      EXTERNAL :: RANGE 

!  Return if there are no constraints.

      IF ( data%numcon == 0 ) RETURN

!  check input parameters

      IF ( icon <= 0 ) THEN
        IF ( data%out > 0 ) WRITE( data%out, "( ' ** SUBROUTINE CCIFG: ',      &
       &    'invalid constraint index icon ' )" )
        status = 2 ; RETURN
      END IF

!  find group index ig of constraint icon

      ig = 0
      DO i = 1, data%ng
        IF ( data%KNDOFC( i ) == icon ) THEN
          ig = i
          EXIT
        END IF
      END DO
      IF ( ig == 0 ) THEN
        IF ( data%out > 0 ) WRITE( data%out, "( ' ** SUBROUTINE CCIFG: ',      &
       &    'invalid constraint index icon ' )" )
        status = 2 ; RETURN
      END IF

!  determine nonlinear elements in group ig. Record their indices in ICALCF

      nelow = data%ISTADG( ig )
      nelup = data%ISTADG( ig + 1 ) - 1
      neling = nelup - nelow + 1
      j = nelow - 1
      DO i = 1, neling
        j = j + 1
        work%ICALCF( i ) = data%IELING( j )
      END DO

!  evaluate the element functions

      CALL ELFUN( work%FUVALS, X, data%EPVALU, neling, data%ITYPEE,            &
                  data%ISTAEV, data%IELVAR, data%INTVAR, data%ISTADH,          &
                  data%ISTEP, work%ICALCF, data%ltypee, data%lstaev,           &
                  data%lelvar, data%lntvar, data%lstadh, data%lstep,           &
                  data%lcalcf, data%lfuval, data%lvscal, data%lepvlu,          &
                  1, ifstat )
      IF ( ifstat /= 0 ) GO TO 930

!  compute the group argument value FTT. Consider only the group associated 
!  with constraint icon

      ftt = - data%B( ig )

!  include the contribution from the linear element only if the variable 
!  belongs to the first n variables

      DO i = data%ISTADA( ig ), data%ISTADA( ig + 1 ) - 1
        j = data%ICNA( i )
        IF ( j <= n ) ftt = ftt + data%A( i ) * X( j )
      END DO

!  Include the contributions from the nonlinear elements.

      DO i = nelow, nelup
         ftt = ftt + data%ESCALE( i ) * work%FUVALS( data%IELING( i ) )
      END DO
      work%FT( ig ) = ftt

!  If ig is a trivial group, record the function value and derivative.

      IF ( data%GXEQX( ig ) ) THEN
        work%GVALS( ig, 1 ) = work%FT( ig )
        work%GVALS( ig, 2 ) = 1.0_wp

!  otherwise, evaluate group ig

      ELSE
        ICALCG( 1 ) = ig
        CALL GROUP( work%GVALS, data%ng, work%FT, data%GPVALU, 1,              &
                    data%ITYPEG, data%ISTGP, ICALCG, data%ltypeg,              &
                    data%lstgp, 1, data%lcalcg, data%lgpvlu,                   &
                    .FALSE., igstat )
        IF ( igstat /= 0 ) GO TO 930
      END IF

!  Compute the constraint function value.

      IF ( data%GXEQX( ig ) ) THEN
        ci = data%GSCALE( ig ) * work%FT( ig )
      ELSE
        ci = data%GSCALE( ig ) * work%GVALS( ig, 1 )

!  Update the constraint function evaluation counter

        work%nc2cf = work%nc2cf + 1
      END IF
      IF ( grad ) THEN

!  Update the constraint gradient evaluation counter

        work%nc2cg = work%nc2cg + 1

!  evaluate the element function derivatives

        CALL ELFUN( work%FUVALS, X, data%EPVALU, neling, data%ITYPEE,          &
                    data%ISTAEV, data%IELVAR, data%INTVAR, data%ISTADH,        &
                    data%ISTEP, work%ICALCF, data%ltypee, data%lstaev,         &
                    data%lelvar, data%lntvar, data%lstadh, data%lstep,         &
                    data%lcalcf, data%lfuval, data%lvscal, data%lepvlu,        &
                    2, ifstat )
        IF ( ifstat /= 0 ) GO TO 930

!  evaluate the group derivative

        IF ( .NOT. data%GXEQX( ig ) ) THEN
          CALL GROUP( work%GVALS, data%ng, work%FT, data%GPVALU, 1,            &
                      data%ITYPEG, data%ISTGP, ICALCG, data%ltypeg,            &
                      data%lstgp, 1, data%lcalcg, data%lgpvlu,                 &
                      .TRUE., igstat )
          IF ( igstat /= 0 ) GO TO 930
        END IF

!  compute the gradient. Initialize the gradient vector as zero

        GCI( : n ) = 0.0_wp

!  consider only group ig

        ig1 = ig + 1
        istrgv = data%ISTAGV( ig )
        iendgv = data%ISTAGV( ig1 ) - 1
        nontrv = .NOT. data%GXEQX( ig )

!  compute the first derivative of the group

        gi = data%GSCALE( ig )
        IF ( nontrv ) gi = gi  * work%GVALS( ig, 2 )

!  the group has nonlinear elements

        IF ( nelow <= nelup ) THEN
          work%W_ws( data%ISVGRP( istrgv : iendgv ) ) = 0.0_wp

!  loop over the group's nonlinear elements

          DO ii = nelow, nelup
            iel = data%IELING( ii )
            k = data%INTVAR( iel )
            l = data%ISTAEV( iel )
            nvarel = data%ISTAEV( iel + 1 ) - l
            scalee = data%ESCALE( ii )

!  the iel-th element has an internal representation

            IF ( data%INTREP( iel ) ) THEN
              nin = data%INTVAR( iel + 1 ) - k
              CALL RANGE( iel, .TRUE., work%FUVALS( k ), work%W_el,            &
                          nvarel, nin, data%ITYPEE( iel ), nin, nvarel )
!DIR$ IVDEP
              DO i = 1, nvarel
                j = data%IELVAR( l )
                work%W_ws( j ) = work%W_ws( j ) + scalee * work%W_el( i )
                l = l + 1
              END DO

!  the iel-th element has no internal representation

            ELSE
!DIR$ IVDEP
              DO i = 1, nvarel
                j = data%IELVAR( l )
                work%W_ws( j ) = work%W_ws( j ) + scalee * work%FUVALS( k )
                k = k + 1 ; l = l + 1
              END DO
            END IF
          END DO

!  include the contribution from the linear element

!DIR$ IVDEP
          DO k = data%ISTADA( ig ), data%ISTADA( ig1 ) - 1
            j = data%ICNA( k )
            work%W_ws( j ) = work%W_ws( j ) + data%A( k )
          END DO

!  allocate a gradient

!DIR$ IVDEP
          DO i = istrgv, iendgv
            ll = data%ISVGRP( i )

!  include contributions from the first n variables only

            IF ( ll <= n ) GCI( ll ) = gi * work%W_ws( ll )
          END DO

!  the group has only linear elements

        ELSE

!  allocate a gradient

!DIR$ IVDEP
          DO k = data%ISTADA( ig ), data%ISTADA( ig1 ) - 1
            ll = data%ICNA( k )

!  include contributions from the first n variables only

            IF ( ll <= n ) GCI( ll ) = gi * data%A( k )
          END DO
        END IF
      END IF
      status = 0
      RETURN

!  unsuccessful returns

  930 CONTINUE
      IF ( data%out > 0 ) WRITE( data%out,                                     &
        "( ' ** SUBROUTINE CCIFG: error flag raised during SIF evaluation' )" )
      status = 3
      RETURN

!  end of subroutine CUTEST_ccifg_threadsafe

      END SUBROUTINE CUTEST_ccifg_threadsafe
