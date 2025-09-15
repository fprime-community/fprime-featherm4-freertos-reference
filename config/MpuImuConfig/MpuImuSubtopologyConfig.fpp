module MpuImu {

    constant BASE_ID = 0xE0000000

    module QueueSizes {
        constant imuManager  = 10
    }

    instance imuDriver: Arduino.I2cDriver base id MpuImu.BASE_ID + 0x00002000 {
        phase Fpp.ToCpp.Phases.configComponents """
        MpuImu::imuDriver.open(&Wire);
        """
    }
}

