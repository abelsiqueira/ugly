! THIS VERSION: CUTEST 1.1 - 22/08/2013 AT 13:30 GMT

!-*-*-*-*-  C U T E S T   C I N T _ C J P R O D    S U B R O U T I N E  -*-*-*-

!  Copyright reserved, Gould/Orban/Toint, for GALAHAD productions
!  Principal author: Nick Gould

!  History -
!   fortran 2003 version released in CUTEst, 21st August 2013

      SUBROUTINE CUTEST_Cint_cjprod( status, n, m, gotj, jtrans, X,            &
                                     VECTOR, lvector, RESULT, lresult )
      USE CUTEST
      USE, INTRINSIC :: ISO_C_BINDING, ONLY : C_Bool
      INTEGER, PARAMETER :: wp = KIND( 1.0D+0 )

!  dummy arguments

      INTEGER, INTENT( IN ) :: n, m, lvector, lresult
      INTEGER, INTENT( OUT ) :: status
      LOGICAL ( KIND = C_Bool ), INTENT( IN ) :: gotj, jtrans
      REAL ( KIND = wp ), INTENT( IN ), DIMENSION( n ) :: X
      REAL ( KIND = wp ), INTENT( IN ), DIMENSION( lvector ) :: VECTOR
      REAL ( KIND = wp ), INTENT( OUT ), DIMENSION( lresult ) :: RESULT

!   -------------------------------------------------------------------
!  compute the matrix-vector product between the Jacobian matrix of the
!  constraints (jtrans = .FALSE.), or its transpose (jtrans = .TRUE.) 
!  for the problem, and a given vector VECTOR. The result is placed in 
!  RESULT. If gotj is .TRUE. the first derivatives are assumed to have 
!  already been computed. If the user is unsure, set gotj = .FALSE. the 
!  first time a product is required with the Jacobian evaluated at X. 
!  X is not used if gotj = .TRUE.
!   -------------------------------------------------------------------

      LOGICAL :: gotj_fortran, jtrans_fortran

      gotj_fortran = gotj
      jtrans_fortran = jtrans
      CALL CUTEST_cjprod( status, n, m, gotj_fortran, jtrans_fortran, X,       &
                          VECTOR, lvector, RESULT, lresult )

      RETURN

!  end of subroutine CUTEST_Cint_cjprod

      END SUBROUTINE CUTEST_Cint_cjprod

!-*-*-*-*-*-*-  C U T E S T    C J P R O D    S U B R O U T I N E  -*-*-*-*-*-

!  Copyright reserved, Gould/Orban/Toint, for GALAHAD productions
!  Principal author: Nick Gould

!  History -
!   fortran 2003 version released in CUTEst, 29th December 2012

      SUBROUTINE CUTEST_cjprod( status, n, m, gotj, jtrans, X,                 &
                                VECTOR, lvector, RESULT, lresult )
      USE CUTEST
      INTEGER, PARAMETER :: wp = KIND( 1.0D+0 )

!  dummy arguments

      INTEGER, INTENT( IN ) :: n, m, lvector, lresult
      INTEGER, INTENT( OUT ) :: status
      LOGICAL, INTENT( IN ) :: gotj, jtrans
      REAL ( KIND = wp ), INTENT( IN ), DIMENSION( n ) :: X
      REAL ( KIND = wp ), INTENT( IN ), DIMENSION( lvector ) :: VECTOR
      REAL ( KIND = wp ), INTENT( OUT ), DIMENSION( lresult ) :: RESULT

!   -------------------------------------------------------------------
!  compute the matrix-vector product between the Jacobian matrix of the
!  constraints (jtrans = .FALSE.), or its transpose (jtrans = .TRUE.) 
!  for the problem, and a given vector VECTOR. The result is placed in 
!  RESULT. If gotj is .TRUE. the first derivatives are assumed to have 
!  already been computed. If the user is unsure, set gotj = .FALSE. the 
!  first time a product is required with the Jacobian evaluated at X. 
!  X is not used if gotj = .TRUE.
!   -------------------------------------------------------------------

      CALL CUTEST_cjprod_threadsafe( CUTEST_data_global,                       &
                                     CUTEST_work_global( 1 ),                  &
                                     status, n, m, gotj, jtrans, X,            &
                                     VECTOR, lvector, RESULT, lresult )
      RETURN

!  end of subroutine CUTEST_cjprod

      END SUBROUTINE CUTEST_cjprod

!-*-*-  C U T E S T   C J P R O D _ t h r e a d e d   S U B R O U T I N E  -*-*-

!  Copyright reserved, Gould/Orban/Toint, for GALAHAD productions
!  Principal author: Nick Gould

!  History -
!   fortran 2003 version released in CUTEst, 29th December 2012

      SUBROUTINE CUTEST_cjprod_threaded( status, n, m, gotj, jtrans, X,        &
                                         VECTOR, lvector, RESULT, lresult,     &
                                         thread )
      USE CUTEST
      INTEGER, PARAMETER :: wp = KIND( 1.0D+0 )

!  dummy arguments

      INTEGER, INTENT( IN ) :: n, m, lvector, lresult, thread
      INTEGER, INTENT( OUT ) :: status
      LOGICAL, INTENT( IN ) :: gotj, jtrans
      REAL ( KIND = wp ), INTENT( IN ), DIMENSION( n ) :: X
      REAL ( KIND = wp ), INTENT( IN ), DIMENSION( lvector ) :: VECTOR
      REAL ( KIND = wp ), INTENT( OUT ), DIMENSION( lresult ) :: RESULT

!   -------------------------------------------------------------------
!  compute the matrix-vector product between the Jacobian matrix of the
!  constraints (jtrans = .FALSE.), or its transpose (jtrans = .TRUE.) 
!  for the problem, and a given vector VECTOR. The result is placed in 
!  RESULT. If gotj is .TRUE. the first derivatives are assumed to have 
!  already been computed. If the user is unsure, set gotj = .FALSE. the 
!  first time a product is required with the Jacobian evaluated at X. 
!  X is not used if gotj = .TRUE.
!   -------------------------------------------------------------------

!  check that the specified thread is within range

      IF ( thread < 1 .OR. thread > CUTEST_data_global%threads ) THEN
        IF ( CUTEST_data_global%out > 0 )                                      &
          WRITE( CUTEST_data_global%out, "( ' ** CUTEST error: thread ', I0,   &
         &  ' out of range [1,', I0, ']' )" ) thread, CUTEST_data_global%threads
        status = 4 ; RETURN
      END IF

!  evaluate using specified thread

      CALL CUTEST_cjprod_threadsafe( CUTEST_data_global,                       &
                                     CUTEST_work_global( thread ),             &
                                     status, n, m, gotj, jtrans, X,            &
                                     VECTOR, lvector, RESULT, lresult )
      RETURN

!  end of subroutine CUTEST_cjprod_threaded

      END SUBROUTINE CUTEST_cjprod_threaded

!-*-  C U T E S T   C J P R O D _ t h r e a d s a f e   S U B R O U T I N E  -*-

!  Copyright reserved, Gould/Orban/Toint, for GALAHAD productions
!  Principal authors: Ingrid Bongartz and Nick Gould

!  History -
!   fortran 77 version originally released in CUTEr, June 2003
!   fortran 2003 version released in CUTEst, 28th November 2012

      SUBROUTINE CUTEST_cjprod_threadsafe( data, work, status, n, m, gotj,     &
                                           jtrans, X, VECTOR, lvector,         &
                                           RESULT, lresult )
      USE CUTEST
      INTEGER, PARAMETER :: wp = KIND( 1.0D+0 )

!  dummy arguments

      TYPE ( CUTEST_data_type ), INTENT( IN ) :: data
      TYPE ( CUTEST_work_type ), INTENT( INOUT ) :: work
      INTEGER, INTENT( IN ) :: n, m, lvector, lresult
      INTEGER, INTENT( OUT ) :: status
      LOGICAL, INTENT( IN ) :: gotj, jtrans
      REAL ( KIND = wp ), INTENT( IN ), DIMENSION( n ) :: X
      REAL ( KIND = wp ), INTENT( IN ), DIMENSION( lvector ) :: VECTOR
      REAL ( KIND = wp ), INTENT( OUT ), DIMENSION( lresult ) :: RESULT

!   -------------------------------------------------------------------
!  compute the matrix-vector product between the Jacobian matrix of the
!  constraints (jtrans = .FALSE.), or its transpose (jtrans = .TRUE.) 
!  for the problem, and a given vector VECTOR. The result is placed in 
!  RESULT. If gotj is .TRUE. the first derivatives are assumed to have 
!  already been computed. If the user is unsure, set gotj = .FALSE. the 
!  first time a product is required with the Jacobian evaluated at X. 
!  X is not used if gotj = .TRUE.
!   -------------------------------------------------------------------

!  local variables

      INTEGER :: i, ig, j, icon, k, ig1, ii
      INTEGER :: l, iel, nvarel, nin
      INTEGER :: ifstat, igstat
      REAL ( KIND = wp ) :: ftt, prod, scalee
      EXTERNAL :: RANGE 
      IF ( data%numcon == 0 ) RETURN

!  check input data

      IF ( ( jtrans .AND. lvector < m ) .OR.                                   &
             ( .NOT. jtrans .AND. lvector < n ) ) THEN
         IF ( data%out > 0 ) WRITE( data%out,                                  &
           "( ' ** SUBROUTINE CJPROD: Increase the size of VECTOR' )" )
         status = 2 ; RETURN
      END IF
      IF ( ( jtrans .AND. lresult < n ) .OR.                                   &
             ( .NOT. jtrans .AND. lresult < m ) ) THEN
         IF ( data%out > 0 ) WRITE( data%out,                                  &
           "( ' ** SUBROUTINE CJPROD: Increase the size of RESULT' )" )
         status = 2 ; RETURN
      END IF

!  there are non-trivial group functions

      IF ( .NOT. gotj ) THEN
         DO i = 1, MAX( data%nel, data%ng )
           work%ICALCF( i ) = i
         END DO

!  evaluate the element function values

        CALL ELFUN( work%FUVALS, X, data%EPVALU, data%nel, data%ITYPEE,        &
                    data%ISTAEV, data%IELVAR, data%INTVAR, data%ISTADH,        &
                    data%ISTEP, work%ICALCF, data%ltypee, data%lstaev,         &
                    data%lelvar, data%lntvar, data%lstadh, data%lstep,         &
                    data%lcalcf, data%lfuval, data%lvscal, data%lepvlu,        &
                    1, ifstat )
      IF ( ifstat /= 0 ) GO TO 930

!  evaluate the element function values

        CALL ELFUN( work%FUVALS, X, data%EPVALU, data%nel, data%ITYPEE,        &
                    data%ISTAEV, data%IELVAR, data%INTVAR, data%ISTADH,        &
                    data%ISTEP, work%ICALCF, data%ltypee, data%lstaev,         &
                    data%lelvar, data%lntvar, data%lstadh, data%lstep,         &
                    data%lcalcf, data%lfuval, data%lvscal, data%lepvlu,        &
                    3, ifstat )
      IF ( ifstat /= 0 ) GO TO 930

!  compute the group argument values ft

        DO ig = 1, data%ng
          ftt = - data%B( ig )

!  include the contribution from the linear element

          DO j = data%ISTADA( ig ), data%ISTADA( ig + 1 ) - 1
            ftt = ftt + data%A( j ) * X( data%ICNA( j ) )
          END DO

!  include the contributions from the nonlinear elements

          DO j = data%ISTADG( ig ), data%ISTADG( ig + 1 ) - 1
            ftt = ftt + data%ESCALE( j ) * work%FUVALS( data%IELING( J ) )
          END DO
          work%FT( ig ) = ftt

!  record the derivatives of trivial groups

          IF ( data%GXEQX( ig ) ) work%GVALS( ig, 2 ) = 1.0_wp
        END DO

!  evaluate the group derivative values

        IF ( .NOT. data%altriv ) THEN
          CALL GROUP( work%GVALS, data%ng, work%FT, data%GPVALU, data%ng,      &
                      data%ITYPEG, data%ISTGP, work%ICALCF, data%ltypeg,       &
                      data%lstgp, data%lcalcf, data%lcalcg, data%lgpvlu,       &
                      .TRUE., igstat )
         IF ( igstat /= 0 ) GO TO 930
        END IF
      END IF

!  form the product result = J(transpose) vector

      IF ( jtrans ) THEN

!  initialize RESULT

        RESULT( : n ) = 0.0_wp

!  consider the ig-th group

        DO ig = 1, data%ng
          icon = data%KNDOFC( ig )
          IF ( icon > 0 ) THEN
            ig1 = ig + 1

!  compute the product of vector(i) with the (scaled) group derivative

            IF ( data%GXEQX( ig ) ) THEN
              prod = VECTOR( icon ) * data%GSCALE( ig )
            ELSE
              prod = VECTOR( icon ) * data%GSCALE( ig ) * work%GVALS( ig, 2 )
            END IF

!  loop over the group's nonlinear elements

            DO ii = data%ISTADG( ig ), data%ISTADG( ig1 ) - 1
              iel = data%IELING( ii )
              k = data%INTVAR( iel )
              l = data%ISTAEV( iel )
              nvarel = data%ISTAEV( iel + 1 ) - l
              scalee = data%ESCALE( ii ) * prod
              IF ( data%INTREP( iel ) ) THEN

!  the iel-th element has an internal representation

                nin = data%INTVAR( iel + 1 ) - k
                CALL RANGE( iel, .TRUE., work%FUVALS( k ), work%W_el,          &
                            nvarel, nin, data%ITYPEE( iel ), nin, nvarel )
!DIR$ IVDEP
                DO i = 1, nvarel
                  j = data%IELVAR( l )
                  RESULT( j ) = RESULT( j ) + scalee * work%W_el( i )
                  l = l + 1
                END DO
              ELSE

!  the iel-th element has no internal representation

!DIR$ IVDEP
                DO i = 1, nvarel
                  j = data%IELVAR( l )
                  RESULT( j ) = RESULT( j ) + scalee * work%FUVALS( k )
                  k = k + 1 ; l = l + 1
                 END DO
              END IF
            END DO

!  include the contribution from the linear element

!DIR$ IVDEP
            DO k = data%ISTADA( ig ), data%ISTADA( ig1 ) - 1
              j = data%ICNA( k )
              RESULT( j ) = RESULT( j ) + data%A( k ) * prod
            END DO
          END IF
        END DO

!  Form the product result = J vector

      ELSE

!  consider the ig-th group

        DO ig = 1, data%ng
          icon = data%KNDOFC( ig )
          IF ( icon > 0 ) THEN
            ig1 = ig + 1
            prod = 0.0_wp

!  compute the first derivative of the group

!  loop over the group's nonlinear elements

            DO ii = data%ISTADG( ig ), data%ISTADG( ig1 ) - 1
              iel = data%IELING( ii )
              k = data%INTVAR( iel )
              l = data%ISTAEV( iel )
              nvarel = data%ISTAEV( iel + 1 ) - l
              scalee = data%ESCALE( ii )
              IF ( data%INTREP( iel ) ) THEN

!  the iel-th element has an internal representation

                nin = data%INTVAR( iel + 1 ) - k
                CALL RANGE( iel, .TRUE., work%FUVALS( k ), work%W_el,          &
                            nvarel, nin, data%ITYPEE( iel ), nin, nvarel )
!DIR$ IVDEP
                DO i = 1, nvarel
                  prod = prod                                                  &
                    + VECTOR( data%IELVAR( l ) ) * scalee * work%W_el( i )
                  l = l + 1
                END DO
              ELSE

!  the iel-th element has no internal representation

!DIR$ IVDEP
                DO i = 1, nvarel
                  prod = prod                                                  &
                    + VECTOR( data%IELVAR( l ) ) * scalee * work%FUVALS( k )
                  k = k + 1 ; l = l + 1
                END DO
              END IF
            END DO

!  include the contribution from the linear element

!DIR$ IVDEP
            DO k = data%ISTADA( ig ), data%ISTADA( ig1 ) - 1
              prod = prod + VECTOR( data%ICNA( k ) ) * data%A( k )
            END DO

!  multiply the product by the (scaled) group derivative

            IF ( data%GXEQX( ig ) ) THEN
              RESULT( icon ) = prod * data%GSCALE( ig )
            ELSE
              RESULT( icon ) = prod * data%GSCALE( ig ) * work%GVALS( ig, 2 )
            END IF
          END IF
        END DO
      END IF

!  update the counters for the report tool

      IF ( .NOT. gotj ) THEN
        work%nc2og = work%nc2og + 1
        work%nc2cg = work%nc2cg + work%pnc
      END IF
      status = 0
      RETURN

!  unsuccessful returns

  930 CONTINUE
      IF ( data%out > 0 ) WRITE( data%out,                                     &
        "( ' ** SUBROUTINE CJPROD: error flag raised during SIF evaluation' )" )
      status = 3
      RETURN

!  end of subroutine CUTEST_cjprod_threadsafe

      END SUBROUTINE CUTEST_cjprod_threadsafe
