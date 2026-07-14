`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2026 01:40:22 PM
// Design Name: 
// Module Name: main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main(
        input wire sysclk,
        input wire [11:0] adc_data,
        output wire adc_clk,
        output reg [1:0] led
    );
    
//    wire clk12_ibuf;
//    wire clk12_global;
    wire clk20;
    wire clock_locked;
    
    reg [11:0] captured_data;
    
    
    
    clk_wiz_0 clock_generator(
        .clk_in1(sysclk),
        .clk_out1(clk20),
        .locked(clock_locked),
        .reset(1'b0)
    );
    
    ODDR #(
        .DDR_CLK_EDGE("SAME_EDGE")
    )adc_clock_output(
        .Q(adc_clk),
        .C(clk20),
        .CE(1'b1),
        .D1(1'b1),
        .D2(1'b0),
        .R(1'b0),
        .S(1'b0)
    );
    
    always @(posedge clk20) begin
        if (clock_locked) begin
            captured_data <= adc_data;
            led <= adc_data[11:10];
        end
        else begin
            captured_data <= 12'd0;
            led <= 2'b00;
        end
    end
     
    
    
endmodule
