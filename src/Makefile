OBJS=${OBJDIR}/single
OBJS=${OBJDIR}/double
MOD=${MODDIR}/$(PRECIS)

build: all

all: tools_${PRECIS}
	$(MAKE) -C algencan algencan
	$(MAKE) -C bobyqa bobyqa
	$(MAKE) -C cg_descent cg_descent 
	$(MAKE) -C cgplus cgplus 
	$(MAKE) -C cobyla cobyla 
	$(MAKE) -C derchk derchk 
	$(MAKE) -C dfo dfo 
	$(MAKE) -C directsearch directsearch 
	$(MAKE) -C filtersd filtersd 
	$(MAKE) -C filtersqp filtersqp 
	$(MAKE) -C gen77 gen77 
	$(MAKE) -C gen90 gen90 
	$(MAKE) -C genc genc 
	$(MAKE) -C hrb hrb 
	$(MAKE) -C ipopt ipopt 
	$(MAKE) -C knitro knitro 
	$(MAKE) -C la04 la04 
	$(MAKE) -C lbfgs lbfgs 
	$(MAKE) -C lbfgsb lbfgsb 
	$(MAKE) -C lincoa lincoa 
	$(MAKE) -C loqo loqo 
	$(MAKE) -C minos minos 
	$(MAKE) -C newuoa newuoa 
	$(MAKE) -C nitsol nitsol 
	$(MAKE) -C nlpqlp nlpqlp 
	$(MAKE) -C npsol npsol 
	$(MAKE) -C pds pds 
	$(MAKE) -C pennlp pennlp 
	$(MAKE) -C praxis praxis 
	$(MAKE) -C ql ql 
	$(MAKE) -C qplib qplib 
	$(MAKE) -C snopt snopt 
	$(MAKE) -C spg spg 
#	$(MAKE) -C sqic #                 
	$(MAKE) -C stats stats 
	$(MAKE) -C stenmin stenmin 
	$(MAKE) -C tenmin tenmin 
	$(MAKE) -C test test 
	$(MAKE) -C tron tron 
	$(MAKE) -C uncmin uncmin 
	$(MAKE) -C vf13 vf13 

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
