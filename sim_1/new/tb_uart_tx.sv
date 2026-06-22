`timescale 1ns / 1ps

module tb_uart_tx();

    // -------------------------------------------------------------------------
    // Signals
    // -------------------------------------------------------------------------
    logic clk;
    logic rst_n;
    logic tx_start;
    logic tick;
    logic [7:0] data_in;
    
    logic tx;
    logic tx_done;

    // -------------------------------------------------------------------------
    // Unit Under Test (UUT)
    // -------------------------------------------------------------------------
    uart_tx uut (
        .clk(clk),
        .rst_n(rst_n),
        .data_valid(tx_start),
        .tick(tick),
        .data_in(data_in),
        .tx(tx),
        .tx_done(tx_done)
    );

    // -------------------------------------------------------------------------
    // Clock and Tick Generation
    // -------------------------------------------------------------------------
    // 100 MHz clock (10ns period)
    always #5 clk = ~clk;

    // Generate the baud tick (1 pulse every 54 clock cycles for 115200 baud)
    integer tick_counter = 0;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            tick <= 1'b0;
            tick_counter <= 0;
        end else begin
            if (tick_counter == 53) begin
                tick <= 1'b1;
                tick_counter <= 0;
            end else begin
                tick <= 1'b0;
                tick_counter <= tick_counter + 1;
            end
        end
    end

    // -------------------------------------------------------------------------
    // Test Sequence
    // -------------------------------------------------------------------------
    initial begin
        // Initialize inputs
        clk = 0;
        rst_n = 0;
        tx_start = 0;
        data_in = 8'h00;
        
        // Hold reset for a few cycles
        #50;
        rst_n = 1;
        #100;

        $display("--- Starting UART TX Test ---");

        // Test 1: Send 0xA5 (Binary: 10100101)
        $display("Loading 0xA5 into transmitter...");
        data_in  = 8'hA5;
        tx_start = 1'b1; 
        #10;             // Pulse tx_start high for exactly 1 clock cycle
        tx_start = 1'b0;

        // Wait for the transmitter to finish the entire frame
        wait(tx_done == 1'b1);
        $display("0xA5 transmission complete.");
        #500; // Small delay between bytes

        // Test 2: Send 0x3C (Binary: 00111100)
        $display("Loading 0x3C into transmitter...");
        data_in  = 8'h3C;
        tx_start = 1'b1; 
        #10; 
        tx_start = 1'b0;

        // Wait for the transmitter to finish
        wait(tx_done == 1'b1);
        $display("0x3C transmission complete.");
        
        #500;
        $display("--- Test Complete ---");
        $finish;
    end

endmodule