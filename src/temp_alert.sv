`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026-06-27
// Design Name: Temperature Alert System
// Module Name: temp_alert
// Project Name: Temperature Monitoring
// Target Devices: Generic FPGA / ASIC
// Description: Real-time temperature monitoring and alert logic.
//              Triggers a buzzer and display alert if the temperature
//              exceeds a threshold for a set number of clock cycles to avoid glitches.
//
// Dependencies: None
// 
//////////////////////////////////////////////////////////////////////////////////

module temp_alert #(
    parameter DATA_WIDTH = 8,
    parameter DEBOUNCE_LIMIT = 4 // Number of cycles temp must be above threshold to trigger alert
)(
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic [DATA_WIDTH-1:0]   temp_data,
    input  logic [DATA_WIDTH-1:0]   temp_threshold,
    output logic                    buzzer_on,
    output logic                    display_alert
);

    // Internal registers
    logic [3:0] over_threshold_counter;
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            over_threshold_counter <= 4'd0;
            buzzer_on              <= 1'b0;
            display_alert          <= 1'b0;
        end else begin
            if (temp_data > temp_threshold) begin
                // Increment counter if not at limit
                if (over_threshold_counter < DEBOUNCE_LIMIT) begin
                    over_threshold_counter <= over_threshold_counter + 1'b1;
                end
            end else begin
                // Reset counter if temperature falls below or equals threshold
                over_threshold_counter <= 4'd0;
            end
            
            // Trigger alert if condition has been sustained
            if (over_threshold_counter >= (DEBOUNCE_LIMIT - 1) && (temp_data > temp_threshold)) begin
                buzzer_on     <= 1'b1;
                display_alert <= 1'b1;
            end else begin
                buzzer_on     <= 1'b0;
                display_alert <= 1'b0;
            end
        end
    end

endmodule
