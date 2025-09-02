//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2025 11:50:45
// Design Name: 
// Module Name: oscillator_tester
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: The circuit is designed to test any ring oscillator output frequency. 
//              Frequency range: 1-250kHz;
//              Resolution: 1kHz.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module oscillator_tester (
    input wire osc,
    input wire clk,
    input wire rst,
    output wire [7:0] measure,
    output wire data_valid
);

wire start, reset, osc_sync, reg_out, up_count, end_meas;
wire [7:0] reg_in;

// Structural description
FSM fsm_inst (
    .osc(osc_sync),
    .rst(rst),
    .clk(clk),
    .end_meas(end_meas),
    .start_stop(start),
    .reset(reset),
    .data_valid(data_valid),
    .reg_out(reg_out)
);

Timer timer_inst (
    .clk(clk),
    .start(start),
    .rst(reset),
    .end_meas(end_meas)
);

synchronizer sync_inst (
    .clk(clk),
    .data_in(osc),
    .data_out(osc_sync)
);

counter_1k_cycles counter_1k_inst (
    .clk(osc_sync),
    .rst(reset),
    .start(start),
    .incr(up_count)
);

counter_8bit counter_8bit_inst (
    .clk(up_count),
    .rst(reset),
    .count(reg_in)
);

PIPO_8bit out_reg_inst (
    .clk(reg_out),
    .rst(reset),
    .data_in(reg_in),
    .data_out(measure)
);

endmodule

