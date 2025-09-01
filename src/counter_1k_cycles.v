
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2025 11:06:25
// Design Name: 
// Module Name: counter_1k_cycles
// Project Name: oscillator_tester
// Target Devices: 
// Tool Versions: 
// Description: 10 bit counter for oscillator tester. Aim of the module is conversion from Hz to kHz. 
//              Threshold is set to 999, where the output signal incr goes high.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module counter_1k_cycles (
    input wire clk,
    input wire rst,
    input wire start,
    output reg incr
);

reg [9:0] count;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 10'd0;
    end else if (start) begin
        if (count < 10'd999) begin
            count <= count + 1;
        end else begin
            count <= 10'd0;
        end
    end
end

always @(*) begin
    if (count == 10'd999)
        incr = 1'b1;
    else
        incr = 1'b0;
     
end

endmodule

