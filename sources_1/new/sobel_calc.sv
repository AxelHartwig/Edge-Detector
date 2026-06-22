`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2026 01:24:48 AM
// Design Name: 
// Module Name: sobel_calc
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


module sobel_calc(
    input logic clk,
    input logic rst_n,
    input logic [7:0] p00, p01, p02, p10, p11, p12, p20, p21, p22,
    input logic window_valid,
    output logic [7:0] pixel_out,
    output logic valid_out
    );
endmodule
