`timescale 1ns / 1ps


module led_run_38_tb();

    reg Clk;
    reg Reset_n;
    wire [7:0]LED;

led_run led_run_38_inst0(
    .Clk(Clk),
    .Reset_n(Reset_n),
    .LED(LED)
);
initial Clk = 1;
always #10 Clk = ~Clk;
initial begin
    Reset_n = 0;
    
    #201;
    Reset_n = 1;
    #2000000000;
    #2000000000;
    $stop;
end

endmodule
