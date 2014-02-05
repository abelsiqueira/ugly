ugly is my collection of changes in
[CUTEst](http://ccpforge.cse.rl.ac.uk/gf/project/cutest/wiki/), the constrained
and unconstrained testing environment for numerical optimization from Dominique
Orban.

**WARNING**: only use it for x86-64 machines running GNU/Linux.

## Download

This repo has submodules, to clone it use

~~~
git clone --recursive https://github.com/r-gaia-cs/ugly.git
~~~

## Installation

**WARNING**: this is a work in progress.

~~~
$ ./configure
$ make
$ make install
~~~

## My problems with CUTEst

1. It use SVN.
2. It's architecture dependent.
3. It's OS dependent.
4. It didn't follow the Unix installation steps.

## My solutions

### SVN

Switch to Git.

### Architecture dependent

Keep only support to x86-64 architecture.

### OS dependent

Keep only support to GNU/Linux.

### Installation steps

The Unix installation steps are

~~~
$ ./configure
$ make
$ make install
~~~

Due CUTEst compatibility with many architectures and operating system is hard to
follow the steps above. Since ugly remove this compatibility it's easy to
achieve the installation with only this steps.
