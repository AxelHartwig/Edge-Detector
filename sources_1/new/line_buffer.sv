`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 01:23:48 AM
// Design Name: 
// Module Name: line_buffer
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


module line_buffer(
    input logic clk,
    input logic rst_n,
    input logic [7:0] pixel_in,
    input logic valid_in,
    output logic [7:0] p00, p01, p02, p10, p11, p12, p20, p21, p22,
    output logic window_valid
    );
endmodule
