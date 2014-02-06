# information on the package
AC_INIT([ugly], [0.1],,[https://github.com/r-gaia-cs/ugly])

# Configure environment variables
echo "Setting environment variables"
CUTEST=$(pwd)
AC_SUBST(CUTEST)
CUTEST_REQUIRED=1
AC_SUBST(CUTEST_REQUIRED)
SIFDECODE=$(pwd)/sifdecode
AC_SUBST(SIFDECODE)
SIFDECODE_REQUIRED=1
AC_SUBST(SIFDECODE_REQUIRED)
ARCHDEFS=$(pwd)/archdefs
AC_SUBST(ARCHDEFS)
MCH="pc64"
AC_SUBST(MCH)
MACHINE="Intel-like PC with a 64-bit processor"
AC_SUBST(MACHINE)
OS="lnx"
AC_SUBST(OS)
OPSYS="Linux"
AC_SUBST(OPSYS)
VERSION="HEAD"
AC_SUBST(VERSION)

# Library
#AC_CONFIG_MACRO_DIR([m4])
#LT_INIT
#AM_DISABLE_SHARED
#AM_PROG_LIBTOOL

# Checks for programs
echo "Testing for a C compiler"
AC_PROG_CC
echo "Testing for a FORTRAN compiler"
AC_PROG_FC

# Checks for libraries
# Checks for header files
# Checks for types
# Checks for structures
# Checks for compiler characteristics
# Checks for library functions
# Checks for system
# Services

FCFLAGS=""
CFLAGS=""

AC_ARG_ENABLE([warnings],
    AS_HELP_STRING([--enable-warnings], [Enable warnings]),
    [CFLAGS+="-Wall ";
     FCFLAGS+="-Wall "],
    [CFLAGS+="";
     FCFLAGS+=""])

AC_ARG_ENABLE([debug],
    AS_HELP_STRING([--enable-debug], [Enable debug features]),
    [CFLAGS+="-g -O0 -DDEBUG ";
     FCFLAGS+="-g -O0 "],
    [CFLAGS+="-O3 ";
     FCFLAGS+="-O3 "])

AC_ARG_ENABLE([single],
    AS_HELP_STRING([--enable-single], [Enable single precision]),
    [PRECIS=single],
    [PRECIS=double])
AC_SUBST(PRECIS)

AC_CONFIG_FILES([Makefile])

AC_OUTPUT
