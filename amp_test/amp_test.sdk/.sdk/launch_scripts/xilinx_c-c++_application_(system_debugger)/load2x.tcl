connect -url tcp:127.0.0.1:3121
source /home/link/fpga/projects/xilinx_amp_test/amp_test/amp_test.sdk/design_1_wrapper_hw_platform_0/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Platform Cable USB 13620207920db7"} -index 0
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Platform Cable USB 13620207920db7" && level==0} -index 1
fpga -file /home/link/fpga/projects/xilinx_amp_test/amp_test/amp_test.sdk/design_1_wrapper_hw_platform_0/design_1_wrapper.bit
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Platform Cable USB 13620207920db7"} -index 0
loadhw -hw /home/link/fpga/projects/xilinx_amp_test/amp_test/amp_test.sdk/design_1_wrapper_hw_platform_0/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Platform Cable USB 13620207920db7"} -index 0
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Platform Cable USB 13620207920db7"} -index 0
dow /home/link/fpga/projects/xilinx_amp_test/amp_test/amp_test.sdk/cpu0_app/Debug/cpu0_app.elf
targets -set -nocase -filter {name =~ "ARM*#1" && jtag_cable_name =~ "Platform Cable USB 13620207920db7"} -index 0
dow /home/link/fpga/projects/xilinx_amp_test/amp_test/amp_test.sdk/cpu1_app/Debug/cpu1_app.elf
configparams force-mem-access 0
bpadd -addr &main
