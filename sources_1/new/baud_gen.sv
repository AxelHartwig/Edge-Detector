`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2026 11:30:14 AM
// Design Name: 
// Module Name: baud_gen
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


module baud_gen #(
    parameter BAUD_RATE = 115200,
    parameter CLK_FREQ = 100_000_000
)(
    input logic clk,
    input logic rst_n,
    output logic tick
);

localparam MAX_COUNT = CLK_FREQ / (BAUD_RATE * 16);

reg [$clog2(MAX_COUNT)-1:0] count;

always_ff @(posedge clk) begin
    if (!rst_n) begin
        count <= 0;
        tick <= 0;
    end else if (count == MAX_COUNT - 1) begin
        count <= 0;
        tick <= 1;
    end else begin
        count <= count + 1;
        tick <= 0;
    end
end

endmodule
