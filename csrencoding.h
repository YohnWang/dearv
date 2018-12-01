`ifndef _CSRMAP_H
`define _CSRMAP_H

`define MSTATUS    12'd0
`define MIE        12'd4
`define MTVEC      12'd5
`define MCOUNTEREN 12'd6

`define MSCRATCH   12'd10
`define MEPC       12'd11
`define MCAUSE     12'd12
`define MTVAL      12'd13
`define MIP        12'd14


`define CSR_RW  2'b01
`define CSR_RS  2'b10
`define CSR_RC  2'b11

`endif
