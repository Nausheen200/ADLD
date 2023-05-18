module tb_parking_system;

  // Inputs
  reg clk;
  reg reset;
  reg sensor_ent;
  reg sensor_exit;
  reg [1:0] pass_1;
 

  
 

  // Instantiate the Unit Under Test (UUT)
  parking_system uut (
  .clk(clk), 
  .reset(reset), 
  .sensor_ent(sensor_ent), 
  .sensor_exit(sensor_exit), 
  .pass_1(pass_1), 
   
  
 );
 initial begin
 clk = 0;
 forever #10 clk = ~clk;
 end
 initial begin
 // Initialize Inputs
 reset = 0;
 sensor_ent = 0;
 sensor_exit = 0;
 pass_1 = 0;
 // Wait 100 ns for global reset to finish
 #100;
      reset = 1;
 #20;
 sensor_ent = 1;
 #1000;
 sensor_ent = 0;
 pass_1 = 1;

 #2000;
 sensor_exit =1;
 
 end
      
endmodule


module parking_system(  input clk,reset,
 input sensor_ent, sensor_exit, 
 input [1:0] pass_1,


  );
 parameter IDLE = 3'b000, WAIT_PASS = 3'b001, WRONG_PASS = 3'b010, RIGHT_PASS = 3'b011,STOP = 3'b100;
 // Moore FSM is used and output just depends on the current state
 reg[2:0] current_state, next_state;
 reg[31:0] counter_wait;
 
 // Next state
 always @(posedge clk or negedge reset)
 begin
 if(~reset) 
 current_state = IDLE;
 else
 current_state = next_state;
 end
 // counter wait
 always @(posedge clk or negedge reset) 
 begin
 if(~reset) 
 counter_wait <= 0;
 else if(current_state==WAIT_PASS)
 counter_wait <= counter_wait + 1;
 else 
 counter_wait <= 0;
 end
 // change state

 always @(*)
 begin
 case(current_state)
 IDLE: begin
        if(sensor_ent == 1)
 next_state = WAIT_PASS;
 else
 next_state = IDLE;
 end
 WAIT_PASS: begin
 if(counter_wait <= 3)
 next_state = WAIT_PASS;
 else 
 begin
 if(pass_1==4'b0001)
 next_state = RIGHT_PASS;
 else
 next_state = WRONG_PASS;
 end
 end
 WRONG_PASS: begin
 if(pass_1==4'b0001)
 next_state = RIGHT_PASS;
 else
 next_state = WRONG_PASS;
 end
 RIGHT_PASS: begin 
if ( sensor_ent == 1 && sensor_exit == 1)
 next_state = STOP;
 else if(sensor_exit == 1)
 next_state = IDLE;
 else
 next_state = RIGHT_PASS;
 end
 STOP: begin
 if(pass_1==4'b0001)
 next_state = RIGHT_PASS;
 else
 next_state = STOP;
 end
 default: next_state = IDLE;
 endcase
 end 
 end
endmodule
 


