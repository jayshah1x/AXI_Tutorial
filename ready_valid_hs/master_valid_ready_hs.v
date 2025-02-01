module master_ready_valid_hs(aclk, rstn, s_ready, m_data, m_valid);
input aclk, rstn;
input s_ready;
output reg [7:0] m_data;
output reg m_valid;


//Defining state of master ready-valid handshake
parameter new_data = 0, wait_for_slave = 1;

reg [1:0] m_state;

initial begin
    m_state = 0; m_data = 0; m_valid = 0;
end



always@(posedge aclk) begin
    if(rstn == 1'b0) begin
        m_valid <= 0;
        m_data <= 0;
    end
    else begin
        case(m_state)
            new_data : begin
                m_data <= $urandom_range(0, 15);
                m_valid <= 1;
                m_state <= wait_for_slave;
            end

            wait_for_slave : begin
                if(s_ready == 1'b1) begin
                    m_valid <= 0;
                    m_state <= new_data;
                end
                else begin
                    m_state <= wait_for_slave;
                end
            end

        endcase
    end
end

endmodule