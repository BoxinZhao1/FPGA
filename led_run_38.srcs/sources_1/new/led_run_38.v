module led_run(
    Clk,
    Reset_n,
    LED
    );
    input                               Clk                        ;
    input                               Reset_n                    ;
    output reg           [   7: 0]      LED                        ;
    
//counter
//500ms
//500ms/20ns = 25000000
//25000000-1, 24999999 = 0
    parameter                           CNT_MAX                     = 25000 - 1'd1;
    reg                [  24: 0]        counter                     ;

//counter 500ms
    always@(posedge Clk or negedge Reset_n)
        if(!Reset_n)
            counter <= 0;
        else if(counter == CNT_MAX)
            counter <= 0;
        else
            counter <= counter + 1'd1;


// //LED flash
//     always@(posedge Clk or negedge Reset_n)
//         if(!Reset_n)
//             LED <= 0;
//         else if(counter == CNT_MAX)
//             LED <= ~LED;
    reg                                 dir                         ;//dir = 0 right shift, dir = 1 left shift
//[7:0]LED shift, CNT_MAX = 25000000-1

    always @(posedge Clk or negedge Reset_n)
        begin
            if(!Reset_n)begin
                   LED <= 8'b10000000;
                dir <= 1'b0;                                        //inital: move right 
            end
            
            else if(counter == CNT_MAX)begin

                if(dir == 0)begin
                    if(LED == 8'b00000001)begin
                        dir <= 1'b1;
                        LED <= LED << 1;
                    end else
                        LED <= LED >> 1;
                end
                    //LED <= LED >> 1;  //0000_0000: led = 0000 0001 dir=1
                else begin
                    if(LED == 8'b10000000)begin
                        dir <= 1'b0;
                        LED <= LED >> 1;
                    end else
                        LED <= LED << 1;
                end
                    
            end
              
        end
endmodule

