# Script for installing SoftFloat as a dynamic library, in /usr/local/lib.

# SYSTEM=Linux-386-GCC
# SYSTEM=Linux-386-SSE2-GCC
# SYSTEM=Linux-ARM-VFPv2-GCC
SYSTEM=Linux-x86_64-GCC
# SYSTEM=Win32-MinGW
# SYSTEM=Win32-SSE2-MinGW
# SYSTEM=Win64-MinGW-w64
# SYSTEM=template-FAST_INT64
# SYSTEM=template-not-FAST_INT64

set -x

cd berkeley-softfloat-3/build/$SYSTEM/
make SPECIALIZE_TYPE=RISCV
gcc -dynamiclib -o /usr/local/lib/libsoftfloat.dylib *.o
cp ../../source/include/softfloat_types.h /usr/local/include
cp ../../source/include/softfloat.h /usr/local/include
