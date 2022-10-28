# This example toolchain file describes the cross compiler to use for
# the target architecture indicated in the configuration file.

# The cross toolchain is configured to use a compiler for the 
# RTEMS operating system targeting the "beagleboneblack" BSP

# Note that to use this, the "RTEMS" platform module may need to be added
# to the system-wide CMake installation as a default CMake does not yet
# recognize RTEMS as a system name.  An example of this is distributed with
# the generic-rtems PSP.

# Basic cross system configuration
set(CMAKE_SYSTEM_NAME       RTEMS)
set(CMAKE_SYSTEM_PROCESSOR  arm)
set(CMAKE_SYSTEM_VERSION    6)

# The RTEMS BSP that will be used for this build
set(RTEMS_BSP "beagleboneblack")

# these settings are specific to cFE/OSAL and determines which
# abstraction layers are built when using this toolchain
SET(CFE_SYSTEM_PSPNAME                  generic-rtems)
SET(OSAL_SYSTEM_BSPTYPE                 generic-rtems)
SET(OSAL_SYSTEM_OSTYPE                  rtems)

# This is for version specific RTEMS ifdefs needed by the OSAL and PSP
ADD_DEFINITIONS(-DOS_RTEMS_6)
# This is critical to allow sockets to work with bsdlib networking
ADD_DEFINITIONS(-DFD_SETSIZE=256)

set(RTEMS_BSP_C_FLAGS           "-mcpu=cortex-a8 -D__ARM__")
set(RTEMS_BSP_CXX_FLAGS         ${RTEMS_BSP_C_FLAGS})

# Exception handling is very iffy.  These two options disable eh_frame creation.
set(CMAKE_C_COMPILE_OPTIONS_PIC -fno-exceptions -fno-asynchronous-unwind-tables)

#+---------------------------------------------------------------------------+ 
#| Common RTEMS toolchain statements
#+---------------------------------------------------------------------------+ 
# The TOOLS and BSP are allowed to be installed in different locations.
# If the README was followed they will both be installed under $HOME
# By default it is assumed the BSP is installed to the same directory as the tools
SET(RTEMS_TOOLS_PREFIX "/home/edison369/quick-start/rtems/${CMAKE_SYSTEM_VERSION}" CACHE PATH 
    "RTEMS tools install directory")
SET(RTEMS_BSP_PREFIX "/home/edison369/quick-start/rtems/${CMAKE_SYSTEM_VERSION}" CACHE PATH 
    "RTEMS BSP install directory")

# specify the cross compiler - adjust accord to compiler installation
SET(SDKHOSTBINDIR               "${RTEMS_TOOLS_PREFIX}/bin")
set(TARGETPREFIX                "${CMAKE_SYSTEM_PROCESSOR}-rtems${CMAKE_SYSTEM_VERSION}-")

SET(CMAKE_C_COMPILER            "${RTEMS_TOOLS_PREFIX}/bin/${TARGETPREFIX}gcc")
SET(CMAKE_CXX_COMPILER          "${RTEMS_TOOLS_PREFIX}/bin/${TARGETPREFIX}g++")
SET(CMAKE_LINKER                "${RTEMS_TOOLS_PREFIX}/bin/${TARGETPREFIX}ld")
SET(CMAKE_ASM_COMPILER          "${RTEMS_TOOLS_PREFIX}/bin/${TARGETPREFIX}as")
SET(CMAKE_STRIP                 "${RTEMS_TOOLS_PREFIX}/bin/${TARGETPREFIX}strip")
SET(CMAKE_NM                    "${RTEMS_TOOLS_PREFIX}/bin/${TARGETPREFIX}nm")
SET(CMAKE_AR                    "${RTEMS_TOOLS_PREFIX}/bin/${TARGETPREFIX}ar")
SET(CMAKE_OBJDUMP               "${RTEMS_TOOLS_PREFIX}/bin/${TARGETPREFIX}objdump")
SET(CMAKE_OBJCOPY               "${RTEMS_TOOLS_PREFIX}/bin/${TARGETPREFIX}objcopy")

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM   NEVER)

# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY   ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE   ONLY)

SET(CMAKE_PREFIX_PATH                   /)
