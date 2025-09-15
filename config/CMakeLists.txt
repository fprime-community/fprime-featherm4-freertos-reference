add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/ComFprimeConfig")
add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/Bmp280Config")
add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/MpuImuConfig")

register_fprime_config(
    fprime-featherm4-freertos-reference-config
  CONFIGURATION_OVERRIDES
    "${CMAKE_CURRENT_LIST_DIR}/CommandDispatcherImplCfg.hpp"
    "${CMAKE_CURRENT_LIST_DIR}/FpConfig.h"
    "${CMAKE_CURRENT_LIST_DIR}/TlmChanImplCfg.hpp"
  INTERFACE # No buildable files generated
)