####
# This sets up the build system for the 'fprime-featherm4-freertos-reference' project, including
# components and deployments from project.cmake. In addition, it imports the core F Prime components.
####

cmake_minimum_required(VERSION 3.13)
project(fprime-featherm4-freertos-reference C CXX)

### Libraries
# Set the path to the Arduino libraries directory
set(ARDUINO_LIB_PATH "/home/<username>/Arduino/libraries")
set(ARDUINO_SAMD_LIB_PATH "/home/<username>/.arduino15/packages/adafruit/hardware/samd/1.7.16/libraries")

# Include directories for Arduino libraries
include_directories(
    ${ARDUINO_LIB_PATH}/Time
    ${ARDUINO_LIB_PATH}/FreeRTOS_SAMD51
    ${ARDUINO_SAMD_LIB_PATH}/Wire
    ${ARDUINO_SAMD_LIB_PATH}/SPI
    ${ARDUINO_SAMD_LIB_PATH}/Adafruit_ZeroDMA
)
target_use_arduino_libraries("FreeRTOS_SAMD51")
        

###
# F' Core Setup
# This includes all of the F prime core components, and imports the make-system.
###
include("${CMAKE_CURRENT_LIST_DIR}/fprime/cmake/FPrime.cmake")
# NOTE: register custom targets between these two lines
fprime_setup_included_code()


# This includes project-wide objects
include("${CMAKE_CURRENT_LIST_DIR}/project.cmake")
