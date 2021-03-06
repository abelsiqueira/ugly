export OBJ=${OBJDIR}/${PRECIS}
export MOD=${MODDIR}/${PRECIS}
export PKG=${PKGDIR}/${PRECIS}

#  names of random libraries

export LC=$(OBJ)/libcutest.a
export BLC=$(OBJ)/libcutest_blas.a
export DLC=$(OBJ)/libcutest_dummy.a
export LLC=$(OBJ)/libcutest_lapack.a

#  Libraries used

export LIBS=-lcutest -lcutest_lapack -lcutest_blas
export PLIBS=$(LIBS) -lcutest_problem

#  Archive manipulation strings

export ARR=$(AR) -rc $(LC)
export RMARFILE=$(CUTEST)/bin/rmarfile $(AR) $(GREP) $(LC)
export RMOBFILE=$(CUTEST)/bin/rmobfile $(RM) $(OBJ)

export BARR=$(AR) -rc $(BLC)
export BRMARFILE=$(CUTEST)/bin/rmarfile $(AR) $(GREP) $(BLC)

export DARR=$(AR) -rc $(DLC)

export LARR=$(AR) -rc $(LLC)
export LRMARFILE=$(CUTEST)/bin/rmarfile $(AR) $(GREP) $(LLC)

#  sed scripts

export CSEDS=$(CUTEST)/seds/cutersize.sed

build: all

all: tools_${PRECIS}
	$(MAKE) -r -C algencan algencan
	$(MAKE) -r -C bobyqa bobyqa
	$(MAKE) -r -C cg_descent cg_descent
	$(MAKE) -r -C cgplus cgplus
	$(MAKE) -r -C cobyla cobyla
	#$(MAKE) -r -C derchk derchk
	#$(MAKE) -r -C dfo dfo
	#$(MAKE) -r -C directsearch directsearch
	#$(MAKE) -r -C filtersd filtersd
	#$(MAKE) -r -C filtersqp filtersqp
	$(MAKE) -r -C gen77 gen77
	#$(MAKE) -r -C gen90 gen90
	#$(MAKE) -C genc genc
	#$(MAKE) -r -C hrb hrb
	#$(MAKE) -r -C ipopt ipopt
	#$(MAKE) -r -C knitro knitro
	#$(MAKE) -r -C la04 la04
	#$(MAKE) -r -C lbfgs lbfgs
	#$(MAKE) -r -C lbfgsb lbfgsb
	#$(MAKE) -r -C lincoa lincoa
	#$(MAKE) -r -C loqo loqo
	#$(MAKE) -r -C minos minos
	#$(MAKE) -r -C newuoa newuoa
	#$(MAKE) -r -C nitsol nitsol
	#$(MAKE) -r -C nlpqlp nlpqlp
	#$(MAKE) -r -C npsol npsol
	#$(MAKE) -r -C pds pds
	#$(MAKE) -r -C pennlp pennlp
	#$(MAKE) -r -C praxis praxis
	#$(MAKE) -r -C ql ql
	#$(MAKE) -r -C qplib qplib
	#$(MAKE) -r -C snopt snopt
	#$(MAKE) -r -C spg spg
#	#$(MAKE) -r -C sqic #
	#$(MAKE) -r -C stats stats
	#$(MAKE) -r -C stenmin stenmin
	#$(MAKE) -r -C tenmin tenmin
	#$(MAKE) -r -C test test
	#$(MAKE) -r -C tron tron
	#$(MAKE) -r -C uncmin uncmin
	#$(MAKE) -r -C vf13 vf13

#  all tools (including tao) and interfaces

all_with_tao_$(PRECIS): all_${PRECIS}
	$(MAKE) -C tao tao

# all tools

tools_$(PRECIS):
	$(MAKE) -C tools

all_matlab_$(PRECIS): tools_${PRECIS}
	$(MAKE) -C matlab all

# all interface tests

test_$(PRECIS):
	$(MAKE) -C test test_cutest

# all unconstrained tools and interface tests

all_unconstrained_$(PRECIS):
	$(MAKE) -C tools cutest_unconstrained
	$(MAKE) -C test test_cutest_unconstrained

# all constrained tools and interface tests

all_constrained_$(PRECIS):
	$(MAKE) -C tools cutest_constrained
	$(MAKE) -C test test_cutest_constrained

# all tests

run_test_$(PRECIS): tools_${PRECIS} test_{PRECIS}
	$(MAKE) -C algencan run_test
	$(MAKE) -C bobyqa run_test
	$(MAKE) -C cg_descent run_test
	$(MAKE) -C cgplus run_test
	$(MAKE) -C cobyla run_test
	$(MAKE) -C derchk run_test
	$(MAKE) -C dfo run_test
	$(MAKE) -C filtersd run_test
	$(MAKE) -C filtersqp run_test
	$(MAKE) -C gen77 run_test
	$(MAKE) -C gen90 run_test
	$(MAKE) -C genc run_test
	$(MAKE) -C hrb run_test
	$(MAKE) -C ipopt run_test
	$(MAKE) -C knitro run_test
	$(MAKE) -C la04 run_test
	$(MAKE) -C lbfgs run_test
	$(MAKE) -C lbfgsb run_test
	$(MAKE) -C lincoa run_test
	$(MAKE) -C minos run_test
	$(MAKE) -C newuoa run_test
	$(MAKE) -C nitsol run_test
	$(MAKE) -C nlpqlp run_test
	$(MAKE) -C npsol run_test
	$(MAKE) -C pds run_test
	$(MAKE) -C pennlp run_test
	$(MAKE) -C praxis run_test
	$(MAKE) -C ql run_test
	$(MAKE) -C snopt run_test
	$(MAKE) -C spg run_test
#	$(MAKE) -C sqic #
	$(MAKE) -C stats run_test
	$(MAKE) -C stenmin run_test
	$(MAKE) -C tenmin run_test
	$(MAKE) -C tron run_test
	$(MAKE) -C uncmin run_test
	$(MAKE) -C vf13 run_test

clean:
	$(RM) -rf $(OBJ)

cleanall: clean
	$(RM) -rf ${MOD}
