####
# F prime CMakeLists.txt:
#
# SOURCE_FILES: combined list of source and autocoding files
# MOD_DEPS: (optional) module dependencies
####

set(SOURCE_FILES
  "${CMAKE_CURRENT_LIST_DIR}/instances.fpp"
  "${CMAKE_CURRENT_LIST_DIR}/M4FreeRTOSDeploymentPackets.xml"
  "${CMAKE_CURRENT_LIST_DIR}/topology.fpp"
  "${CMAKE_CURRENT_LIST_DIR}/M4FreeRTOSDeploymentTopology.cpp"
)
set(MOD_DEPS
  Fw/Logger
  fprime-featherm4-freertos/Drv/StreamDriver
)

register_fprime_module()
