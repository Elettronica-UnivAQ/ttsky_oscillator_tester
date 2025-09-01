/*
 * Copyright (c) 2024 Pietro Paolo Scimia
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_Scimia_oscillator_tester (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  
  wire rst;
  assign rst = ~rst_n;
  assign uio_oe = 8'b0000_0001;
  assign uio_out[7:1] = 7'b0000_000;
  
  oscillator_tester oscillator_tester (
    .osc(ui_in[0]), 			// input signal to be checked
    .clk(clk),				// system clock
    .rst(rst),				// system reset (active high)
    .measure(uo_out),			// frequency data out
    .data_valid(uio_out[0])		// data valid signal
);

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[7:1], uio_in, 1'b0};

endmodule
