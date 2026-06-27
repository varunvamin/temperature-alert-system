# Temperature Alert System

![Verilog](https://img.shields.io/badge/Language-SystemVerilog-blue)
![Status](https://img.shields.io/badge/Status-Complete-green)

A SystemVerilog-based temperature monitoring system featuring real-time alert logic for abnormal conditions. This project demonstrates synchronous digital design, debouncing logic, and hardware verification techniques.

## Features
- **Real-Time Monitoring:** Continuously evaluates incoming temperature data against a configurable threshold.
- **Glitch Filtering (Debouncing):** Prevents false alarms by ensuring the abnormal temperature is sustained for a predefined number of clock cycles before triggering.
- **Hardware Alerts:** Triggers `buzzer_on` and `display_alert` signals when abnormal conditions are verified.
- **Automated Verification:** Comprehensive SystemVerilog testbench included for validating normal conditions, transient spikes, and sustained abnormal temperatures.

## Architecture

The core component is the `temp_alert` module:

- **Inputs:** 
  - `clk` (System clock)
  - `rst_n` (Active-low reset)
  - `temp_data` (Configurable width, default 8-bit sensor data)
  - `temp_threshold` (Configurable alert threshold)
- **Outputs:**
  - `buzzer_on` (Active-high alert logic)
  - `display_alert` (Active-high UI trigger)

## Testbench & Simulation

The testbench (`temp_alert_tb.sv`) validates the system reliability through the following scenarios:
1. **Normal Conditions:** The temperature stays below the threshold. Alerts remain deactivated.
2. **Brief Spikes (Glitch Testing):** A temperature spike lasting fewer cycles than the debounce limit. Alerts are correctly suppressed.
3. **Sustained Abnormal Conditions:** The temperature exceeds the threshold for a sustained period. Alerts are successfully triggered.
4. **Recovery:** The temperature drops back to a safe level, and the system seamlessly deactivates the alerts.

### How to Run Simulation

You can simulate this design using any standard SystemVerilog simulator such as Icarus Verilog or ModelSim.

Using **Icarus Verilog**:
```bash
iverilog -g2012 -o temp_alert_sim src/temp_alert.sv tb/temp_alert_tb.sv
vvp temp_alert_sim
```

To view waveforms, you can open the generated `temp_alert.vcd` file in GTKWave:
```bash
gtkwave temp_alert.vcd
```


