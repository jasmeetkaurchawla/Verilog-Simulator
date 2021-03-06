module Compare1 (A, B, Equal, Alarger, Blarger);
  input A, B;
  output Equal, Alarger, Blarger;
  assign Equal = (A & B) | (~A & ~B);
  assign Alarger = (A & ~B);
  assign Blarger = (~A & B);
endmodule


module Compare4(A4, B4, Equal, Alarger, Blarger);
 input [3:0] A4, B4;
output Equal, Alarger, Blarger;
 wire e0, e1, e2, e3, Al0, Al1, Al2, Al3, Bl0, Bl1, Bl2, Bl3;
  Compare1 cp0(A4[0], B4[0], e0, Al0, Bl0);
  Compare1 cp1(A4[1], B4[1], e1, Al1, Bl1);
  Compare1 cp2(A4[2], B4[2], e2, Al2, Bl2);
  Compare1 cp3(A4[3], B4[3], e3, Al3, Bl3);
  assign Equal = (e0 & e1 & e2 & e3);
  assign Alarger = (Al3 | (Al2 & e3) |(Al1 & e3 & e2) |(Al0 & e3 & e2 & e1));
  assign Blarger = (~Alarger & ~Equal);
endmodule
module tbw_4bitcomp;

	// Inputs
	reg [3:0] A4;
	reg [3:0] B4;

	// Outputs
	wire Equal;
	wire Alarger;
	wire Blarger;

	// Instantiate the Unit Under Test (UUT)
	Compare4 uut (
		.A4(A4),
		.B4(B4),
		.Equal(Equal),
		.Alarger(Alarger),
		.Blarger(Blarger)
	);

	initial begin
      $monitor( $time,"A=%d,B=%d,Equal=%b,Alarger=%b,Blarger=%b",A4,B4,Equal,Alarger,Blarger);
		// Initialize Inputs
		A4 = 0;
		B4 = 0;
		#40 A4 = 1000; B4 = 1010;
		#80 A4 = 0001; B4 = 0000;


		// Wait 100 ns for global reset to finish
		#100;

		// Add stimulus here

	end

endmodule
