# information on the package
AC_INIT([ugly], [0.1],,[https://github.com/r-gaia-cs/ugly])

# Configure environment variables
echo "Setting environment variables"
CUTEST=$(pwd)
AC_SUBST(CUTEST)
SIFDECODE=$(pwd)/sifdecode
AC_SUBST(SIFDECODE)
ARCHDEFS=$(pwd)/archdefs
AC_SUBST(ARCHDEFS)

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

AC_CONFIG_FILES([Makefile])

AC_OUTPUT
