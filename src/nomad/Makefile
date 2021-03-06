#  Main body of the installation makefile for CUTEst NOMAD interface

#  N. Gould, D. Orban and Ph. L. Toint.
#  This version: 25 IV 2013

#  package

PACKAGE = nomad
package = nomad

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

$(PACKAGE) = $(OBJ)/nomad_main.o

nomad_main =  $(OBJ)/nomad_main.o

#U_TEST = u_elfun.o u_group.o u_range.o
#C_TEST = c_elfun.o c_group.o c_range.o

SUCC = precision version) compiled successfully

#  main compilations and runs

all: $(package)

#  basic packages

$(package): $(package)_$(PRECIS)
	@printf ' %-21s\n' "CUTEst: $(package) ($(PRECIS) $(SUCC)"
$(package)_single: $($(PACKAGE))
$(package)_double: $($(PACKAGE))

#  basic packages

#test: testc

#testc: testc_$(PRECIS)
#    @printf ' %-21s\n' "CUTEst: nomad ($(PRECIS) $(SUCC)"
#testc_single: $(genc)
#testc_double: $(genc)

# run example tests

#run_test: run_testc

#run_testc: tools test_cutest testc
#    echo " Test of unconstrained genc"
#    cd $(OBJ) ; $(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_testc \
#            genc_main.o genc.o $(U_TEST) -L$(OBJ) $(LIBS)
#    ln -fs $(CUTEST)/src/test/u_OUTSDIF.d ../genc/OUTSDIF.d
#    - $(OBJ)/run_testc >& ../genc/u_testc.output
#    cat ../genc/u_testc.output
#    rm $(OBJ)/run_testc ../genc/OUTSDIF.d
#    echo " Test of constrained genc"
#    cd $(OBJ) ; $(FORTRAN) $(RUNFFLAGS) $(SPECIAL) -o run_testc \
#            genc_main.o genc.o $(C_TEST) -L$(OBJ) $(LIBS)
#    ln -fs $(CUTEST)/src/test/c_OUTSDIF.d ../genc/OUTSDIF.d
#    - $(OBJ)/run_testc >& ../genc/c_testc.output
#    cat ../genc/c_testc.output
#    rm $(OBJ)/run_testc ../genc/OUTSDIF.d

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

#$(OBJ)/genc.o: ../genc/genc.c
#    @printf ' %-9s %-15s\t\t' "Compiling" "genc"
#    $(SED) -f $(SEDS) ../genc/genc.c > $(OBJ)/genc.c
#    cd $(OBJ); $(CC) -o genc.o $(CFLAGS) genc.c \
#                || ( printf ' %-26s' "=> Disabling optimization " ; \
#                   $(CC) -o genc.o $(CFLAGSN) genc.c )
#    $(RM) $(OBJ)/genc.c
#    @printf '[ OK ]\n'

#  CUTEst interface main programs

$(OBJ)/nomad_main.o: ../nomad/nomad_main.c
	@printf ' %-9s %-15s\t\t' "Compiling" "nomad_main"
	$(SED) -f $(SEDS) ../nomad/nomad_main.c > $(OBJ)/nomad_main.c
	cd $(OBJ); $(CC) -o nomad_main.o $(CFLAGS) nomad_main.c \
                || ( printf ' %-26s' "=> Disabling optimization " ; \
                   $(CC) -o nomad_main.o $(CFLAGSN) nomad_main.c )
	$(RM) $(OBJ)/nomad_main.c
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

