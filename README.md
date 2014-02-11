ugly is the collection of changes from [Operational Research and Optimization
Laboratory](http://www.lpoo.ime.unicamp.br) for
[CUTEst](http://ccpforge.cse.rl.ac.uk/gf/project/cutest/wiki/), the constrained
and unconstrained testing environment for numerical optimization from Dominique
Orban.

This collection of changes should make easy to install CUTEst for **x86-64
machines running GNU/Linux, ONLY**.

## Download

This repo has submodules, to clone it use

~~~
git clone --recursive https://github.com/r-gaia-cs/ugly.git
~~~

or

~~~
git clone https://github.com/r-gaia-cs/ugly.git
cd ugly
git submodule init
git submodule update
~~~

## Installation

**WARNING**: this is a work in progress and only work with some solvers (for
more information see 2483de6).

~~~
$ ./configure
$ make
$ make install
~~~

## Running for the first time

~~~
$ runcutest -p gen77 -D HS11
~~~

## CUTEst's Problems

- [x] It use SVN.
- [ ] It's architecture dependent.
- [ ] It's OS dependent.
- [x] It didn't follow the Unix installation steps.

## Solutions to CUTEst's Problems

### SVN

Switch to Git.

### Architecture dependent

**Short**: Keep only support to x86-64 architecture changing the building steps.

### OS dependent

**Short**: Keep only support to GNU/Linux changing the building steps.

### Installation steps

The Unix installation steps are

~~~
$ ./configure
$ make
$ make install
~~~

**Note**: Due CUTEst compatibility with many architectures and operating system is hard to
follow the steps above. Since ugly remove this compatibility it's easy to
achieve the installation with only this steps.
