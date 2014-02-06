#  compilation agenda

BASIC = $(LC)(cutest.o) $(LC)(probname.o) $(LC)(varnames.o) \
         $(LC)(newthread.o) $(LC)(problem.o) $(LC)(fortran_ops.o) \
         $(LC)(interface.o) $(LC)(ccutest.o)

UCUTEST = $(LC)(usetup.o) $(LC)(udimen.o) $(LC)(udimse.o) $(LC)(udimsh.o) \
           $(LC)(unames.o) $(LC)(uvartype.o) $(LC)(ufn.o) $(LC)(ugr.o) \
           $(LC)(uofg.o) $(LC)(udh.o) $(LC)(ugrdh.o) $(LC)(ush.o) \
           $(LC)(ushp.o) $(LC)(ueh.o) $(LC)(ugreh.o) $(LC)(ugrsh.o) \
           $(LC)(uhprod.o) $(LC)(ubandh.o) $(LC)(ureport.o) \
           $(LC)(uterminate.o)

CCUTEST = $(LC)(csetup.o) $(LC)(cdimen.o) $(LC)(cdimse.o) $(LC)(cdimsh.o) \
           $(LC)(cdimsj.o) $(LC)(cnames.o) $(LC)(cvartype.o) $(LC)(cfn.o) \
           $(LC)(cgr.o) $(LC)(cofg.o) $(LC)(cofsg.o) $(LC)(ccfg.o) \
           $(LC)(clfg.o) \
           $(LC)(ccfsg.o) $(LC)(ccifg.o) $(LC)(ccifsg.o) $(LC)(cdh.o) \
           $(LC)(ceh.o) $(LC)(cgrdh.o) $(LC)(cidh.o) $(LC)(csh.o) \
           $(LC)(cshc.o) $(LC)(cshp.o) $(LC)(cish.o) $(LC)(cjprod.o) \
           $(LC)(cstats.o) $(LC)(csgr.o) $(LC)(csgreh.o) $(LC)(csgrsh.o) \
           $(LC)(chprod.o) $(LC)(chcprod.o) $(LC)(creport.o) \
           $(LC)(connames.o) $(LC)(cterminate.o) $(LC)(lqp.o)

CUTESTS = $(BASIC) $(UCUTEST) $(CCUTEST)

#  main compilations and runs

all: cutest

#  basic packages

cutest: $(CUTESTS)
	$(RANLIB) $(LC)

cutest_unconstrained: $(BASIC) $(UCUTEST)
	$(RANLIB) $(LC)

cutest_constrained: $(BASIC) $(CCUTEST)
	$(RANLIB) $(LC)

#  blas

blas: $(BLC)(blas.o)

# lapack

lapack: $(LLC)(lapack.o)

# run spec-sheet example tests

test_cutest_unconstrained: cutest
	$(MAKE) -C ../test test_cutest_unconstrained

test_cutest_constrained: cutest
	$(MAKE) -C ../test test_cutest_constrained

#  individual compilations

cutest.o: $(LC)(cutest.o)

$(LC)(cutest.o): cutest.f90
	$(SED) -f $(SEDS) cutest.f90 > $(OBJ)/cutest.f90
	cd $(OBJ); $(FC) -o cutest.o $(FFLAGS) cutest.f90
	cd $(OBJ); $(ARR) cutest.o; $(RM) cutest.f90 cutest.o
	$(RMARFILE) csetup.o
	$(RMARFILE) cdimen.o
	$(RMARFILE) cstats.o
	$(RMARFILE) cdimse.o
	$(RMARFILE) cdimsh.o
	$(RMARFILE) cdimsj.o
	$(RMARFILE) cnames.o
	$(RMARFILE) cvartype.o
	$(RMARFILE) cfn.o
	$(RMARFILE) cgr.o
	$(RMARFILE) cofg.o
	$(RMARFILE) cofsg.o
	$(RMARFILE) ccfg.o
	$(RMARFILE) ccfsg.o
	$(RMARFILE) clfg.o
	$(RMARFILE) ccifg.o
	$(RMARFILE) ccifsg.o
	$(RMARFILE) cdh.o
	$(RMARFILE) ceh.o
	$(RMARFILE) cgrdh.o
	$(RMARFILE) cidh.o
	$(RMARFILE) csh.o
	$(RMARFILE) cshc.o
	$(RMARFILE) cshp.o
	$(RMARFILE) cish.o
	$(RMARFILE) cjprod.o
	$(RMARFILE) csgr.o
	$(RMARFILE) csgreh.o
	$(RMARFILE) csgrsh.o
	$(RMARFILE) chprod.o
	$(RMARFILE) chcprod.o
	$(RMARFILE) creport.o
	$(RMARFILE) cterminate.o
	$(RMARFILE) usetup.o
	$(RMARFILE) udimen.o
	$(RMARFILE) udimse.o
	$(RMARFILE) udimsh.o
	$(RMARFILE) unames.o
	$(RMARFILE) uvartype.o
	$(RMARFILE) ufn.o
	$(RMARFILE) ugr.o
	$(RMARFILE) uofg.o
	$(RMARFILE) udh.o
	$(RMARFILE) ugrdh.o
	$(RMARFILE) ush.o
	$(RMARFILE) ushp.o
	$(RMARFILE) ueh.o
	$(RMARFILE) ugreh.o
	$(RMARFILE) ugrsh.o
	$(RMARFILE) uhprod.o
	$(RMARFILE) ubandh.o
	$(RMARFILE) ureport.o
	$(RMARFILE) uterminate.o
	$(RMARFILE) probname.o
	$(RMARFILE) varnames.o
	$(RMARFILE) connames.o
	$(RMARFILE) newthread.o
	$(MVMODS)

%.o: $(LC)(%.o)

$(LC)(%.o): %.f90
	$(SED) -f $(SEDS) $^ > $(OBJ)/$^
	cd $(OBJ); $(FC) -o $% $(FFLAGS) $^
	cd $(OBJ); $(ARR) $%; $(RM) $^ $%
	#$(MVMODS)
