#  Main body of the installation makefile for CUTEST test programs

#  N. Gould, D. Orban and Ph. L. Toint.
#  This version: 19 XI 2012

#  package

PACKAGE = TEST
package = test

SHELL = /bin/$(BINSHELL)

#  compiler flags

FFLAGS    = $(BASIC) $(OPTIMIZATION) $(DEBUG) $(MODULES) $(F90) $(USUAL)
FFLAGSS   = $(BASIC) $(OPTIMIZATION) $(DEBUG) $(MODULES) $(F90) $(SPECIAL)
FFLAGSN   = $(BASIC) $(NOOPTIMIZATION) $(DEBUG) $(MODULES) $(F90)
FFLAGS77  = $(BASIC) $(OPTIMIZATION) $(DEBUG) $(MODULES) $(F77) $(USUAL)
FFLAGS77S = $(BASIC) $(OPTIMIZATION) $(DEBUG) $(MODULES) $(F77) $(SPECIAL)
FFLAGS7N  = $(BASIC) $(NOOPTIMIZATION) $(DEBUG) $(MODULES) $(F77) $(USUAL)
RUNFFLAGS =          $(OPTIMIZATION) $(DEBUG) $(MODULES)

#  names of random libraries

LC  = $(OBJ)/libcutest.a
LCS = $(OBJS)/libcutest.a
LCD = $(OBJD)/libcutest.a

BLC  = $(OBJ)/libcutest_blas.a
BLCS = $(OBJS)/libcutest_blas.a
BLCD = $(OBJD)/libcutest_blas.a

DLC  = $(OBJ)/libcutest_dummy.a
DLCS = $(OBJS)/libcutest_dummy.a
DLCD = $(OBJD)/libcutest_dummy.a

LLC  = $(OBJ)/libcutest_lapack.a
LLCS = $(OBJS)/libcutest_lapack.a
LLCD = $(OBJD)/libcutest_lapack.a

#  Libraries used

#LIBS = -lcutest -lcutest_lapack -lcutest_blas
LIBS = -lcutest
PLIBS = $(LIBS) -lcutest_problem

#  Archive manipulation strings

ARR = $(AR) -rc $(LC)
RMARFILE = $(CUTEST)/bin/rmarfile $(AR) $(GREP) $(LC)
RMOBFILE = $(CUTEST)/bin/rmobfile $(RM) $(OBJ)

BARR = $(AR) -rc $(BLC)
BRMARFILE = $(CUTEST)/bin/rmarfile $(AR) $(GREP) $(BLC)

DARR = $(AR) -rc $(DLC)

LARR = $(AR) -rc $(LLC)
LRMARFILE = $(CUTEST)/bin/rmarfile $(AR) $(GREP) $(LLC)

#  sed scripts

CSEDS = $(CUTEST)/seds/cutersize.sed

#  compilation agenda

#U_TEST = $(OBJ)/u_elfun.o $(OBJ)/u_group.o $(OBJ)/u_range.o $(OBJ)/u_exter.o
#C_TEST = $(OBJ)/c_elfun.o $(OBJ)/c_group.o $(OBJ)/c_range.o $(OBJ)/c_exter.o
U_TEST = $(OBJ)/u_elfun.o $(OBJ)/u_group.o $(OBJ)/u_range.o
C_TEST = $(OBJ)/c_elfun.o $(OBJ)/c_group.o $(OBJ)/c_range.o
Q_TEST = $(OBJ)/q_elfun.o $(OBJ)/q_group.o $(OBJ)/q_range.o

SUCC = precision version) compiled successfully

#  main compilations and runs

all: $(package)

#  basic packages

$(package): $(package)_$(PRECIS)
	@printf ' %-21s\n' "CUTEst: $(package) ($(PRECIS) $(SUCC)" 
$(package)_single: $(OBJ)/$(package)_main.o 
$(package)_double: $(OBJ)/$(package)_main.o

test_cutest: test_cutest_$(PRECIS)
	@printf ' %-21s\n' "CUTEST: tests ($(PRECIS) $(SUCC)" 

test_cutest_single: test_cutest_unconstrained_single \
                    test_cutest_constrained_single

test_cutest_double: test_cutest_unconstrained_double \
                    test_cutest_constrained_double

test_cutest_unconstrained: test_cutest_unconstrained_$(PRECIS)
	@printf ' %-21s\n' "CUTEST: unconstrained tests ($(PRECIS) $(SUCC)" 

test_cutest_unconstrained_single: $(U_TEST)

test_cutest_unconstrained_double: $(U_TEST)

test_cutest_constrained: test_cutest_constrained_$(PRECIS)
	@printf ' %-21s\n' "CUTEST: constrained tests ($(PRECIS) $(SUCC)" 

test_cutest_constrained_single: $(C_TEST)

test_cutest_constrained_double: $(C_TEST)

test_cutest_quadratic: test_cutest_quadratic_$(PRECIS)
	@printf ' %-21s\n' "CUTEST: quadratic tests ($(PRECIS) $(SUCC)" 

test_cutest_quadratic_single: $(Q_TEST)

test_cutest_quadratic_double: $(Q_TEST)

# run example tests

run_test_cutest: run_test_cutest_unconstrained run_test_cutest_constrained
run_test_threaded_cutest: run_test_cutest_threaded_unconstrained run_test_cutest_threaded_constrained

run_test_cutest_unconstrained: utools test_cutest_unconstrained
	echo " Exhaustive test of unconstrained tools"
	$(SED) -f $(SEDS) ../test/utest.f90 > $(OBJ)/utest.f90
#	echo "$(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
#            $(U_TEST) utest.f90 -L$(OBJ) $(LIBS)"
	cd $(OBJ) ; $(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
            $(U_TEST) utest.f90 -L$(OBJ) $(LIBS)
#	- $(OBJ)/run_test
	- $(OBJ)/run_test >& ../test/test_unc.output
	cat ../test/test_unc.output
	rm $(OBJ)/run_test

run_test_cutest_constrained: ctools test_cutest_constrained
	echo " Exhaustive test of constrained tools"
	$(SED) -f $(SEDS) ../test/ctest.f90 > $(OBJ)/ctest.f90
	cd $(OBJ) ; echo "$(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
            $(C_TEST) ctest.f90 -L$(OBJ) $(LIBS)"
	cd $(OBJ) ; $(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
            $(C_TEST) ctest.f90 -L$(OBJ) $(LIBS)
#	- $(OBJ)/run_test
	- $(OBJ)/run_test >& ../test/test_con.output
	cat ../test/test_con.output
	rm $(OBJ)/run_test

run_test_cutest_threaded_unconstrained: utools test_cutest_unconstrained
	echo " Exhaustive test of unconstrained threaded tools"
	$(SED) -f $(SEDS) ../test/utest_threaded.f90 > $(OBJ)/utest_threaded.f90
#	echo "$(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
#            $(U_TEST) utest_threaded.f90 -L$(OBJ) $(LIBS)"
	cd $(OBJ) ; $(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
            $(U_TEST) utest_threaded.f90 -L$(OBJ) $(LIBS)
#	- $(OBJ)/run_test
	- $(OBJ)/run_test >& ../test/test_unc_threaded.output
	cat ../test/test_unc_threaded.output
	rm $(OBJ)/run_test

run_test_cutest_threaded_constrained: ctools test_cutest_constrained
	echo " Exhaustive test of constrained threaded tools"
	$(SED) -f $(SEDS) ../test/ctest_threaded.f90 > $(OBJ)/ctest_threaded.f90
	cd $(OBJ) ; echo "$(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
            $(C_TEST) ctest_threaded.f90 -L$(OBJ) $(LIBS)"
	cd $(OBJ) ; $(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
            $(C_TEST) ctest_threaded.f90 -L$(OBJ) $(LIBS)
#	- $(OBJ)/run_test
	- $(OBJ)/run_test >& ../test/test_con_threaded.output
	cat ../test/test_con_threaded.output
	rm $(OBJ)/run_test

run_test_cuter_unconstrained: test_cutest_unconstrained
	echo " Exhaustive test of ** CUTEr ** unconstrained tools"
	$(SED) -f $(SEDS) ../test/ucutertest.f90 > $(OBJ)/ucutertest.f90
	cd $(OBJ) ; $(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
            $(U_TEST) ucutertest.f90 -L$(CUTERUSED)/double/lib -lcuter -lblas
#	- $(OBJ)/run_test
	- $(OBJ)/run_test >& ../test/test_unc_cuter.output
	cat ../test/test_unc_cuter.output
	rm $(OBJ)/run_test

run_test_cuter_constrained: test_cutest_constrained
	echo " Exhaustive test of ** CUTEr ** constrained tools"
	$(SED) -f $(SEDS) ../test/ccutertest.f90 > $(OBJ)/ccutertest.f90
	cd $(OBJ) ; $(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
            $(U_TEST) ccutertest.f90 -L$(CUTERUSED)/double/lib -lcuter -lblas
#	- $(OBJ)/run_test
	- $(OBJ)/run_test >& ../test/test_con_cuter.output
	cat ../test/test_con_cuter.output
	rm $(OBJ)/run_test

run_test_cutest_constrained_debug: ctools test_cutest_constrained
	echo " Exhaustive test of constrained tools"
	$(SED) -f $(SEDS) ../test/ctest_debug.f90 > $(OBJ)/ctest_debug.f90
	cd $(OBJ) ; echo "$(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
            $(C_TEST) ctest_debug.f90 -L$(OBJ) $(LIBS)"
	cd $(OBJ) ; $(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
            $(C_TEST) ctest_debug.f90 -L$(OBJ) $(LIBS)
	- $(OBJ)/run_test
#	- $(OBJ)/run_test >& ../test/test_con.output
#	cat ../test/test_con.output
	rm $(OBJ)/run_test $(OBJ)/ctest_debug.f90

run_lqp_test: ctools test_cutest_quadratic
	echo " Exhaustive test of constrained tools"
	$(SED) -f $(SEDS) ../test/lqptest.f90 > $(OBJ)/lqptest.f90
	cd $(OBJ) ; echo "$(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
            $(Q_TEST) lqptest.f90 -L$(OBJ) $(LIBS)"
	cd $(OBJ) ; $(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test \
            $(Q_TEST) lqptest.f90 -L$(OBJ) $(LIBS)
#	- $(OBJ)/run_test
	- $(OBJ)/run_test >& ../test/test_lqp.output
	cat ../test/test_lqp.output
	rm $(OBJ)/run_test

tools: 
	( cd ../tools ; $(MAKE) -f $(CUTEST)/makefiles/$(VERSION) \
                     cutest PRECIS=$(PRECIS) PWD=$(PWD)/../tools )
utools: 
	( cd ../tools ; $(MAKE) -f $(CUTEST)/makefiles/$(VERSION) \
                     cutest_unconstrained PRECIS=$(PRECIS) PWD=$(PWD)/../tools )
ctools: 
	( cd ../tools ; $(MAKE) -f $(CUTEST)/makefiles/$(VERSION) \
                     cutest_constrained PRECIS=$(PRECIS) PWD=$(PWD)/../tools )

#  individual compilations

$(OBJ)/u_elfun.o: ../test/u_elfun.f
	@printf ' %-9s %-15s\t\t' "Compiling" "u_elfun" 
	$(SED) -f $(SEDS) ../test/u_elfun.f > $(OBJ)/u_elfun.f
	cd $(OBJ); $(FORTRAN) -o u_elfun.o $(FFLAGS77) u_elfun.f \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(FORTRAN) -o u_elfun.o $(FFLAGS77N) u_elfun.f )
	$(RM) $(OBJ)/u_elfun.f
	@printf '[ OK ]\n'

$(OBJ)/u_group.o: ../test/u_group.f
	@printf ' %-9s %-15s\t\t' "Compiling" "u_group" 
	$(SED) -f $(SEDS) ../test/u_group.f > $(OBJ)/u_group.f
	cd $(OBJ); $(FORTRAN) -o u_group.o $(FFLAGS77) u_group.f \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(FORTRAN) -o u_group.o $(FFLAGS77N) u_group.f )
	$(RM) $(OBJ)/u_group.f
	@printf '[ OK ]\n'

$(OBJ)/u_range.o: ../test/u_range.f
	@printf ' %-9s %-15s\t\t' "Compiling" "u_range" 
	$(SED) -f $(SEDS) ../test/u_range.f > $(OBJ)/u_range.f
	cd $(OBJ); $(FORTRAN) -o u_range.o $(FFLAGS77) u_range.f \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(FORTRAN) -o u_range.o $(FFLAGS77N) u_range.f )
	$(RM) $(OBJ)/u_range.f
	@printf '[ OK ]\n'

$(OBJ)/u_exter.o: ../test/u_exter.f
	@printf ' %-9s %-15s\t\t' "Compiling" "u_exter" 
	$(SED) -f $(SEDS) ../test/u_exter.f > $(OBJ)/u_exter.f
	cd $(OBJ); $(FORTRAN) -o u_exter.o $(FFLAGS77) u_exter.f \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(FORTRAN) -o u_exter.o $(FFLAGS77N) u_exter.f )
	$(RM) $(OBJ)/u_exter.f
	@printf '[ OK ]\n'

$(OBJ)/c_elfun.o: ../test/c_elfun.f
	@printf ' %-9s %-15s\t\t' "Compiling" "c_elfun" 
	$(SED) -f $(SEDS) ../test/c_elfun.f > $(OBJ)/c_elfun.f
	cd $(OBJ); $(FORTRAN) -o c_elfun.o $(FFLAGS77) c_elfun.f \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(FORTRAN) -o c_elfun.o $(FFLAGS77N) c_elfun.f )
	$(RM) $(OBJ)/c_elfun.f
	@printf '[ OK ]\n'

$(OBJ)/c_group.o: ../test/c_group.f
	@printf ' %-9s %-15s\t\t' "Compiling" "c_group" 
	$(SED) -f $(SEDS) ../test/c_group.f > $(OBJ)/c_group.f
	cd $(OBJ); $(FORTRAN) -o c_group.o $(FFLAGS77) c_group.f \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(FORTRAN) -o c_group.o $(FFLAGS77N) c_group.f )
	$(RM) $(OBJ)/c_group.f
	@printf '[ OK ]\n'

$(OBJ)/c_range.o: ../test/c_range.f
	@printf ' %-9s %-15s\t\t' "Compiling" "c_range" 
	$(SED) -f $(SEDS) ../test/c_range.f > $(OBJ)/c_range.f
	cd $(OBJ); $(FORTRAN) -o c_range.o $(FFLAGS77) c_range.f \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(FORTRAN) -o c_range.o $(FFLAGS77N) c_range.f )
	$(RM) $(OBJ)/c_range.f
	@printf '[ OK ]\n'

$(OBJ)/c_exter.o: ../test/c_exter.f
	@printf ' %-9s %-15s\t\t' "Compiling" "c_exter" 
	$(SED) -f $(SEDS) ../test/c_exter.f > $(OBJ)/c_exter.f
	cd $(OBJ); $(FORTRAN) -o c_exter.o $(FFLAGS77) c_exter.f \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(FORTRAN) -o c_exter.o $(FFLAGS77N) c_exter.f )
	$(RM) $(OBJ)/c_exter.f
	@printf '[ OK ]\n'

$(OBJ)/q_elfun.o: ../test/q_elfun.f
	@printf ' %-9s %-15s\t\t' "Compiling" "q_elfun" 
	$(SED) -f $(SEDS) ../test/q_elfun.f > $(OBJ)/q_elfun.f
	cd $(OBJ); $(FORTRAN) -o q_elfun.o $(FFLAGS77) q_elfun.f \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(FORTRAN) -o q_elfun.o $(FFLAGS77N) q_elfun.f )
	$(RM) $(OBJ)/q_elfun.f
	@printf '[ OK ]\n'

$(OBJ)/q_group.o: ../test/q_group.f
	@printf ' %-9s %-15s\t\t' "Compiling" "q_group" 
	$(SED) -f $(SEDS) ../test/q_group.f > $(OBJ)/q_group.f
	cd $(OBJ); $(FORTRAN) -o q_group.o $(FFLAGS77) q_group.f \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(FORTRAN) -o q_group.o $(FFLAGS77N) q_group.f )
	$(RM) $(OBJ)/q_group.f
	@printf '[ OK ]\n'

$(OBJ)/q_range.o: ../test/q_range.f
	@printf ' %-9s %-15s\t\t' "Compiling" "q_range" 
	$(SED) -f $(SEDS) ../test/q_range.f > $(OBJ)/q_range.f
	cd $(OBJ); $(FORTRAN) -o q_range.o $(FFLAGS77) q_range.f \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(FORTRAN) -o q_range.o $(FFLAGS77N) q_range.f )
	$(RM) $(OBJ)/q_range.f
	@printf '[ OK ]\n'

#  CUTEst interface main programs

$(OBJ)/$(package)_main.o: ../$(package)/$(package)_main.f90
	@printf ' %-9s %-15s\t\t' "Compiling" "$(package)_main" 
	$(SED) -f $(SEDS) ../$(package)/$(package)_main.f90 > \
          $(OBJ)/$(package)_main.f90
	cd $(OBJ); $(FORTRAN) -o $(package)_main.o $(FFLAGS) \
             $(package)_main.f90 \
              || ( printf ' %-26s' "=> Disabling optimization " ; \
              $(FORTRAN) -o $(package)_main.o $(FFLAGS77N) $(package)_main.f90 )
	$(RM) $(OBJ)/$(package)_main.f90 $(OBJ)/*.mod
	@printf '[ OK ]\n'

#  book keeping

clean: 
	@printf ' %-9s\t\t' "Cleaning" 
	$(RM) $(OBJ)/*
	@printf '[ OK ]\n'

cleanall: 
	@printf ' %-14s\t\t' \
          "Removing all $(PRECIS) precision object and module files" 
	$(RM) $(OBJ)/* $(MOD)/*
	@printf '[ OK ]\n'

