//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2025 11:30:11
// Design Name: 
// Module Name: Timer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 26 bit timer for measurement time interval definition. Thresold set to 49.999.999 cycles defines a 1s interval due a 50MHz clk. 
//              Provides a end_meas signal to FSM.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Timer (
    input wire clk,
    input wire start,
    input wire rst,
    output reg end_meas
);

reg [25:0] tempo;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        tempo <= 26'd0;
    end else if (start) begin
        if (tempo < 26'd49999999) begin
            tempo <= tempo + 1;
        end
    end
end

always @(*) begin
    if (tempo == 26'd49999999)
        end_meas = 1'b1;
    else
        end_meas = 1'b0;
end

endmodule

