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
// Description: Output 8 bit PIPO register. Keeps a stable output while the measurement is running. 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PIPO_8bit (
    input wire clk,
    input wire rst,
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

always @(posedge clk or posedge rst) begin
    if (rst)
        data_out <= 8'b0;   
    else
        data_out <= data_in;
end

endmodule

