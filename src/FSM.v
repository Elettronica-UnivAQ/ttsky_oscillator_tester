// FSM for oscillator_tester. Main purpose is to define the 1s time interval of the frequency measurement. 
//Provides start, reset and output enable signals to modules.  


module FSM (
    input wire clk,
    input wire rst,
    input wire osc,
    input wire end_meas,
    output reg start_stop,
    output reg reset,
    output reg data_valid,
    output reg reg_out);

    // State def:
 reg [1:0] state, next_state;
 
 parameter IDLE  = 2'b00, RUN   = 2'b01, WRITE = 2'b10, DATA_VALID = 2'b11;



    // State update:
    always @(posedge clk) 
     begin
     if (rst) begin
     	state <= IDLE;
     	end
     else
        state <= next_state;
    end

    // State evo function:
    always @(*) begin
        case (state)
            IDLE: begin
            	start_stop = 1'b0;
        	reset      = 1'b1;
        	reg_out    = 1'b0;
        	data_valid = 1'b0;
                if (osc == 1'b1)
                    next_state = RUN;
                else
                    next_state = IDLE;
            end

            RUN: begin
            	start_stop = 1'b1;
        	reset      = 1'b0;
        	reg_out    = 1'b0;
        	data_valid = 1'b0;
                if (end_meas == 1'b1)
                    next_state = WRITE;
                else
                    next_state = RUN;
            end

            WRITE: begin
                next_state = DATA_VALID;
                start_stop = 1'b0;
        	reset      = 1'b0;
        	reg_out    = 1'b1;
        	data_valid = 1'b0;
            end
	    
	    DATA_VALID: begin
	    	next_state = IDLE;
	    	start_stop = 1'b0;
        	reset        = 1'b0;
        	reg_out    = 1'b0;
        	data_valid = 1'b1;
            end 
            
            default: begin
            	next_state = IDLE;
            	start_stop = 1'b0;
        	reset      = 1'b0;
        	reg_out    = 1'b0;
        	data_valid = 1'b0;
            end
        endcase
    end



endmodule

