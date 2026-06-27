# Makefile for Temperature Alert System

# Tools
IVERILOG = iverilog
VVP = vvp

# Source files
SRC = src/temp_alert.sv
TB = tb/temp_alert_tb.sv

# Output executable
OUT = temp_alert_sim
VCD = temp_alert.vcd

.PHONY: all simulate clean

all: simulate

simulate: $(OUT)
	$(VVP) $(OUT)

$(OUT): $(SRC) $(TB)
	$(IVERILOG) -g2012 -o $(OUT) $(SRC) $(TB)

clean:
	rm -f $(OUT) $(VCD)
