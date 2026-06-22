`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/22/2026 11:36:32 AM
// Design Name: 
// Module Name: tb_baud_gen
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


module tb_baud_gen();

logic clk;
logic reset_n;
logic tick;

baud_gen #(
    .BAUD_RATE(115200),
    .CLK_FREQ(100_000_000)
) uut (
    .clk(clk),
    .rst_n(reset_n),
    .tick(tick)
);


always #5 clk = ~clk; // 100 MHz clock

initial begin   
    clk = 0;
    reset_n = 0;
    #20; 
    reset_n = 1;

    #2000
    $display("Test completed");
    $finish;
end
endmodule
