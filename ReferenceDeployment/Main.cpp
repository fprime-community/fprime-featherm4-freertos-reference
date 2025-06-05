// ======================================================================
// \title  Main.cpp
// \brief main program for the F' application. Uses the Arduino-style
//        execution with a setup and loop function. The loop function
//        is not used since we allow the FreeRTOS scheduler to take over
//        before it is invoked.
// ======================================================================
// Used to access topology functions
#include <ReferenceDeployment/Top/ReferenceDeploymentTopologyAc.hpp>
#include <ReferenceDeployment/Top/ReferenceDeploymentTopology.hpp>

#include <FreeRTOS.h>
#include <task.h>

// Used for logging
#include <Arduino/Os/Console.hpp>

void RateLoop(void *params) {
    while (1) {
        rateDriver.cycle();
    }
}

/**
 * \brief setup the program
 *
 * This is an extraction of the Arduino setup() function.
 * 
 */
void setup() {
    // Initialize OSAL
    Os::init();

    // Setup Serial and Logging
    Serial.begin(115200);
    static_cast<Os::Arduino::StreamConsoleHandle*>(Os::Console::getSingleton().getHandle())->setStreamHandler(Serial);

    // Object for communicating state to the reference topology
    ReferenceDeployment::TopologyState inputs;
    inputs.uartNumber = 0;
    inputs.uartBaud = 115200;

    // Setup topology
    ReferenceDeployment::setupTopology(inputs);
    xTaskCreate(RateLoop, "RateLoop", 1600, NULL, 1, NULL);

    Fw::Logger::log("Program Started\n");
    vTaskStartScheduler();
}

/**
 * \brief run the program
 *
 * This is an extraction of the Arduino loop() function.
 * 
 */
void loop() {
}