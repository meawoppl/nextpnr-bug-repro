

module LedController(input clk, input tick, input[7:0] debug, output ledR, output ledG, output ledB);

    reg[1:0] count;
    reg[4:0] debugCycle;

    reg color;

    initial
        debugCycle <= 0;

    always @(posedge tick)
        begin
            // NB this counts on rollover
            // It also includes 50% duty cycle of off so you can see
            // the debugging bit pattern between big spaces of off state
            debugCycle <= debugCycle + 5'b00001;
            case (debugCycle)
                0: color <= debug[0];
                1: color <= debug[1];
                2: color <= debug[2];
                3: color <= debug[3];
                4: color <= debug[4];
                5: color <= debug[5];
                6: color <= debug[6];
                7: color <= debug[7];
                default: color <= 1'b0;
            endcase
        end

    wire pwm;
    assign pwm = (count == 2'h0) ? color : 1'b0;

    always @(posedge clk)
        count <= count + 2'h1;

    SB_RGBA_DRV #(
        .CURRENT_MODE (1'b1),
        .RGB0_CURRENT (6'h1),
        .RGB1_CURRENT (6'h1),
        .RGB2_CURRENT (6'h1)
    ) led_driver (
        .CURREN   (1'b1),  // I
        .RGBLEDEN (1'b1),  // I
        .RGB0PWM  (pwm),  // I
        .RGB1PWM  (pwm),  // I
        .RGB2PWM  (pwm),  // I
        .RGB2     (ledR),  // O
        .RGB1     (ledB),  // O
        .RGB0     (ledG)   // O
    );

endmodule
