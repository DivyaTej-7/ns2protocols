set ns [new Simulator]
set tracefile [open dsdv_trace.tr w]
$ns trace-all $tracefile
set namfile [open dsdv_simulation.nam w]
$ns namtrace-all $namfile
proc finish {} {
global ns tracefile namfile
$ns flush-trace
close $tracefile
close $namfile
exec nam dsdv_simulation.nam &
exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
$ns duplex-link $n2 $n1 2Mb 10ms DropTail
$ns duplex-link $n1 $n0 2Mb 10ms DropTail
$ns duplex-link $n0 $n3 2Mb 10ms DropTail
$ns duplex-link $n3 $n4 2Mb 10ms DropTail
$ns duplex-link $n4 $n5 2Mb 10ms DropTail
$ns duplex-link $n5 $n6 2Mb 10ms DropTail
$ns duplex-link $n6 $n7 2Mb 10ms DropTail
$ns duplex-link $n7 $n9 2Mb 10ms DropTail
$ns duplex-link $n9 $n8 2Mb 10ms DropTail
set opt(adhocRouting) DSDV
set udp0 [new Agent/UDP]
$ns attach-agent $n2 $udp0
set null0 [new Agent/Null]
$ns attach-agent $n8 $null0
$ns connect $udp0 $null0
set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 512
$cbr set interval_ 0.2
$cbr attach-agent $udp0
$ns at 1.0 "$cbr start"
$ns at 4.0 "$cbr stop"
$ns at 5.0 "finish"
$ns run
