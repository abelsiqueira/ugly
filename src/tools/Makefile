#  compilation agenda

BASIC_SRC = cutest.o probname.o varnames.o \
	    newthread.o problem.o fortran_ops.o \
	    interface.o ccutest.o

BASIC_DST = $(patsubst %.o,$(OBJ)/%.o,$(BASIC_SRC))

UCUTEST_SRC = usetup.o udimen.o udimse.o udimsh.o \
          unames.o uvartype.o ufn.o ugr.o \
          uofg.o udh.o ugrdh.o ush.o \
          ushp.o ueh.o ugreh.o ugrsh.o \
          uhprod.o ubandh.o ureport.o \
          uterminate.o

UCUTEST_DST = $(patsubst %.o,$(OBJ)/%.o,$(UCUTEST_SRC))

CCUTEST_SRC = csetup.o cdimen.o cdimse.o cdimsh.o \
          cdimsj.o cnames.o cvartype.o cfn.o \
          cgr.o cofg.o cofsg.o ccfg.o \
          clfg.o \
          ccfsg.o ccifg.o ccifsg.o cdh.o \
          ceh.o cgrdh.o cidh.o csh.o \
          cshc.o cshp.o cish.o cjprod.o \
          cstats.o csgr.o csgreh.o csgrsh.o \
          chprod.o chcprod.o creport.o \
          connames.o cterminate.o lqp.o

CCUTEST_DST = $(patsubst %.o,$(OBJ)/%.o,$(CCUTEST_SRC))

#  main compilations and runs

all: cutest

#  basic packages

cutest: $(BASIC_DST) $(UCUTEST_DST) $(CCUTEST_DST)
	cd $(OBJ); $(CC) -shared -o libcutest.so $(CFLAGS) $^

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

$(OBJ)/%.o: %.f90
	$(SED) -f $(SEDS) $^ > $(OBJ)/$^
	$(FC) -o $@ $(FFLAGS) $(OBJ)/$^

$(OBJ)/%.o: %.c
	$(SED) -f $(SEDS) $^ > $(OBJ)/$^
	$(CC) -o $@ -c $(CFLAGS) $(OBJ)/$^
