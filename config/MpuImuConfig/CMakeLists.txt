register_fprime_config(
    CONFIGURATION_OVERRIDES
        "${CMAKE_CURRENT_LIST_DIR}/MpuImuSubtopologyConfig.fpp"
    INTERFACE
    DEPENDS
        Fw_Types
        Arduino
)
