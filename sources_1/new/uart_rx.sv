`timescale 1ns / 1ps

module uart_rx(
    input  logic clk,
    input  logic rst_n,
    input  logic rx,
    input  logic tick,
    output logic [7:0] data_out,
    output logic data_valid
);

    typedef enum logic [1:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t state_reg, state_next;
    logic [2:0] counter8_reg, counter8_next;
    logic [3:0] counter16_reg, counter16_next;
    logic [7:0] shift_reg, shift_next;

    assign data_out = shift_reg;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            state_reg     <= IDLE;
            counter16_reg <= 4'b0;
            counter8_reg  <= 3'b0;
            shift_reg     <= 8'b0;
        end else begin
            state_reg     <= state_next;
            counter16_reg <= counter16_next;
            counter8_reg  <= counter8_next;
            shift_reg     <= shift_next;
        end
    end

    always_comb begin
        state_next     = state_reg;
        counter16_next = counter16_reg;
        counter8_next  = counter8_reg;
        shift_next     = shift_reg;
        data_valid     = 1'b0;

        case (state_reg)
            IDLE: begin
                if (rx == 1'b0) begin
                    state_next     = START;
                    counter16_next = 4'b0;
                end
            end
            
            START: begin
                if (tick) begin
                    if (counter16_reg == 4'd7) begin
                        if (rx == 1'b0) begin
                            state_next     = DATA;
                            counter16_next = 4'b0;
                            counter8_next  = 3'b0;
                        end else begin
                            state_next     = IDLE;
                        end
                    end else begin
                        counter16_next = counter16_reg + 1;
                    end
                end
            end
            
            DATA: begin
                if (tick) begin
                    if (counter16_reg == 4'd15) begin
                        counter16_next = 4'b0;
                        shift_next     = {rx, shift_reg[7:1]};
                        
                        if (counter8_reg == 3'd7) begin
                            state_next = STOP;
                        end else begin
                            counter8_next = counter8_reg + 1;
                        end
                    end else begin
                        counter16_next = counter16_reg + 1;
                    end
                end
            end
            
            STOP: begin
                if (tick) begin
                    if (counter16_reg == 4'd15) begin
                        if (rx == 1'b1) begin
                            data_valid = 1'b1;
                        end
                        state_next     = IDLE;
                    end else begin
                        counter16_next = counter16_reg + 1;
                    end
                end
            end
        endcase
    end
endmodule