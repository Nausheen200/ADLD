`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:40:33 05/14/2023 
// Design Name: 
// Module Name:    AM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module AM(a,b,rslt);

input [7:0] a,b;
output reg [15:0] rslt;

reg [7:0] p0,p1,p2,p3,p4,p5,p6,p7; 

reg [14:0] q0,q1,q2,q3;
reg [15:0] r0,r1,s;
integer i;

initial begin
p0=8'd0; 
p1=8'd0;
p2=8'd0;
p3=8'd0;
p4=8'd0;
p5=8'd0;
p6=8'd0;
p7=8'd0;
q0=15'd0;
q1=15'd0;
q2=15'd0;
q3=15'd0;
r0=16'd0;
r1=16'd0;
end


initial begin
for(i=0;i<8;i=i+1)
begin
assign p0[i]=b[0]&a[i];
end
end


initial begin
for(i=0;i<8;i=i+1)
begin
assign p1[i]=b[1]&a[i];
end
end

initial begin
for(i=0;i<8;i=i+1)
begin
assign p2[i]=b[2]&a[i];
end
end

initial begin
for(i=0;i<8;i=i+1)
begin
assign p3[i]=b[3]&a[i];
end
end

initial begin
for(i=0;i<8;i=i+1)
begin
assign p4[i]=b[4]&a[i];
end
end

initial begin
for(i=0;i<8;i=i+1)
begin
assign p5[i]=b[5]&a[i];
end
end

initial begin
for(i=0;i<8;i=i+1)
begin
assign p6[i]=b[6]&a[i];
end
end

initial begin
for(i=0;i<8;i=i+1)
begin
assign p7[i]=b[7]&a[i];
end
end

/////////////////Stage 1//////////////////


ha h1(q0[1],p0[1],p1[0]);
fa f1(q1[0],q0[2],p0[2],p1[1],p2[0]);
cm c1(q0[3],q1[1],p0[3],p1[2],p2[1],p3[0]);
cm c2(q0[4],q1[2],p0[4],p1[3],p2[2],p3[1]);
cm c3(q0[5],q1[3],p0[5],p1[4],p2[3],p3[2]);
ha h2(q2[1],p4[1],p5[0]);
cm c4(q0[6],q1[4],p0[6],p1[5],p2[4],p3[3]);
fa f2(q3[0],q2[2],p4[2],p5[1],p6[0]);
cm c5(q0[7],q1[5],p0[7],p1[6],p2[5],p3[4]);
cm c6(q2[3],q3[1],p4[3],p5[2],p6[1],p7[0]);
fa f3(q1[6],q0[8],p1[7],p2[6],p3[5]);
cm c7(q2[4],q3[2],p4[4],p5[3],p6[2],p7[1]);
ha h3(q0[9],p2[7],p3[6]);
cm c8(q2[5],q3[3],p4[5],p5[4],p6[3],p7[2]);
cm c9(q2[6],q3[4],p4[6],p5[5],p6[4],p7[3]);
cm c10(q0[11],q1[9],p4[7],p5[6],p6[5],p7[4]);
fa f4(q1[10],q0[12],p5[7],p6[6],p7[5]);
ha h4(q0[13],p6[7],p7[6]);


/////////////////stage 2////////////////////

ha h5(r0[2],q0[2],q1[0]);
ha h6(r0[3],q0[3],q1[1]);
fa f5(r1[1],r0[4],q0[4],q1[2],p4[0]);
fa f6(r1[2],r0[5],q0[5],q1[3],q2[1]);
cm c11(r0[6],r1[3],q0[6],q1[4],q2[2],q3[0]);
cm c12(r0[7],r1[4],q0[7],q1[5],q2[3],q3[1]);
cm c13(r0[8],r1[5],q0[8],q1[6],q2[4],q3[2]);
cm c14(r0[9],r1[6],q0[9],q1[7],q2[5],q3[3]);
cm c15(r0[10],r1[7],p3[7],q1[8],q2[6],q3[4]);
ha h7(r0[11],q0[11],q1[9]);
ha h8(r0[12],q0[12],q1[10]);
ha h9(r0[13],q0[13],q1[11]);
ha h10(r0[14],q0[14],p7[7]);
  

///////////////////stage 3//////////////////////
  
ha h11(s[3],r0[3],r1[0]);
ha h12(s[4],r0[4],r1[1]);
ha h13(s[5],r0[5],r1[2]);
ha h14(s[6],r0[6],r1[3]);
ha h15(s[7],r0[7],r1[4]);
ha h16(s[8],r0[8],r1[5]);
ha h17(s[9],r0[9],r1[6]);
ha h18(s[10],r0[10],r1[7]);
ha h19(s[11],r0[11],r1[8]);
ha h20(s[12],r0[12],r1[9]);
ha h21(s[13],r0[13],r1[10]);
ha h22(s[14],r0[14],r1[11]);




always@(*)
begin
rslt={r0[15],s[14:3],r0[2],q0[1],p0[0]};
end


endmodule


module ha(s,a,b);
output s;
input a, b;

assign s = a ^ b;
endmodule


module fa(co,s,a,b,ci);

output  s;
output co;
input  a, b, ci;

assign s = a^ b ^ ci;
assign co = (a & b) | (b & ci) | (a & ci);

endmodule

module cm(co,s,a,b,c,d);

output s;
output co;
input a,b,c,d;

assign s = (a ^ b) & (c & d) | (a ^ b) & (c | d);
assign co = a | b;
endmodule

