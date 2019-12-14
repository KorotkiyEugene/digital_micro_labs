# Create new modelsim working library

vlib work

# Compile all the Verilog sources in current folder into working library

vlog  sin_gen.v sin_gen_tb.v

# Open testbench module for simulation

vsim -novopt work.testbench

# Add all testbench signals to waveform diagram

add wave /testbench/i_clk
add wave /testbench/i_rst_n
add wave -format Analog-Step -height 84 -max 255.0 -radix unsigned /testbench/o_dac

# Run simulation
run -all


