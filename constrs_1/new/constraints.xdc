# ==============================================================================
# System Clock (100 MHz)
# ==============================================================================
# Alchitry Au onboard 100MHz clock
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports { clk }]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }]

# ==============================================================================
# Reset (Active Low)
# ==============================================================================
# Alchitry Au onboard reset button
set_property -dict { PACKAGE_PIN P6 IOSTANDARD LVCMOS33 } [get_ports { rst_n }]

# ==============================================================================
# USB-to-UART Bridge
# ==============================================================================
# Alchitry Au FTDI USB UART pins
# 'rx' is the FPGA receiving data from the PC (usb_rx)
set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports { uart_rx_pin }]

# 'tx' is the FPGA sending data back to the PC (usb_tx)
set_property -dict { PACKAGE_PIN P16 IOSTANDARD LVCMOS33 } [get_ports { uart_tx_pin }]