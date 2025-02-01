`include "master_valid_ready_hs.v"
`include "slave_ready_valid_hs.v"

module top();
reg aclk = 0, rstn = 0;
wire [7:0] m_data, s_data;
wire s_ready, m_valid;
always #10 aclk = ~aclk;

initial begin
    repeat(10)@(posedge aclk);
    rstn = 1;
end

initial begin
    $dumpvars();
    $dumpfile("dump.vcd");

    #1000;
    $stop;
end

master_ready_valid_hs m_dut(aclk, rstn, s_ready, m_data, m_valid);

slave_valid_ready_hs s_dut(aclk, rstn, m_valid, m_data, s_ready, s_data);

endmodule
