# define picoscope error type
export PicoStatus

bitstype 32 PicoStatus <: Unsigned
Base.convert(::Type{PicoStatus}, x::UInt32) = reinterpret(PicoStatus,x)
Base.convert(::Type{UInt32}, x::PicoStatus) = reinterpret(UInt32,x)
Base.promote_rule(::Type{PicoStatus}, ::Type{UInt32}) = UInt32
function Base.show(io::IO, x::PicoStatus)
  show(reinterpret(UInt32,x))
end

type PicoScopeError <: Exception 
  picostatus :: PicoStatus
end

module PICO_STATUS
  const PICO_OK = 0x00000000
  const PICO_MAX_UNITS_OPENED = 0x00000001
  const PICO_MEMORY_FAIL = 0x00000002
  const PICO_NOT_FOUND = 0x00000003
  const PICO_FW_FAIL = 0x00000004
  const PICO_OPEN_OPERATION_IN_PROGRESS = 0x00000005
  const PICO_OPERATION_FAILED = 0x00000006
  const PICO_NOT_RESPONDING = 0x00000007
  const PICO_CONFIG_FAIL = 0x00000008
  const PICO_KERNEL_DRIVER_TOO_OLD = 0x00000009
  const PICO_EEPROM_CORRUPT = 0x0000000a
  const PICO_OS_NOT_SUPPORTED = 0x0000000b
  const PICO_INVALID_HANDLE = 0x0000000c
  const PICO_INVALID_PARAMETER = 0x0000000d
  const PICO_INVALID_TIMEBASE = 0x0000000e
  const PICO_INVALID_VOLTAGE_RANGE = 0x0000000f
  const PICO_INVALID_CHANNEL = 0x00000010
  const PICO_INVALID_TRIGGER_CHANNEL = 0x00000011
  const PICO_INVALID_CONDITION_CHANNEL = 0x00000012
  const PICO_NO_SIGNAL_GENERATOR = 0x00000013
  const PICO_STREAMING_FAILED = 0x00000014
  const PICO_BLOCK_MODE_FAILED = 0x00000015
  const PICO_NULL_PARAMETER = 0x00000016
  const PICO_ETS_MODE_SET = 0x00000017
  const PICO_DATA_NOT_AVAILABLE = 0x00000018
  const PICO_STRING_BUFFER_TOO_SMALL = 0x00000019
  const PICO_ETS_NOT_SUPPORTED = 0x0000001a
  const PICO_AUTO_TRIGGER_TIME_TOO_SHORT = 0x0000001b
  const PICO_BUFFER_STALL = 0x0000001c
  const PICO_TOO_MANY_SAMPLES = 0x0000001d
  const PICO_TOO_MANY_SEGMENTS = 0x0000001e
  const PICO_PULSE_WIDTH_QUALIFIER = 0x0000001f
  const PICO_DELAY = 0x00000020
  const PICO_SOURCE_DETAILS = 0x00000021
  const PICO_CONDITIONS = 0x00000022
  const PICO_USER_CALLBACK = 0x00000023
  const PICO_DEVICE_SAMPLING = 0x00000024
  const PICO_NO_SAMPLES_AVAILABLE = 0x00000025
  const PICO_SEGMENT_OUT_OF_RANGE = 0x00000026
  const PICO_BUSY = 0x00000027
  const PICO_STARTINDEX_INVALID = 0x00000028
  const PICO_INVALID_INFO = 0x00000029
  const PICO_INFO_UNAVAILABLE = 0x0000002a
  const PICO_INVALID_SAMPLE_INTERVAL = 0x0000002b
  const PICO_TRIGGER_ERROR = 0x0000002c
  const PICO_MEMORY = 0x0000002d
  const PICO_SIG_GEN_PARAM = 0x0000002e
  const PICO_SHOTS_SWEEPS_WARNING = 0x0000002f
  const PICO_SIGGEN_TRIGGER_SOURCE = 0x00000030
  const PICO_AUX_OUTPUT_CONFLICT = 0x00000031
  const PICO_AUX_OUTPUT_ETS_CONFLICT = 0x00000032
  const PICO_WARNING_EXT_THRESHOLD_CONFLICT = 0x00000033
  const PICO_WARNING_AUX_OUTPUT_CONFLICT = 0x00000034
  const PICO_SIGGEN_OUTPUT_OVER_VOLTAGE = 0x00000035
  const PICO_DELAY_NULL = 0x00000036
  const PICO_INVALID_BUFFER = 0x00000037
  const PICO_SIGGEN_OFFSET_VOLTAGE = 0x00000038
  const PICO_SIGGEN_PK_TO_PK = 0x00000039
  const PICO_CANCELLED = 0x0000003a
  const PICO_SEGMENT_NOT_USED = 0x0000003b
  const PICO_INVALID_CALL = 0x0000003c
  const PICO_GET_VALUES_INTERRUPTED = 0x0000003d
  const PICO_NOT_USED = 0x0000003f
  const PICO_INVALID_SAMPLERATIO = 0x00000040
  const PICO_INVALID_STATE = 0x00000041
  const PICO_NOT_ENOUGH_SEGMENTS = 0x00000042
  const PICO_DRIVER_FUNCTION = 0x00000043
  const PICO_RESERVED = 0x00000044
  const PICO_INVALID_COUPLING = 0x00000045
  const PICO_BUFFERS_NOT_SET = 0x00000046
  const PICO_RATIO_MODE_NOT_SUPPORTED = 0x00000047
  const PICO_RAPID_NOT_SUPPORT_AGGREGATION = 0x00000048
  const PICO_INVALID_TRIGGER_PROPERTY = 0x00000049
  # below here in header file only
  const PICO_RESISTANCE_AND_PROBE_NOT_ALLOWED     = 0x0000004B
  const PICO_POWER_FAILED                         = 0x0000004C
  const PICO_SIGGEN_WAVEFORM_SETUP_FAILED         = 0x0000004D
  const PICO_FPGA_FAIL                            = 0x0000004E
  const PICO_POWER_MANAGER                        = 0x0000004F
  const PICO_INVALID_ANALOGUE_OFFSET              = 0x00000050
  # unable to configure the ps2000a
  const PICO_PLL_LOCK_FAILED                      = 0x00000051
  # the ps2000a Analog board is not detectly connected
  # to the digital board
  const PICO_ANALOG_BOARD                         = 0x00000052
  # unable to configure the Signal Generator
  const PICO_CONFIG_FAIL_AWG                      = 0x00000053
  const PICO_INITIALISE_FPGA                      = 0x00000054
  const PICO_EXTERNAL_FREQUENCY_INVALID           = 0x00000056
  const PICO_CLOCK_CHANGE_ERROR                   = 0x00000057
  const PICO_TRIGGER_AND_EXTERNAL_CLOCK_CLASH     = 0x00000058
  const PICO_PWQ_AND_EXTERNAL_CLOCK_CLASH         = 0x00000059
  const PICO_UNABLE_TO_OPEN_SCALING_FILE          = 0x0000005A

  const PICO_MEMORY_CLOCK_FREQUENCY               = 0x0000005B
  const PICO_I2C_NOT_RESPONDING                   = 0x0000005C

  const PICO_NO_CAPTURES_AVAILABLE                = 0x0000005D
  const PICO_NOT_USED_IN_THIS_CAPTURE_MODE        = 0x0000005E

  const PICO_GET_DATA_ACTIVE                      = 0x00000103

  # used by the PT104 (USB) when connected via the Network Socket
  const PICO_IP_NETWORKED                         = 0x00000104
  const PICO_INVALID_IP_ADDRESS                   = 0x00000105
  const PICO_IPSOCKET_FAILED                      = 0x00000106
  const PICO_IPSOCKET_TIMEDOUT                    = 0x00000107
  const PICO_SETTINGS_FAILED                      = 0x00000108
  const PICO_NETWORK_FAILED                       = 0x00000109
  const PICO_WS2_32_DLL_NOT_LOADED                = 0x0000010A
  const PICO_INVALID_IP_PORT                      = 0x0000010B

  const PICO_COUPLING_NOT_SUPPORTED               = 0x0000010C
  const PICO_BANDWIDTH_NOT_SUPPORTED              = 0x0000010D
  const PICO_INVALID_BANDWIDTH                    = 0x0000010E

  const PICO_AWG_NOT_SUPPORTED                    = 0x0000010F
  const PICO_ETS_NOT_RUNNING                      = 0x00000110
  const PICO_SIG_GEN_WHITENOISE_NOT_SUPPORTED     = 0x00000111
  const PICO_SIG_GEN_WAVETYPE_NOT_SUPPORTED       = 0x00000112

  const PICO_INVALID_DIGITAL_PORT                 = 0x00000113
  const PICO_INVALID_DIGITAL_CHANNEL              = 0x00000114
  const PICO_INVALID_DIGITAL_TRIGGER_DIRECTION    = 0x00000115

  const PICO_SIG_GEN_PRBS_NOT_SUPPORTED           = 0x00000116

  const PICO_ETS_NOT_AVAILABLE_WITH_LOGIC_CHANNELS= 0x00000117

  const PICO_WARNING_REPEAT_VALUE                 = 0x00000118

  const PICO_POWER_SUPPLY_CONNECTED               = 0x00000119
  const PICO_POWER_SUPPLY_NOT_CONNECTED           = 0x0000011A
  const PICO_POWER_SUPPLY_REQUEST_INVALID         = 0x0000011B
  const PICO_POWER_SUPPLY_UNDERVOLTAGE            = 0x000001

  const PICO_CAPTURING_DATA                       = 0x0000011D

  const PICO_USB3_0_DEVICE_NON_USB3_0_PORT        = 0x0000011E

  const PICO_NOT_SUPPORTED_BY_THIS_DEVICE         = 0x0000011F
  const PICO_INVALID_DEVICE_RESOLUTION            = 0x00000120
  const PICO_INVALID_NUMBER_CHANNELS_FOR_RESOLUTION = 0x00000121

  const PICO_CHANNEL_DISABLED_DUE_TO_USB_POWERED  = 0x00000122

  const PICO_SIGGEN_DC_VOLTAGE_NOT_CONFIGURABLE   = 0x00000123

  const PICO_NO_TRIGGER_ENABLED_FOR_TRIGGER_IN_PRE_TRIG= 0x00000124
  const PICO_TRIGGER_WITHIN_PRE_TRIG_NOT_ARMED         = 0x00000125
  const PICO_TRIGGER_WITHIN_PRE_NOT_ALLOWED_WITH_DELAY = 0x00000126
  const PICO_TRIGGER_INDEX_UNAVAILABLE                 = 0x00000127

  const PICO_AWG_CLOCK_FREQUENCY                = 0x00000128
  # there are more than 4 analogue channels with a trigger condition set
  const PICO_TOO_MANY_CHANNELS_IN_USE           = 0x00000129

  const PICO_NULL_CONDITIONS                    = 0x0000012A
  const PICO_DUPLICATE_CONDITION_SOURCE         = 0x0000012B  
  const PICO_INVALID_CONDITION_INFO             = 0x0000012C  

  const PICO_SETTINGS_READ_FAILED               = 0x0000012D
  const PICO_SETTINGS_WRITE_FAILED              = 0x0000012E

  const PICO_ARGUMENT_OUT_OF_RANGE              = 0x0000012F

  const PICO_HARDWARE_VERSION_NOT_SUPPORTED     = 0x00000130
  const PICO_DIGITAL_HARDWARE_VERSION_NOT_SUPPORTED     = 0x00000131
  const PICO_ANALOGUE_HARDWARE_VERSION_NOT_SUPPORTED      = 0x00000132

  const PICO_UNABLE_TO_CONVERT_TO_RESISTANCE    = 0x00000133
  const PICO_DUPLICATED_CHANNEL                 = 0x00000134

  const PICO_INVALID_RESISTANCE_CONVERSION      = 0x00000135
  const PICO_INVALID_VALUE_IN_MAX_BUFFER        = 0x00000136
  const PICO_INVALID_VALUE_IN_MIN_BUFFER        = 0x00000137

  const PICO_SIGGEN_FREQUENCY_OUT_OF_RANGE      = 0x00000138

  const PICO_EEPROM2_CORRUPT                    = 0x00000139
  const PICO_EEPROM2_FAIL                       = 0x0000013A

  const PICO_DEVICE_TIME_STAMP_RESET            = 0x01000000

  const PICO_WATCHDOGTIMER                      = 0x10000000

  const PICO_IPP_NOT_FOUND                      = 0x10000001
  const PICO_IPP_NO_FUNCTION                    = 0x10000002
  const PICO_IPP_ERROR                          = 0x10000003

  const PICO_SHADOW_CAL_NOT_AVAILABLE           = 0x10000004
  const PICO_SHADOW_CAL_DISABLED                = 0x10000005
  const PICO_SHADOW_CAL_ERROR                   = 0x10000006
  const PICO_SHADOW_CAL_CORRUPT                 = 0x10000007
end # PICO_STATUS

picoscopestatusdict = Dict(
  PICO_STATUS.PICO_OK => "PICO_OK",
  PICO_STATUS.PICO_MAX_UNITS_OPENED => "PICO_MAX_UNITS_OPENED", 
  PICO_STATUS.PICO_MEMORY_FAIL => "PICO_MEMORY_FAIL", 
  PICO_STATUS.PICO_NOT_FOUND => "PICO_NOT_FOUND", 
  PICO_STATUS.PICO_FW_FAIL => "PICO_FW_FAIL", 
  PICO_STATUS.PICO_OPEN_OPERATION_IN_PROGRESS => "PICO_OPEN_OPERATION_IN_PROGRESS", 
  PICO_STATUS.PICO_OPERATION_FAILED => "PICO_OPERATION_FAILED", 
  PICO_STATUS.PICO_NOT_RESPONDING => "PICO_NOT_RESPONDING", 
  PICO_STATUS.PICO_CONFIG_FAIL => "PICO_CONFIG_FAIL", 
  PICO_STATUS.PICO_KERNEL_DRIVER_TOO_OLD => "PICO_KERNEL_DRIVER_TOO_OLD", 
  PICO_STATUS.PICO_EEPROM_CORRUPT => "PICO_EEPROM_CORRUPT", 
  PICO_STATUS.PICO_OS_NOT_SUPPORTED => "PICO_OS_NOT_SUPPORTED", 
  PICO_STATUS.PICO_INVALID_HANDLE => "PICO_INVALID_HANDLE", 
  PICO_STATUS.PICO_INVALID_PARAMETER => "PICO_INVALID_PARAMETER", 
  PICO_STATUS.PICO_INVALID_TIMEBASE => "PICO_INVALID_TIMEBASE", 
  PICO_STATUS.PICO_INVALID_VOLTAGE_RANGE => "PICO_INVALID_VOLTAGE_RANGE", 
  PICO_STATUS.PICO_INVALID_CHANNEL => "PICO_INVALID_CHANNEL", 
  PICO_STATUS.PICO_INVALID_TRIGGER_CHANNEL => "PICO_INVALID_TRIGGER_CHANNEL", 
  PICO_STATUS.PICO_INVALID_CONDITION_CHANNEL => "PICO_INVALID_CONDITION_CHANNEL", 
  PICO_STATUS.PICO_NO_SIGNAL_GENERATOR => "PICO_NO_SIGNAL_GENERATOR", 
  PICO_STATUS.PICO_STREAMING_FAILED => "PICO_STREAMING_FAILED", 
  PICO_STATUS.PICO_BLOCK_MODE_FAILED => "PICO_BLOCK_MODE_FAILED", 
  PICO_STATUS.PICO_NULL_PARAMETER => "PICO_NULL_PARAMETER", 
  PICO_STATUS.PICO_ETS_MODE_SET => "PICO_ETS_MODE_SET", 
  PICO_STATUS.PICO_DATA_NOT_AVAILABLE => "PICO_DATA_NOT_AVAILABLE", 
  PICO_STATUS.PICO_STRING_BUFFER_TOO_SMALL => "PICO_STRING_BUFFER_TOO_SMALL", 
  PICO_STATUS.PICO_ETS_NOT_SUPPORTED => "PICO_ETS_NOT_SUPPORTED", 
  PICO_STATUS.PICO_AUTO_TRIGGER_TIME_TOO_SHORT => "PICO_AUTO_TRIGGER_TIME_TOO_SHORT", 
  PICO_STATUS.PICO_BUFFER_STALL => "PICO_BUFFER_STALL", 
  PICO_STATUS.PICO_TOO_MANY_SAMPLES => "PICO_TOO_MANY_SAMPLES", 
  PICO_STATUS.PICO_TOO_MANY_SEGMENTS => "PICO_TOO_MANY_SEGMENTS", 
  PICO_STATUS.PICO_PULSE_WIDTH_QUALIFIER => "PICO_PULSE_WIDTH_QUALIFIER", 
  PICO_STATUS.PICO_DELAY => "PICO_DELAY", 
  PICO_STATUS.PICO_SOURCE_DETAILS => "PICO_SOURCE_DETAILS", 
  PICO_STATUS.PICO_CONDITIONS => "PICO_CONDITIONS", 
  PICO_STATUS.PICO_USER_CALLBACK => "PICO_USER_CALLBACK", 
  PICO_STATUS.PICO_DEVICE_SAMPLING => "PICO_DEVICE_SAMPLING", 
  PICO_STATUS.PICO_NO_SAMPLES_AVAILABLE => "PICO_NO_SAMPLES_AVAILABLE", 
  PICO_STATUS.PICO_SEGMENT_OUT_OF_RANGE => "PICO_SEGMENT_OUT_OF_RANGE", 
  PICO_STATUS.PICO_BUSY => "PICO_BUSY", 
  PICO_STATUS.PICO_STARTINDEX_INVALID => "PICO_STARTINDEX_INVALID", 
  PICO_STATUS.PICO_INVALID_INFO => "PICO_INVALID_INFO", 
  PICO_STATUS.PICO_INFO_UNAVAILABLE => "PICO_INFO_UNAVAILABLE", 
  PICO_STATUS.PICO_INVALID_SAMPLE_INTERVAL => "PICO_INVALID_SAMPLE_INTERVAL", 
  PICO_STATUS.PICO_TRIGGER_ERROR => "PICO_TRIGGER_ERROR", 
  PICO_STATUS.PICO_MEMORY => "PICO_MEMORY", 
  PICO_STATUS.PICO_SIG_GEN_PARAM => "PICO_SIG_GEN_PARAM", 
  PICO_STATUS.PICO_SHOTS_SWEEPS_WARNING => "PICO_SHOTS_SWEEPS_WARNING", 
  PICO_STATUS.PICO_SIGGEN_TRIGGER_SOURCE => "PICO_SIGGEN_TRIGGER_SOURCE", 
  PICO_STATUS.PICO_AUX_OUTPUT_CONFLICT => "PICO_AUX_OUTPUT_CONFLICT", 
  PICO_STATUS.PICO_AUX_OUTPUT_ETS_CONFLICT => "PICO_AUX_OUTPUT_ETS_CONFLICT", 
  PICO_STATUS.PICO_WARNING_EXT_THRESHOLD_CONFLICT => "PICO_WARNING_EXT_THRESHOLD_CONFLICT", 
  PICO_STATUS.PICO_WARNING_AUX_OUTPUT_CONFLICT => "PICO_WARNING_AUX_OUTPUT_CONFLICT", 
  PICO_STATUS.PICO_SIGGEN_OUTPUT_OVER_VOLTAGE => "PICO_SIGGEN_OUTPUT_OVER_VOLTAGE", 
  PICO_STATUS.PICO_DELAY_NULL => "PICO_DELAY_NULL", 
  PICO_STATUS.PICO_INVALID_BUFFER => "PICO_INVALID_BUFFER", 
  PICO_STATUS.PICO_SIGGEN_OFFSET_VOLTAGE => "PICO_SIGGEN_OFFSET_VOLTAGE", 
  PICO_STATUS.PICO_SIGGEN_PK_TO_PK => "PICO_SIGGEN_PK_TO_PK", 
  PICO_STATUS.PICO_CANCELLED => "PICO_CANCELLED", 
  PICO_STATUS.PICO_SEGMENT_NOT_USED => "PICO_SEGMENT_NOT_USED", 
  PICO_STATUS.PICO_INVALID_CALL => "PICO_INVALID_CALL", 
  PICO_STATUS.PICO_GET_VALUES_INTERRUPTED => "PICO_GET_VALUES_INTERRUPTED", 
  PICO_STATUS.PICO_NOT_USED => "PICO_NOT_USED", 
  PICO_STATUS.PICO_INVALID_SAMPLERATIO => "PICO_INVALID_SAMPLERATIO", 
  PICO_STATUS.PICO_INVALID_STATE => "PICO_INVALID_STATE", 
  PICO_STATUS.PICO_NOT_ENOUGH_SEGMENTS => "PICO_NOT_ENOUGH_SEGMENTS", 
  PICO_STATUS.PICO_DRIVER_FUNCTION => "PICO_DRIVER_FUNCTION", 
  PICO_STATUS.PICO_RESERVED => "PICO_RESERVED", 
  PICO_STATUS.PICO_INVALID_COUPLING => "PICO_INVALID_COUPLING",
  PICO_STATUS.PICO_BUFFERS_NOT_SET => "PICO_BUFFERS_NOT_SET", 
  PICO_STATUS.PICO_RATIO_MODE_NOT_SUPPORTED => "PICO_RATIO_MODE_NOT_SUPPORTED",
  PICO_STATUS.PICO_RAPID_NOT_SUPPORT_AGGREGATION => "PICO_RAPID_NOT_SUPPORT_AGGREGATION", 
  PICO_STATUS.PICO_INVALID_TRIGGER_PROPERTY => "PICO_INVALID_TRIGGER_PROPERTY",
  PICO_STATUS.PICO_RESISTANCE_AND_PROBE_NOT_ALLOWED => "PICO_RESISTANCE_AND_PROBE_NOT_ALLOWED",     
  PICO_STATUS.PICO_POWER_FAILED => "PICO_POWER_FAILED",                         
  PICO_STATUS.PICO_SIGGEN_WAVEFORM_SETUP_FAILED => "PICO_SIGGEN_WAVEFORM_SETUP_FAILED",         
  PICO_STATUS.PICO_FPGA_FAIL => "PICO_FPGA_FAIL",                            
  PICO_STATUS.PICO_POWER_MANAGER => "PICO_POWER_MANAGER",                        
  PICO_STATUS.PICO_INVALID_ANALOGUE_OFFSET => "PICO_INVALID_ANALOGUE_OFFSET",              
  PICO_STATUS.PICO_PLL_LOCK_FAILED => "PICO_PLL_LOCK_FAILED",                      
  PICO_STATUS.PICO_ANALOG_BOARD => "PICO_ANALOG_BOARD",                         
  PICO_STATUS.PICO_CONFIG_FAIL_AWG => "PICO_CONFIG_FAIL_AWG",                      
  PICO_STATUS.PICO_INITIALISE_FPGA => "PICO_INITIALISE_FPGA",                      
  PICO_STATUS.PICO_EXTERNAL_FREQUENCY_INVALID => "PICO_EXTERNAL_FREQUENCY_INVALID",           
  PICO_STATUS.PICO_CLOCK_CHANGE_ERROR => "PICO_CLOCK_CHANGE_ERROR",                   
  PICO_STATUS.PICO_TRIGGER_AND_EXTERNAL_CLOCK_CLASH => "PICO_TRIGGER_AND_EXTERNAL_CLOCK_CLASH",     
  PICO_STATUS.PICO_PWQ_AND_EXTERNAL_CLOCK_CLASH => "PICO_PWQ_AND_EXTERNAL_CLOCK_CLASH",         
  PICO_STATUS.PICO_UNABLE_TO_OPEN_SCALING_FILE => "PICO_UNABLE_TO_OPEN_SCALING_FILE",          
  PICO_STATUS.PICO_MEMORY_CLOCK_FREQUENCY => "PICO_MEMORY_CLOCK_FREQUENCY",               
  PICO_STATUS.PICO_I2C_NOT_RESPONDING => "PICO_I2C_NOT_RESPONDING",                   
  PICO_STATUS.PICO_NO_CAPTURES_AVAILABLE => "PICO_NO_CAPTURES_AVAILABLE",                
  PICO_STATUS.PICO_NOT_USED_IN_THIS_CAPTURE_MODE => "PICO_NOT_USED_IN_THIS_CAPTURE_MODE",        
  PICO_STATUS.PICO_GET_DATA_ACTIVE => "PICO_GET_DATA_ACTIVE",                      
  PICO_STATUS.PICO_IP_NETWORKED => "PICO_IP_NETWORKED",                         
  PICO_STATUS.PICO_INVALID_IP_ADDRESS => "PICO_INVALID_IP_ADDRESS",                   
  PICO_STATUS.PICO_IPSOCKET_FAILED => "PICO_IPSOCKET_FAILED",                      
  PICO_STATUS.PICO_IPSOCKET_TIMEDOUT => "PICO_IPSOCKET_TIMEDOUT",                    
  PICO_STATUS.PICO_SETTINGS_FAILED => "PICO_SETTINGS_FAILED",                      
  PICO_STATUS.PICO_NETWORK_FAILED => "PICO_NETWORK_FAILED",                       
  PICO_STATUS.PICO_WS2_32_DLL_NOT_LOADED => "PICO_WS2_32_DLL_NOT_LOADED",                
  PICO_STATUS.PICO_INVALID_IP_PORT => "PICO_INVALID_IP_PORT",                      
  PICO_STATUS.PICO_COUPLING_NOT_SUPPORTED => "PICO_COUPLING_NOT_SUPPORTED",               
  PICO_STATUS.PICO_BANDWIDTH_NOT_SUPPORTED => "PICO_BANDWIDTH_NOT_SUPPORTED",              
  PICO_STATUS.PICO_INVALID_BANDWIDTH => "PICO_INVALID_BANDWIDTH",                    
  PICO_STATUS.PICO_AWG_NOT_SUPPORTED => "PICO_AWG_NOT_SUPPORTED",                    
  PICO_STATUS.PICO_ETS_NOT_RUNNING => "PICO_ETS_NOT_RUNNING",                      
  PICO_STATUS.PICO_SIG_GEN_WHITENOISE_NOT_SUPPORTED => "PICO_SIG_GEN_WHITENOISE_NOT_SUPPORTED",     
  PICO_STATUS.PICO_SIG_GEN_WAVETYPE_NOT_SUPPORTED => "PICO_SIG_GEN_WAVETYPE_NOT_SUPPORTED",       
  PICO_STATUS.PICO_INVALID_DIGITAL_PORT => "PICO_INVALID_DIGITAL_PORT",                 
  PICO_STATUS.PICO_INVALID_DIGITAL_CHANNEL => "PICO_INVALID_DIGITAL_CHANNEL",              
  PICO_STATUS.PICO_INVALID_DIGITAL_TRIGGER_DIRECTION => "PICO_INVALID_DIGITAL_TRIGGER_DIRECTION",    
  PICO_STATUS.PICO_SIG_GEN_PRBS_NOT_SUPPORTED => "PICO_SIG_GEN_PRBS_NOT_SUPPORTED",           
  PICO_STATUS.PICO_ETS_NOT_AVAILABLE_WITH_LOGIC_CHANNELS => "PICO_ETS_NOT_AVAILABLE_WITH_LOGIC_CHANNELS",
  PICO_STATUS.PICO_WARNING_REPEAT_VALUE => "PICO_WARNING_REPEAT_VALUE",                 
  PICO_STATUS.PICO_POWER_SUPPLY_CONNECTED => "PICO_POWER_SUPPLY_CONNECTED",               
  PICO_STATUS.PICO_POWER_SUPPLY_NOT_CONNECTED => "PICO_POWER_SUPPLY_NOT_CONNECTED",           
  PICO_STATUS.PICO_POWER_SUPPLY_REQUEST_INVALID => "PICO_POWER_SUPPLY_REQUEST_INVALID",         
  PICO_STATUS.PICO_POWER_SUPPLY_UNDERVOLTAGE => "PICO_POWER_SUPPLY_UNDERVOLTAGE",            
  PICO_STATUS.PICO_CAPTURING_DATA => "PICO_CAPTURING_DATA",                       
  PICO_STATUS.PICO_USB3_0_DEVICE_NON_USB3_0_PORT => "PICO_USB3_0_DEVICE_NON_USB3_0_PORT",        
  PICO_STATUS.PICO_NOT_SUPPORTED_BY_THIS_DEVICE => "PICO_NOT_SUPPORTED_BY_THIS_DEVICE",         
  PICO_STATUS.PICO_INVALID_DEVICE_RESOLUTION => "PICO_INVALID_DEVICE_RESOLUTION",            
  PICO_STATUS.PICO_INVALID_NUMBER_CHANNELS_FOR_RESOLUTION => "PICO_INVALID_NUMBER_CHANNELS_FOR_RESOLUTION", 
  PICO_STATUS.PICO_CHANNEL_DISABLED_DUE_TO_USB_POWERED => "PICO_CHANNEL_DISABLED_DUE_TO_USB_POWERED",  
  PICO_STATUS.PICO_SIGGEN_DC_VOLTAGE_NOT_CONFIGURABLE => "PICO_SIGGEN_DC_VOLTAGE_NOT_CONFIGURABLE",   
  PICO_STATUS.PICO_NO_TRIGGER_ENABLED_FOR_TRIGGER_IN_PRE_TRIG => "PICO_NO_TRIGGER_ENABLED_FOR_TRIGGER_IN_PRE_TRIG",
  PICO_STATUS.PICO_TRIGGER_WITHIN_PRE_TRIG_NOT_ARMED => "PICO_TRIGGER_WITHIN_PRE_TRIG_NOT_ARMED",         
  PICO_STATUS.PICO_TRIGGER_WITHIN_PRE_NOT_ALLOWED_WITH_DELAY => "PICO_TRIGGER_WITHIN_PRE_NOT_ALLOWED_WITH_DELAY", 
  PICO_STATUS.PICO_TRIGGER_INDEX_UNAVAILABLE => "PICO_TRIGGER_INDEX_UNAVAILABLE",                 
  PICO_STATUS.PICO_AWG_CLOCK_FREQUENCY => "PICO_AWG_CLOCK_FREQUENCY",                
  PICO_STATUS.PICO_TOO_MANY_CHANNELS_IN_USE => "PICO_TOO_MANY_CHANNELS_IN_USE",           
  PICO_STATUS.PICO_NULL_CONDITIONS => "PICO_NULL_CONDITIONS",                    
  PICO_STATUS.PICO_DUPLICATE_CONDITION_SOURCE => "PICO_DUPLICATE_CONDITION_SOURCE",           
  PICO_STATUS.PICO_INVALID_CONDITION_INFO => "PICO_INVALID_CONDITION_INFO",               
  PICO_STATUS.PICO_SETTINGS_READ_FAILED => "PICO_SETTINGS_READ_FAILED",               
  PICO_STATUS.PICO_SETTINGS_WRITE_FAILED => "PICO_SETTINGS_WRITE_FAILED",              
  PICO_STATUS.PICO_ARGUMENT_OUT_OF_RANGE => "PICO_ARGUMENT_OUT_OF_RANGE",              
  PICO_STATUS.PICO_HARDWARE_VERSION_NOT_SUPPORTED => "PICO_HARDWARE_VERSION_NOT_SUPPORTED",     
  PICO_STATUS.PICO_DIGITAL_HARDWARE_VERSION_NOT_SUPPORTED => "PICO_DIGITAL_HARDWARE_VERSION_NOT_SUPPORTED",     
  PICO_STATUS.PICO_ANALOGUE_HARDWARE_VERSION_NOT_SUPPORTED => "PICO_ANALOGUE_HARDWARE_VERSION_NOT_SUPPORTED",      
  PICO_STATUS.PICO_UNABLE_TO_CONVERT_TO_RESISTANCE => "PICO_UNABLE_TO_CONVERT_TO_RESISTANCE",    
  PICO_STATUS.PICO_DUPLICATED_CHANNEL => "PICO_DUPLICATED_CHANNEL",                 
  PICO_STATUS.PICO_INVALID_RESISTANCE_CONVERSION => "PICO_INVALID_RESISTANCE_CONVERSION",      
  PICO_STATUS.PICO_INVALID_VALUE_IN_MAX_BUFFER => "PICO_INVALID_VALUE_IN_MAX_BUFFER",        
  PICO_STATUS.PICO_INVALID_VALUE_IN_MIN_BUFFER => "PICO_INVALID_VALUE_IN_MIN_BUFFER",        
  PICO_STATUS.PICO_SIGGEN_FREQUENCY_OUT_OF_RANGE => "PICO_SIGGEN_FREQUENCY_OUT_OF_RANGE",      
  PICO_STATUS.PICO_EEPROM2_CORRUPT => "PICO_EEPROM2_CORRUPT",                    
  PICO_STATUS.PICO_EEPROM2_FAIL => "PICO_EEPROM2_FAIL",                       
  PICO_STATUS.PICO_DEVICE_TIME_STAMP_RESET => "PICO_DEVICE_TIME_STAMP_RESET",            
  PICO_STATUS.PICO_WATCHDOGTIMER => "PICO_WATCHDOGTIMER",                      
  PICO_STATUS.PICO_IPP_NOT_FOUND => "PICO_IPP_NOT_FOUND",                      
  PICO_STATUS.PICO_IPP_NO_FUNCTION => "PICO_IPP_NO_FUNCTION",                    
  PICO_STATUS.PICO_IPP_ERROR => "PICO_IPP_ERROR",                          
  PICO_STATUS.PICO_SHADOW_CAL_NOT_AVAILABLE => "PICO_SHADOW_CAL_NOT_AVAILABLE",           
  PICO_STATUS.PICO_SHADOW_CAL_DISABLED => "PICO_SHADOW_CAL_DISABLED",                
  PICO_STATUS.PICO_SHADOW_CAL_ERROR => "PICO_SHADOW_CAL_ERROR",                   
  PICO_STATUS.PICO_SHADOW_CAL_CORRUPT => "PICO_SHADOW_CAL_CORRUPT")
# end Dict

function Base.showerror(io::IO, e::PicoScopeError)
  errortext = get(picoscopestatusdict,UInt32(e.picostatus),"Code Not Found")
  print(io, "PicoScopeError: ",errortext)
end

function checkstatus(picostatus::PicoStatus)
  if picostatus != PICO_STATUS.PICO_OK 
    throw(PicoScopeError(picostatus))
  end
  return nothing
end