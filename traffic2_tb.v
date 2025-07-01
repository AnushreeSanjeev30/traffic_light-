`timescale 1ns / 1ps  

module Traffic_Light_Controller_TB;  
    reg clk, rst;  
    wire [2:0] light_M1;  
    wire [2:0] light_S;  
    wire [2:0] light_MT;  
    wire [2:0] light_M2;  

    Traffic_Light_Controller dut(  
        .clk(clk),   
        .rst(rst),   
        .light_M1(light_M1),   
        .light_S(light_S),   
        .light_M2(light_M2),   
        .light_MT(light_MT)  
    );  

    // Generate clock (e.g., 10 ms period for faster toggling)  
    initial begin  
        clk = 1'b0;  
        forever #5 clk = ~clk; // Clock period of 10 ns (100 MHz)  
    end  

    // Initial block for reset and simulation runtime  
    initial begin  
        $dumpfile("simulation.vcd");  
        $dumpvars(0, Traffic_Light_Controller_TB);  
        
        rst = 0;  
        #20;  //reset for 20 ns  
        rst = 1;      // release reset  
        #20;  // Give some time for the system to stabilize  
        rst = 0;      // assert reset again  
        #20;  // wait 

     
        repeat (20) begin  
            #10; // wait for 10 time units (1 clock cycle)  
            $display("Time: %t, light_M1: %b, light_S: %b, light_M2: %b, light_MT: %b",   
                     $time, light_M1, light_S, light_M2, light_MT);  
        end  
        
        // Run the simulation for a defined amount of time (e.g., 1000 time units)  
        #1000; // run for 1000 time units (1 ms)  
        $finish;      // end simulation  
    end  
endmodule