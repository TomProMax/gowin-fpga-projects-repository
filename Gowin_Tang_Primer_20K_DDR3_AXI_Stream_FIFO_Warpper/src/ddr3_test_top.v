module ddr3_test_top
(
    //sys
    input  wire clk        ,
    input  wire rst_n      ,
    //led
    output wire test_pass
);

wire init_calib_complete;
reg [15:0] cnt;
/*********************************************************************************/
/******************************        fsm          ******************************/
/*********************************************************************************/
localparam IDLE  = 4'b0001;
localparam WRITE = 4'b0010;
localparam READ  = 4'b0100;
localparam DONE  = 4'b1000;

reg [3:0] state;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        state <= IDLE;
    end else begin
        case(state)
            IDLE:begin
                if(init_calib_complete)
                    state <= WRITE;
            end
            WRITE:begin
                
            end
        endcase
    end
end
/*********************************************************************************/
/******************************    instantiation    ******************************/
/*********************************************************************************/

    ddr3_rw_controller u_ddr3_rw_controller (
    .clk                     ( clk                          ),
    .rst_n                   ( rst_n                        ),
    .s_axis_aclk             ( s_axis_aclk                  ),
    .s_axis_tvaild           ( s_axis_tvaild                ),
    .s_axis_tdata            ( s_axis_tdata         [15:0]  ),
    .m_axis_aclk             ( m_axis_aclk                  ),
    .m_axis_tready           ( m_axis_tready                ),

    .init_calib_complete     ( init_calib_complete          ),
    .s_axis_tready           ( s_axis_tready                ),
    .m_axis_tvaild           ( m_axis_tvaild                ),
    .m_axis_tdata            ( m_axis_tdata         [15:0]  ),
    .O_ddr_addr              ( O_ddr_addr           [12:0]  ),
    .O_ddr_ba                ( O_ddr_ba             [2: 0]  ),
    .O_ddr_cs_n              ( O_ddr_cs_n                   ),
    .O_ddr_ras_n             ( O_ddr_ras_n                  ),
    .O_ddr_cas_n             ( O_ddr_cas_n                  ),
    .O_ddr_we_n              ( O_ddr_we_n                   ),
    .O_ddr_clk               ( O_ddr_clk                    ),
    .O_ddr_clk_n             ( O_ddr_clk_n                  ),
    .O_ddr_cke               ( O_ddr_cke                    ),
    .O_ddr_odt               ( O_ddr_odt                    ),
    .O_ddr_reset_n           ( O_ddr_reset_n                ),
    .O_ddr_dqm               ( O_ddr_dqm            [1: 0]  ),

    .IO_ddr_dq               ( IO_ddr_dq            [15: 0] ),
    .IO_ddr_dqs              ( IO_ddr_dqs           [1: 0]  ),
    .IO_ddr_dqs_n            ( IO_ddr_dqs_n         [1: 0]  )
);
endmodule