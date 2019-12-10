
module top (output ledR, output ledG, output ledB, output tx, output[7:0] pwmOut, output sdn, output cs, output sck, output mosi, input miso, output cameraClock, inout ccData, output ccClock, output ccSync );
    wire clk;
    wire tick;
    wire fastTick;
    wire[63:0] rxData;

    wire[7:0] debugFlag;

    ClockController myClockController(clk, i2cInternalClock, fastTick, tick);
    LedController myLedController(clk, fastTick, debugFlag, ledR, ledG, ledB);

    wire ccDataRead;
    wire ccDataWrite;

    SB_IO #(
        .PIN_TYPE(6'b1010_01),
        .PULLUP(1'b0)
    ) dataI2C (
        .PACKAGE_PIN(ccData),
        .OUTPUT_ENABLE(~ccDataWrite),
        .D_OUT_0(ccDataWrite),
        .D_IN_0(ccDataRead)
    );
endmodule
