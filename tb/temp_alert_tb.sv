`timescale 1ns / 1ps

module temp_alert_tb;

    // Parameters
    localparam DATA_WIDTH = 8;
    
    // Testbench signals
    logic clk;
    logic rst_n;
    logic [DATA_WIDTH-1:0] temp_data;
    logic [DATA_WIDTH-1:0] temp_threshold;
    logic buzzer_on;
    logic display_alert;
    
    // Instantiate the Unit Under Test (UUT)
    temp_alert #(
        .DATA_WIDTH(DATA_WIDTH),
        .DEBOUNCE_LIMIT(4)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .temp_data(temp_data),
        .temp_threshold(temp_threshold),
        .buzzer_on(buzzer_on),
        .display_alert(display_alert)
    );
    
    // Clock generation (50MHz)
    always #10 clk = ~clk;
    
    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        temp_data = 8'd0;
        temp_threshold = 8'd75; // Set threshold to 75 degrees/units
        
        // Wait for global reset
        #100;
        rst_n = 1;
        
        $display("--- Starting Temperature Alert System Simulation ---");
        
        // Test 1: Normal temperature readings
        $display("[%0t] Test 1: Normal Temperatures", $time);
        temp_data = 8'd25; #40;
        temp_data = 8'd40; #40;
        temp_data = 8'd60; #40;
        
        // Test 2: Brief spike (should NOT trigger alert due to debounce)
        $display("[%0t] Test 2: Brief Temperature Spike (Glitch)", $time);
        temp_data = 8'd80; #20; // Only 1 clock cycle above threshold
        temp_data = 8'd65; #60;
        
        // Test 3: Sustained abnormal temperature (SHOULD trigger alert)
        $display("[%0t] Test 3: Sustained Abnormal Temperature", $time);
        temp_data = 8'd85;
        
        // Wait and observe
        #100;
        if (buzzer_on && display_alert)
            $display("[%0t] SUCCESS: Alerts triggered successfully!", $time);
        else
            $display("[%0t] ERROR: Alerts failed to trigger!", $time);
            
        // Test 4: Temperature returns to normal
        $display("[%0t] Test 4: Temperature returns to normal", $time);
        temp_data = 8'd70;
        #60;
        
        if (!buzzer_on && !display_alert)
            $display("[%0t] SUCCESS: Alerts deactivated successfully!", $time);
        else
            $display("[%0t] ERROR: Alerts failed to deactivate!", $time);
        
        // End simulation
        #100;
        $display("--- Simulation Completed ---");
        $finish;
    end
    
    // Optional: Dump waves
    initial begin
        $dumpfile("temp_alert.vcd");
        $dumpvars(0, temp_alert_tb);
    end

endmodule
