#  package

PACKAGE = GEN77
package = gen77

$(PACKAGE) = $(OBJ)/gen77.o

GEN77 =  $(OBJ)/gen77.o  $(OBJ)/gen77_main.o

C_TEST = c_elfun.o c_group.o c_range.o

#  main compilations and runs

all: $(package)

#  basic packages

$(package): $($(PACKAGE))

#  basic packages

test: test77

test77: test77_$(PRECIS)
	@printf ' %-21s\n' "CUTEst: gen77 ($(PRECIS) $(SUCC)"
test77_single: $(GEN77)
test77_double: $(GEN77)

# run example tests

run_test: run_test77

run_test77: tools test_cutest test77
	echo " Test of unconstrained gen77"
	cd $(OBJ) ; $(FC) $(RUNFFLAGS) $(SPECIAL) -o run_test77 \
            gen77_main.o gen77.o $(U_TEST) -L$(OBJ) $(LIBS)
	ln -fs $(CUTEST)/src/test/u_OUTSDIF.d ../gen77/OUTSDIF.d
	- $(OBJ)/run_test77 >& ../gen77/u_test77.output
	cat ../gen77/u_test77.output
	rm $(OBJ)/run_test77 ../gen77/OUTSDIF.d
	echo " Test of constrained gen77"
	cd $(OBJ) ; $(FC) $(RUNFFLAGS) $(SPECIAL) -o run_test77 \
            gen77_main.o gen77.o $(C_TEST) -L$(OBJ) $(LIBS)
	ln -fs $(CUTEST)/src/test/c_OUTSDIF.d ../gen77/OUTSDIF.d
	- $(OBJ)/run_test77 >& ../gen77/c_test77.output
	cat ../gen77/c_test77.output
	rm $(OBJ)/run_test77 ../gen77/OUTSDIF.d

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

$(OBJ)/gen77.o: ../gen77/gen77.f
	$(SED) -f $(SEDS) ../gen77/gen77.f > $(OBJ)/gen77.f
	cd $(OBJ); $(FC) -o gen77.o $(FFLAGS) gen77.f
	$(RM) $(OBJ)/gen77.f

#  CUTEst interface main programs

$(OBJ)/gen77_main.o: ../gen77/gen77_main.f
	$(SED) -f $(SEDS) ../gen77/gen77_main.f > $(OBJ)/gen77_main.f
	cd $(OBJ); $(FC) -o gen77_main.o $(FFLAGS) gen77_main.f
	$(RM) $(OBJ)/gen77_main.f
