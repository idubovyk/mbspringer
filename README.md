mbspringer
===========

## Overview

The Supplementary Material to

### Mellin-Barnes Integrals: A Primer on Particle Physics Applications
#### Springer Nature 2022, Lecture Notes in Physics


[Link to the book](https://link.springer.com/book/9783031142710).   Another copy of the material can be found at https://jgluza.us.edu.pl/mbspringer/


## Getting Started

In the book examples the following tools have been used:

* AMBRE: https://jgluza.us.edu.pl/ambre/
* PlanarityTest: https://jgluza.us.edu.pl/ambre/planarity/
* MBnumerics: https://jgluza.us.edu.pl/ambre/
* MB, MBresolve, MBasymptotics, barnesroutines: https://mbtools.hepforge.org
* CUBA:http://www.feynarts.de/cuba/
* CernLib: http://cernlib.web.cern.ch/cernlib/
* QMC: https://github.com/mppmu/qmc

These examples are tested under:

* Mathematica 12.0.0.0

For viewing the .nb files one can use [Wolfram Player](https://www.wolfram.com/player/).


## HowTo

* MB.m requires CUBA library for numerical integration and CERNlib for gamma functions.

* To find where the problem is, one can run MBintegrate with the option Debug->True.
This option doesn't erase fortran source files, and one can compile
them manually to see all errors and warnings.

* For simple tests to be independent on Cernlib and CUBA, one can use MBintegrate
with option MaxNIntegrateDim -> your_dim.
In this case, MB.m will use the NIntegrate function from Mathematica.
Also, one can pass NIntegrate options to MBintegrate.

* MB.m is distributed as it is and without changes since ~2006.
To make it works with new libraries and compilers, one should make some changes

* f77 is now a part of gfortran, so you should change in MB.m
line962: Run["f77 -O -o", exec, source, "-L. -lmathlib -lkernlib -lcuba"] to
         Run["gfortran -O -o", exec, source, "-L. -lmathlib -lkernlib -lcuba"].

* MB works by default with Cuba 1.7 or older. It is because function calls are
different for different versions (you can check it in Cuba documentation).

> You can use the old version or for Cuba 4.x one should modify this part: lines 908-910 and 912-914
>from

      "      call vegas(ndim, ncomp, integrand, epsrel, epsabs, flags,\n",
      "     &           mineval, maxeval, nstart, nincrease,\n",
      "     &           neval, fail, integral, error, prob)\n",

      "      call cuhre(ndim, ncomp, integrand, epsrel, epsabs, flags,\n",
      "     &           mineval, maxeval, key, nregions,\n",
      "     &           neval, fail, integral, error, prob)\n",

>to

      "      call vegas(ndim, ncomp, integrand, 0, 1,\n",
      "     &           epsrel, epsabs, 0, 0,\n",  
      "     &           mineval, maxeval, nstart, nincrease, 1000,\n",
      "     &           0, \"\", -1,\n",
      "     &           neval, fail, integral, error, prob)\n",

      "      call cuhre(ndim, ncomp, integrand, 0, 1,\n",
      "     &           epsrel, epsabs, 0,\n",
      "     &           mineval, maxeval, key,\n",
      "     &           \"\", -1,\n",
      "     &           nregions, neval, fail, integral, error, prob)\n",

* CERNlib is usually not a problem since it is in any Debian-based Linux distribution repository.

## License

## History

* Nov 2022: first release
