`include "const.h"

module test;

reg[63:0] x,y;
wire[63:0] z;
reg[3:0] F;

alu aluor
(
	.x(x),
	.y(y),
	.z(z),
	.alusel(F)
);


integer i;

initial 
begin
	#10;
	x=-64'b1111_0000;
	y=64'b0000_1111;
	for(i=0;i<10;i=i+1)
	begin
		F=i;
		#1;
		$display("z=%b",z);
	end
	$finish;

end






endmodule
