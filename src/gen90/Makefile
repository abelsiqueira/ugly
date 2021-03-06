#  Main body of the installation makefile for CUTEst GEN programs

#  N. Gould, D. Orban and Ph. L. Toint.
#  This version: 3 I 2013

#  package

PACKAGE = gen90
package = gen90

SHELL = /bin/$(BINSHELL)

#  compiler flags

FFLAGS    = $(BASIC) $(OPTIMIZATION) $(DEBUG) $(MODULES) $(F90) $(USUAL)
FFLAGSS   = $(BASIC) $(OPTIMIZATION) $(DEBUG) $(MODULES) $(F90) $(SPECIAL)
FFLAGSN   = $(BASIC) $(NOOPTIMIZATION) $(DEBUG) $(MODULES) $(F90)
FFLAGS77  = $(BASIC) $(OPTIMIZATION) $(DEBUG) $(MODULES) $(F77) $(USUAL)
FFLAGS77S = $(BASIC) $(OPTIMIZATION) $(DEBUG) $(MODULES) $(F77) $(SPECIAL)
FFLAGS7N  = $(BASIC) $(NOOPTIMIZATION) $(DEBUG) $(MODULES) $(F77) $(USUAL)
RUNFFLAGS =          $(OPTIMIZATION) $(DEBUG) $(MODULES)

CFLAGS    = $(CCBASIC) $(OPTIMIZATION) $(CCDEBUG) -I$(CUTEST)/include
CFLAGSN   = $(CCBASIC) $(NOOPTIMIZATION) $(CCDEBUG) -I$(CUTEST)/include
CRUNFFLAGS = $(OPTIMIZATION) $(CCDEBUG) -I$(CUTEST)/include $(CCFFLAGS)

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

#  compilation agenda

$(PACKAGE) = $(OBJ)/$(package).o $(OBJ)/$(package)_main.o
gen90 =  $(OBJ)/gen90.o  $(OBJ)/gen90_main.o

U_TEST = u_elfun.o u_group.o u_range.o
C_TEST = c_elfun.o c_group.o c_range.o

SUCC = precision version) compiled successfully

#  main compilations and runs

all: $(package)

#  basic packages

$(package): $(package)_$(PRECIS)
	@printf ' %-21s\n' "CUTEst: $(package) ($(PRECIS) $(SUCC)"
$(package)_single: $($(PACKAGE))
$(package)_double: $($(PACKAGE))

#  basic packages

test: test90

test90: test90_$(PRECIS)
	@printf ' %-21s\n' "CUTEst: gen90 ($(PRECIS) $(SUCC)"
test90_single: $(gen90)
test90_double: $(gen90)

# run example tests

run_test: run_test90

run_test90: tools test_cutest test90
	echo " Test of unconstrained gen90"
	cd $(OBJ) ; $(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test90 \
            gen90_main.o gen90.o $(U_TEST) -L$(OBJ) $(LIBS)
	ln -fs $(CUTEST)/src/test/u_OUTSDIF.d ../gen90/OUTSDIF.d
	- $(OBJ)/run_test90 >& ../gen90/u_test90.output
	cat ../gen90/u_test90.output
	rm $(OBJ)/run_test90 ../gen90/OUTSDIF.d
	echo " Test of constrained gen90"
	cd $(OBJ) ; $(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_test90 \
            gen90_main.o gen90.o $(C_TEST) -L$(OBJ) $(LIBS)
	ln -fs $(CUTEST)/src/test/c_OUTSDIF.d ../gen90/OUTSDIF.d
	- $(OBJ)/run_test90 >& ../gen90/c_test90.output
	cat ../gen90/c_test90.output
	rm $(OBJ)/run_test90 ../gen90/OUTSDIF.d

test_cutest:
	( cd ../test ; $(MAKE) -f $(CUTEST)/makefiles/$(VERSION) \
                     test_cutest PRECIS=$(PRECIS) PWD=$(PWD)/../test )
test_cutest_unconstrained:
	( cd ../test ; $(MAKE) -f $(CUTEST)/makefiles/$(VERSION) \
            test_cutest_unconstrained PRECIS=$(PRECIS) PWD=$(PWD)/../test )
test_cutest_constrained:
	( cd ../test ; $(MAKE) -f $(CUTEST)/makefiles/$(VERSION) \
            test_cutest_constrained PRECIS=$(PRECIS) PWD=$(PWD)/../test )
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

$(OBJ)/gen90.o: ../gen90/gen90.f90
	@printf ' %-9s %-15s\t\t' "Compiling" "gen90"
	$(SED) -f $(SEDS) ../gen90/gen90.f90 > $(OBJ)/gen90.f90
	cd $(OBJ); $(FORTRAN) -o gen90.o $(FFLAGS) gen90.f90 \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(FORTRAN) -o gen90.o $(FFLAGSN) gen90.f90 )
	$(RM) $(OBJ)/gen90.f90
	@printf '[ OK ]\n'

#  CUTEst interface main programs

$(OBJ)/gen90_main.o: ../gen90/gen90_main.f90
	@printf ' %-9s %-15s\t\t' "Compiling" "gen90_main"
	$(SED) -f $(SEDS) ../gen90/gen90_main.f90 > $(OBJ)/gen90_main.f90
	cd $(OBJ); $(FORTRAN) -o gen90_main.o $(FFLAGS) gen90_main.f90 \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(FORTRAN) -o gen90_main.o $(FFLAGSN) gen90_main.f90 )
	$(RM) $(OBJ)/gen90_main.f90
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

