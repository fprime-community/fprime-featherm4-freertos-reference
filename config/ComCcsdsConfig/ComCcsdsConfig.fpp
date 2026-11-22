module ComCcsdsConfig {
    #Base ID for the ComCcsds Subtopology, all components are offsets from this base ID
    constant BASE_ID = 0x02000000

    module QueueSizes {
        constant aggregator   = 5
        constant comQueue    = 10
    }

    module StackSizes {
        constant aggregator   = 1300
        constant comQueue   = 1300
    }

    module Priorities {
        constant aggregator = 104
        constant comQueue   = 103
    }

    # Queue configuration constants
    module QueueDepths {
        constant events      = 10             
        constant tlm         = 25            
        constant file        = 1            
    }

    module QueuePriorities {
        constant events      = 0                 
        constant tlm         = 2                 
        constant file        = 1                   
    }

    module CpuAffinities {
        constant aggregator = 0
        constant comQueue   = 0
    }

    # Aggregator configuration constants
    module Aggregator {
        @ Size in bytes of every aggregate emitted by the aggregator instance: the TM Transfer Frame Data Field.
        @ Aggregates are always idle-filled to this size, including in the frame-less SpacePacket topology (where
        @ every flush, including a timeout flush carrying a single packet, costs this many bytes of link).
        @ Svc.Ccsds.TmFramer asserts unless it receives exactly Svc.Ccsds.TmDataFieldSize, so this must equal
        @ Svc.Ccsds.TmDataFieldSize unless a layer inserted between the aggregator and the framer adds bytes, in
        @ which case those bytes must be subtracted here (e.g. ComCcsdsSdls: Svc.Ccsds.TmDataFieldSize -
        @ Svc.Ccsds.SdlsSaIndexSize - encryptor overhead). Without spanning this must be at least
        @ Svc.ComAggregator.MIN_NON_SPANNING_AGGREGATION_SIZE; with packet spanning enabled it must not exceed
        @ 2046 (0x7FE), the TM First Header Pointer range. Both bounds are asserted by configure() at startup.
        constant aggregationSize = Svc.Ccsds.TmDataFieldSize
        @ Controls whether to span packets across transfer frames (see Svc.ComAggregator).
        @ Requires Svc.Ccsds.TmFramer as the transfer frame layer (sole consumer of FrameContext.firstHeaderPointer)
        @ and a ground deframer that reassembles spanned packets using the First Header Pointer.
        constant enablePacketSpanning = false
    }

    # Buffer management constants
    module BuffMgr {
        constant frameAccumulatorSize  = 2048     
        constant commsBuffSize         = 550      
        constant commsFileBuffSize     = 140      
        constant commsBuffCount        = 3        
        constant commsFileBuffCount    = 3       
        constant commsBuffMgrId        = 200      
    }
}
