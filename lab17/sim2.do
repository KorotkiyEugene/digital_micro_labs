###########################
# Simple modelsim do file #
###########################

# Delete old compilation results
if { [file exists "work"] } {
    vdel -all
}

# Create new modelsim working library

vlib work

# Compile all the Verilog sources in current folder into working library

vlog  mips_tb2.v mips_soc.v mips_core.v ram.v rom.v regfile.v main_ctrl.v alu_ctrl.v alu.v addr_decoder.v buttons.v leds.v displays7seg.v

# Open testbench module for simulation

vsim -novopt work.mips_tb2

# Add all testbench signals to waveform diagram

add wave /mips_tb2/mips_soc_inst/*

onbreak resume

# Run simulation
run -all

wave zoom full
