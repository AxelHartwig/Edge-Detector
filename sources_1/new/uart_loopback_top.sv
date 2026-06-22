`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2026 11:29:48 AM
// Design Name: 
// Module Name: uart_loopback_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_loopback_top(
    input  logic clk,
    input  logic rst_n,
    input  logic uart_rx_pin,
    output logic uart_tx_pin
    );

logic tick;
logic [7:0] loopback_data;
logic data_valid;

baud_gen #(
    .CLK_FREQ(100_000_000),
    .BAUD_RATE(115_200)
)
baud_gen_inst (
    .clk(clk),
    .rst_n(rst_n),
    .tick(tick)
);

uart_rx rx_inst (
    .clk(clk),
    .rst_n(rst_n),
    .rx(uart_rx_pin),
    .tick(tick),
    .data_out(loopback_data),
    .data_valid(data_valid)
);

uart_tx tx_inst (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(loopback_data),
    .data_valid(data_valid),
    .tick(tick),
    .tx(uart_tx_pin)
);
endmodule
