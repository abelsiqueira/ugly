#  package

PACKAGE = BOBYQA
package = bobyqa

$(PACKAGE) = $(OBJ)/$(package)_main.o
U_TEST = u_elfun.o u_group.o u_range.o

#  main compilations and runs

all: $(package)

#  basic packages

$(package): $($(PACKAGE))

# run example tests

run_test: tools test_cutest_constrained $(package) $(OBJ)/$(package)_test.o
	echo " Test of unconstrained $(package)"
	cd $(OBJ) ; $(FC) $(RUNFFLAGS) $(SPECIAL) -o run_test \
            $(package)_main.o $(package)_test.o $(U_TEST) -L$(OBJ) $(LIBS)
	ln -fs $(CUTEST)/src/test/u_OUTSDIF.d ../$(package)/OUTSDIF.d
	- $(OBJ)/run_test >& ../$(package)/u_test.output
	cat ../$(package)/u_test.output
	rm $(OBJ)/run_test ../$(package)/OUTSDIF.d

test_cutest_constrained:
	$(MAKE) -C ../test test_cutest_constrained
tools: 
	$(MAKE) -C ../tools cutest
utools: 
	$(MAKE) -C ../tools cutest_unconstrained
ctools: 
	$(MAKE) -C ../tools cutest_constrained

#  individual compilations

$(OBJ)/$(package)_test.o: $(package)_test.f90
	$(SED) -f $(SEDS) $(package)_test.f90 > \
          $(OBJ)/$(package)_test.f90
	cd $(OBJ); $(FC) -o $(package)_test.o $(FFLAGS) \
          $(package)_test.f90
	$(RM) $(OBJ)/$(package)_test.f90

#  CUTEst interface main programs

$(OBJ)/$(package)_main.o: $(package)_main.f90
	$(SED) -f $(SEDS) $(package)_main.f90 > \
          $(OBJ)/$(package)_main.f90
	cd $(OBJ); $(FC) -o $(package)_main.o $(FFLAGS) \
             $(package)_main.f90
	$(RM) $(OBJ)/$(package)_main.f90
