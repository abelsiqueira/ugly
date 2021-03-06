#  Main body of the installation makefile for CUTEst LOQO interface

#  N. Gould, D. Orban and Ph. L. Toint.
#  This version: 15 I 2013

#  package

PACKAGE = LOQO
package = loqo

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

$(PACKAGE) = $(OBJ)/$(package)_main.o
C_TEST = c_elfun.o c_group.o c_range.o

SUCC = precision version) compiled successfully

#  main compilations and runs

all: $(package)

#  basic packages

$(package): $(package)_$(PRECIS)
	@printf ' %-21s\n' "CUTEst: $(package) ($(PRECIS) $(SUCC)" 
$(package)_single: $($(PACKAGE))
$(package)_double: $($(PACKAGE))

# run example tests

run_test: 
	echo " No $(PACKAGE) test program at the moment"

run_test_todo: tools test_cutest $(OBJ)/$(package)_main.o
	echo " Test of constrained $(package)"
	cd $(OBJ) ; $(CC) -o run_test \
            $(package)_main.o $(C_TEST) -L$(OBJ) $(LIBS)  $(CRUNFFLAGS)
	ln -fs $(CUTEST)/src/test/c_OUTSDIF.d ../$(package)/OUTSDIF.d
	- $(OBJ)/run_test >& ../$(package)/c_test.output
	cat ../$(package)/c_test.output
	rm $(OBJ)/run_test ../$(package)/OUTSDIF.d

test_cutest:
	( cd ../test ; $(MAKE) -f $(CUTEST)/makefiles/$(VERSION) \
            test_cutest PRECIS=$(PRECIS) PWD=$(PWD)/../test )
tools: 
	( cd ../tools ; $(MAKE) -f $(CUTEST)/makefiles/$(VERSION) \
                     cutest PRECIS=$(PRECIS) PWD=$(PWD)/../tools )
utools: 
	( cd ../tools ; $(MAKE) -f $(CUTEST)/makefiles/$(VERSION) \
                     cutest_unconstrained PRECIS=$(PRECIS) PWD=$(PWD)/../tools )
ctools: 
	( cd ../tools ; $(MAKE) -f $(CUTEST)/makefiles/$(VERSION) \
                     cutest_constrained PRECIS=$(PRECIS) PWD=$(PWD)/../tools )

#  CUTEst interface main programs

$(OBJ)/$(package)_main.o: ../$(package)/$(package)_main.c
	@printf ' %-9s %-15s\t\t' "Compiling" "$(package)_main" 
	$(SED) -f $(SEDS) ../$(package)/$(package)_main.c > \
          $(OBJ)/$(package)_main.c
	-cd $(OBJ); $(CC) -o $(package)_main.o $(CFLAGS) $(package)_main.c \
              || ( printf ' %-26s' "=> Disabling optimization " ; \
               $(CC) -o $(package)_main.o $(CFLAGSN) $(package)_main.c )
	$(RM) $(OBJ)/$(package)_main.c
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

