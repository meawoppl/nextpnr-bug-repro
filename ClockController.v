
module ClockController(output clk, output spiClock, output msTick, output reg tick);
    reg[31:0] msCount;
    reg[26:0] secondCount;

    assign msTick = msCount[21];
    assign spiClock = secondCount[8];

    always @(posedge clk)
        begin
            msCount <= msCount + 32'b1;
            if (secondCount == 27'd47999999)
                begin
                    secondCount <= 27'd0;
                    tick <= 1;
                end
            else
                begin
                    secondCount <= secondCount + 27'd1;
                    tick <= 0;
                end
        end

    SB_HFOSC #(
        .CLKHF_DIV (2'h0)
    ) main_osc (
        .CLKHFPU (1'b1),  // I
        .CLKHFEN (1'b1),  // I
        .CLKHF   (clk)   // O
    );

endmodule