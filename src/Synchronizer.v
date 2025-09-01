//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2025 10:38:23
// Design Name: 
// Module Name: PIPO_8bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Two-stage FF, reducing input related instability
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module synchronizer (
    input wire clk,
    input wire data_in,
    output reg data_out
);

reg first_stage_sample;

always @(posedge clk) begin
    first_stage_sample <= data_in;
    data_out <= first_stage_sample;
end

endmodule

