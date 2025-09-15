module Bmp280 {
    module SubtopologyConfig {
        constant BASE_ID = 0xD0000000
    }

    instance bmpDriver: Arduino.SpiDriver base id Bmp280.SubtopologyConfig.BASE_ID + 0x00002000 {
        phase Fpp.ToCpp.Phases.configComponents """
        Bmp280::bmpDriver.open(&SPI, Arduino::SpiDriver::SPI_FREQUENCY_4MHZ, 10);
        """
    }
} 
