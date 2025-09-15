module ReferenceDeployment {

  # ----------------------------------------------------------------------
  # Defaults
  # ----------------------------------------------------------------------

  module Default {
    constant QUEUE_SIZE = 10
    constant STACK_SIZE = 2 * 1024
  }

  # ----------------------------------------------------------------------
  # Active component instances
  # ----------------------------------------------------------------------

  instance cmdDisp: Svc.CommandDispatcher base id 0x0100 \
    queue size 10\
    stack size 1600 \
    priority 101

  instance eventManager: Svc.EventManager base id 0x0300 \
    queue size 10 \
    stack size 1300 \
    priority 102

  instance tlmSend: Svc.TlmChan base id 0x0400 \
    queue size 10 \
    stack size 900 \
    priority 97

  # ----------------------------------------------------------------------
  # Queued component instances
  # ----------------------------------------------------------------------

  # ----------------------------------------------------------------------
  # Passive component instances
  # ----------------------------------------------------------------------

  instance rateGroup1: Svc.PassiveRateGroup base id 0x1000
  instance rateGroup2: Svc.PassiveRateGroup base id 0x2000

  instance comDriver: Arduino.StreamDriver base id 0x4000

  instance fatalHandler: FeatherM4_FreeRTOS.FeatherM4FatalHandler base id 0x4300

  instance timeHandler: Arduino.ArduinoTime base id 0x4400

  instance rateGroupDriver: Svc.RateGroupDriver base id 0x4500

  instance textLogger: Svc.PassiveTextLogger base id 0x4600

  instance rateDriver: Arduino.HardwareRateDriver base id 0x4900

  instance osResources: FeatherM4_FreeRTOS.OsResources base id 0x5000

}
