softfloat-hs - Haskell bindings for SoftFloat.
===

copyright (c) Ben Selfridge, Galois Inc. 2018

This library consists primarily of a Haskell interface to John Hauser's SoftFloat
library (http://www.jhauser.us/arithmetic/SoftFloat.html). It provides a *pure*
interface to the functions in that library; while the C library is actually impure,
reading and writing to global variables (rounding mode, exceptions), the Haskell
functions have a pure interface, and those variables that were global in the original
library are captured as input arguments and additional outputs of each function.

Installation
===

## Step 1: Install softfloat
SoftFloat is not too complicated to install, but it is best to build a dynamic
library so that `softfloat-hs` can be loaded into ghci (which does not support
statically linked C libraries). For convenience, we provide SoftFloat itself as a
submodule, as well as a Makefile to install it on Linux/OSX:
```shell
$ git submodule update --init --recursive
$ make
$ sudo make install
```

## Step 2: Build softfloat-hs
With stack:
```shell
stack build
```

With cabal new-build:
```shell
cabal new-build softfloat-hs
```

## Step 3: Test softfloat-hs
```shell
stack ghci
> let Result x flags = ui32ToF32 RoundNearEven 23
> :m +Numeric
> showHex x ""
"41b80000"
> flags
ExceptionFlags {inexact = False, underflow = False, overflow = False, infinite = False, invalid = False}
> let Result y flags = ui32ToF32 RoundNearEven 3
> showHex y ""
"40400000"
> let Result z flags = f32Div RoundNearEven x y
> showHex z ""
"40f55555"
> flags
ExceptionFlags {inexact = True, underflow = False, overflow = False, infinite = False, invalid = False}
```

Requirements
===

The following are a list of mandatory and secondary requirements for softfloat-hs.

Mandatory Requirements
===

- Must provide a "pure" Haskell interface to all of the SoftFloat functions.
- Must make explicit ALL global variables involved.

Secondary Requirements
===

- Support 80-bit and 128-bit operations.

Current Status
===

The library is functional, although a few global variables are not yet captured
(whether underflow is detected before or after rounding, for example).

Known issues
====
Building softfloat on Darwin currently has some issues -- for whatever reason, some
of the conversion functions to not work correctly in some of the corner
cases (f32ToI32 in particular). We are investigating this currently.

Other information
===

* contact: benselfridge@galois.com
