####
# F prime CMakeLists.txt:
#
# SOURCE_FILES: combined list of source and autocoding files
# MOD_DEPS: (optional) module dependencies
####

register_fprime_module(
  AUTOCODER_INPUTS
    "${CMAKE_CURRENT_LIST_DIR}/instances.fpp"
    "${CMAKE_CURRENT_LIST_DIR}/system.fpp"
    "${CMAKE_CURRENT_LIST_DIR}/topology.fpp"
  SOURCES
    "${CMAKE_CURRENT_LIST_DIR}/ReferenceDeploymentTopology.cpp"
  DEPENDS
    Fw_Logger
    Arduino_Drv_StreamDriver
)
