`timescale 1ns / 1ps

module tb_uart_rx();

    // -------------------------------------------------------------------------
    // Signals
    // -------------------------------------------------------------------------
    logic clk;
    logic rst_n;
    logic rx;
    logic tick;
    
    logic [7:0] data_out;
    logic data_valid;

    // -------------------------------------------------------------------------
    // Unit Under Test (UUT)
    // -------------------------------------------------------------------------
    uart_rx uut (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .tick(tick),
        .data_out(data_out),
        .data_valid(data_valid)
    );

    // -------------------------------------------------------------------------
    // Clock and Tick Generation
    // -------------------------------------------------------------------------
    // 100 MHz clock (10ns period)
    always #5 clk = ~clk;

    // Generate the baud tick (1 pulse every 54 clock cycles for 115200 baud)
    integer tick_counter = 0;
    always @(posedge clk) begin
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
    // UART TX Task (Simulates a PC sending data)
    // -------------------------------------------------------------------------
    // One full bit period = 16 ticks. 1 tick = 540ns. So 1 bit = 8640ns.
    localparam BIT_PERIOD = 8640; 

    task send_byte(input logic [7:0] data_to_send);
        integer i;
        begin
            // 1. Send Start Bit (Drive rx low)
            rx = 1'b0;
            #(BIT_PERIOD);

            // 2. Send 8 Data Bits (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                rx = data_to_send[i];
                #(BIT_PERIOD);
            end

            // 3. Send Stop Bit (Drive rx high)
            rx = 1'b1;
            #(BIT_PERIOD);
        end
    endtask

    // -------------------------------------------------------------------------
    // Test Sequence
    // -------------------------------------------------------------------------
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        rx = 1; // Idle state for UART is high
        
        // Hold reset for a few cycles
        #50;
        rst_n = 1;
        #100;

        $display("--- Starting UART RX Test ---");

        // Test 1: Send 8'hA5 (Binary: 10100101) - Good for testing alternating bits
        $display("Sending 0xA5...");
        send_byte(8'hA5);
        
        // Wait to observe the data_valid pulse
        #200; 

        // Test 2: Send 8'h3C (Binary: 00111100)
        $display("Sending 0x3C...");
        send_byte(8'h3C);
        
        #500;
        $display("--- Test Complete ---");
        $finish;
    end

endmodule