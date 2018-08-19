`include "neopixel.vh"

module neopixel_multi(clk_16MHz, dout, data_in, start_tx, busy);

    parameter nbr_pixels = 2;

    input wire clk_16MHz;
    input wire start_tx;
    output wire dout;
    input wire [23:0]data_in;
    output wire busy;

    reg single_start_tx = 0;
    wire single_busy;

    reg [15:0] counter = 1;

    parameter idle = 2'b00;
    parameter tx_in_progress = 2'b01;
    parameter ending = 2'b10;

    reg [1:0] state = idle;

    assign busy = (state == tx_in_progress || single_busy);

    always @(posedge clk_16MHz) begin
      case (state)
        idle : begin
          if (start_tx == 1) begin
             state <= tx_in_progress;
             single_start_tx <= 1;
             counter <= 1;
          end else begin
             single_start_tx <= 0;
          end
        end

        tx_in_progress: begin
           if (single_busy == 0 && single_start_tx == 0) begin
              if (counter == nbr_pixels) begin
                state <= ending;
              end else begin
                 counter <= counter + 1;
                 single_start_tx <= 1;
              end
           end else begin
              single_start_tx <= 0;
           end
        end

        ending: begin
          if (start_tx == 0 && single_busy == 0) begin
             state <= idle;
          end
        end

      endcase
   end

    neopixel #(1) single (
      .clk_16MHz(clk_16MHz),
      .dout(dout),
      .data_in(data_in),
      .start_tx(single_start_tx),
      .busy(single_busy)
    );
endmodule
