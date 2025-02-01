module slave_valid_ready_hs(aclk, rstn, m_valid, m_data, s_ready, s_data);
input aclk, rstn;
input m_valid;
input [7:0] m_data;
output reg s_ready;
output reg [7:0] s_data;

///Defining state of slave ready-valid handshake
parameter slave_ready = 0, recieve_data = 1;
reg [1:0] s_state;


initial begin
    s_state = 0; s_ready = 0; s_data = 0;
end

always @(posedge aclk ) begin
    if(rstn == 1'b0) begin
        s_data <= 0;
        s_ready <= 0;
    end
    else begin
        case(s_state)
            slave_ready : begin
                s_ready <= 1;
                s_state <= recieve_data;
            end

            recieve_data : begin
                if(m_valid) begin
                    s_data <= m_data;
                    s_ready <= 0;
                    s_state <= slave_ready;
                end
                else 
                    s_state <= slave_ready; 
            end
        endcase
    end
end

endmodule