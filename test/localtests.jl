# localtests.jl

# need scope attached for these

using PicoScope
using Base.Test

# ps3000_open_unit_async() cannot be called after 
# handle = ps3000_open_unit(); ps3000_close_unit(handle)
# need to restart julia session.  do not know why.
print("testing ps3000_open_unit_async, ps3000_open_unit_progress...")
open_async_status = ps3000_open_unit_async()
if open_async_status == 0
  println()
  println("there is a previous open operation in progress")
  @test open_async_status == 0
end
progress_percent = 0x0000
handle = 0x0000
while progress_percent<100
  (handle, progress_percent) = ps3000_open_unit_progress()
#  println(handle,"    ",progress_percent)
  wait(Timer(0.5))
end
ps3000_close_unit(handle)
println("done")

print("testing ps3000_open_unit, ps3000_close_unit...")
handle = ps3000_open_unit()
@test handle != 0
ps3000_close_unit(handle)
println("done")

print("opening scope for multiple tests...")
handle = ps3000_open_unit()
# make sure scope closes even if we have errors
close_unit_atexit() = ps3000_close_unit(handle)
atexit(close_unit_atexit)
println("done")

print("testing ps3000_flash_led...")
ps3000_flash_led(handle)
println("done")

println("testing ps3000_get_unit_info...")
unitinfo = ps3000_get_unit_info(handle)
println("  PS3000_DRIVER_VERSION   : ",unitinfo[1])
println("  PS3000_USB_VERSION      : ",unitinfo[2])
println("  PS3000_HARDWARE_VERSION : ",unitinfo[3])
println("  PS3000_VARIANT_INFO     : ",unitinfo[4])
println("  PS3000_BATCH_AND_SERIAL : ",unitinfo[5])
println("  PS3000_CAL_DATE         : ",unitinfo[6])
println("  PS3000_ERROR_CODE       : ",unitinfo[7])
println("testing ps3000_get_unit_info, done")

print("testing ps3000_set_channel...")
enabled = true
dc_coupling = true
ps3000_set_channel(handle, PS3000Channel.A, enabled, dc_coupling, PS3000Range.V1)
println("done")

# only 3204, 3205, 3206 support ETS
if in(unitinfo[4] ,Set(["3204","3205","3206"]))
  println("testing ps3000_set_ets...")
  ets_interleave = 10
  ets_cycles = 4*ets_interleave
  effective_sample_time = ps3000_set_ets(handle, PS3000ETSMode.SLOW, ets_cycles,
                                         ets_interleave)
  println("effective sample time : ",effective_sample_time,"ps")
  println("testing ps3000_set_ets, done")
end

print("testing ps3000_set_trigger...")
threshold = 0
delay = -50
autotriggerms = 100
ps3000_set_trigger(handle, PS3000Source.CHANNEL_A, threshold,
                    PS3000Direction.RISING, delay, autotriggerms)
println("done")

print("testing ps3000_set_trigger2...")
delay = -50.0  # float for ps3000_set_trigger2
# both calls shoud be the same
ps3000_set_trigger(handle, PS3000Source.CHANNEL_A, threshold,
                    PS3000Direction.RISING, delay, autotriggerms)
ps3000_set_trigger2(handle, PS3000Source.CHANNEL_A, threshold,
                    PS3000Direction.RISING, delay, autotriggerms)
println("done")

print("testing ps3000_get_timebase...")
timebase = 5 #  0 is fastest timebase, 1 is 2x period of 0, etc.
number_of_samples = 1000
oversample = 2
(time_interval, time_units, max_samples) =
  ps3000_get_timebase(handle, timebase, number_of_samples, oversample)
println("done")

println("tetsing ps3000_run_block...")
time_for_adc_to_collect_data_ms = 
  ps3000_run_block(handle, number_of_samples, timebase, oversample)
println("  time for ADC to collect data = ",time_for_adc_to_collect_data_ms,"ms")
println("tetsing ps3000_run_block, done")

print("testing ps3000_ready...")
while ~ps3000_ready(handle); end
println("done")

print("testing ps3000_get_values!...")
vbuffer = ValueBuffer(number_of_samples)
(values_per_channel_returned, overflow) = 
  ps3000_get_values!(handle,vbuffer,number_of_samples)
if overflow != 0
  print(" overflow! ")
end
@test values_per_channel_returned == number_of_samples
println("done")

print("testing ps3000_get_times_and_values!...")
time_for_adc_to_collect_data_ms = 
  ps3000_run_block(handle, number_of_samples, timebase, oversample)
while ~ps3000_ready(handle); end
vtbuffer = TimesAndValuesBuffer(number_of_samples)
(values_per_channel_returned, overflow) = 
  ps3000_get_times_and_values!(handle, vtbuffer, time_units, number_of_samples)
if overflow != 0
  print(" overflow! ")
end
@test values_per_channel_returned == number_of_samples
println("done")

print("testing ps3000_stop...")
ps3000_stop(handle)
println("done")

print("closing scope...")
ps3000_close_unit(handle)
println("done")

print("testing ps3000setadvtriggerchannelconditions...")
handle = ps3000_open_unit()
tsc = TriggerConditions(PS3000TriggerState.CONDITION_TRUE,
                        PS3000TriggerState.CONDITION_DONT_CARE,
                        PS3000TriggerState.CONDITION_DONT_CARE,
                        PS3000TriggerState.CONDITION_DONT_CARE,
                        PS3000TriggerState.CONDITION_DONT_CARE)
ps3000setadvtriggerchannelconditions(handle,tsc)
ps3000setadvtriggerchannelconditions(handle) # turn conditions off
ps3000_close_unit(handle)
println("done")

print("testing ps3000setadvtriggerchanneldirections...")
handle = ps3000_open_unit()
ps3000setadvtriggerchanneldirections(handle,
  PS3000ThresholdDirection.ABOVE,
  PS3000ThresholdDirection.BELOW,
  PS3000ThresholdDirection.RISING,
  PS3000ThresholdDirection.FALLING,
  PS3000ThresholdDirection.RISING_OR_FALLING)
ps3000_close_unit(handle)
println("done")

print("testing ps3000setadvtriggerchannelproperties...")
handle = ps3000_open_unit()
thresholdmajor = 1000 # scaled in 16-bit ADC counts
thresholdminor = 900  # scaled in 16-bit ADC counts
hysteresis = 10        # scaled in 16-bit ADC counts
channel = 0           # A = 0, B = 1, C = 2, D = 3 I assume.
thresholdmode = PS3000ThresholdMode.level
cp = TriggerChannelProperties(thresholdmajor, thresholdminor,
                              hysteresis, channel, thresholdmode)
autotriggerms = 100
ps3000setadvtriggerchannelproperties(handle,cp,autotriggerms)
ps3000_close_unit(handle)
println("done")

print("testing ps3000setadvtriggerdelay...")
handle = ps3000_open_unit()
delay = 50
pretriggerdelay = Float32(10.0)
ps3000setadvtriggerdelay(handle, delay, pretriggerdelay)
ps3000_close_unit(handle)
println("done")

print("testing ps3000setpulsewidthqualifier...")
handle = ps3000_open_unit()
conditions = PWQConditions(PS3000TriggerState.CONDITION_TRUE,
                           PS3000TriggerState.CONDITION_DONT_CARE,
                           PS3000TriggerState.CONDITION_DONT_CARE,
                           PS3000TriggerState.CONDITION_DONT_CARE,
                           PS3000TriggerState.CONDITION_DONT_CARE)
direction = PS3000ThresholdDirection.RISING
lower = 1000
upper = 100000
pwtype = PWType.LESS_THAN
ps3000setpulsewidthqualifier(handle, conditions, direction, lower, upper, pwtype)
ps3000setpulsewidthqualifier(handle) # disable pulse width conditions
ps3000_close_unit(handle)
println("done")

# include("compatiblestreamingmodetest.jl")
# include("faststreamingmodetest.jl")
