*******************************************************************************
****** full_adder_opt schematic LAB3  <vs>  full_adder_opt layout LAB3
*******************************************************************************

Reduce Statistics
=================                               Original             Reduced
Cell/Device                               schematic  layout   schematic  layout
(nmos1v) MOS                                     14      14           9      14*
(pmos1v) MOS                                     14      14           9      14*
(nmos1v:ParMos2#1, -) MosBlk                      -       -           1       -*
(nmos1v:ParMos3#1, -) MosBlk                      -       -           1       -*
(pmos1v:ParMos2#1, -) MosBlk                      -       -           1       -*
(pmos1v:ParMos3#1, -) MosBlk                      -       -           1       -*

Match Statistics
================                                  Total             Unmatched
Cell/Device                               schematic  layout   schematic  layout
(nmos1v) MOS                                      9      14*          8      13*
(pmos1v) MOS                                      9      14*          7      12*
(nmos1v:ParMos2#1, -) MosBlk                      1       -*          1       -*
(nmos1v:ParMos3#1, -) MosBlk                      1       -*          1       -*
(pmos1v:ParMos2#1, -) MosBlk                      1       -*          1       -*
(pmos1v:ParMos3#1, -) MosBlk                      1       -*          1       -*
                                             ------  ------      ------  ------
Total                                            22      28          19      25

Match Statistics for Nets                        19      44           0      25

===============================================================[full_adder_opt]
====== Unbound Pin ============================================================
===============================================================================

S A
S B
S Cin
S Cout
S S

===============================================================[full_adder_opt]
====== Unmatched Internal Nets ================================================
===============================================================================

L ?avS69
L ?avC7
L ?avS70
L ?avC8
L ?avS71
L ?avC9
L ?avS72
L ?avC10
L ?avS73
L ?avC11
L ?avS74
L ?avC12
L ?avS75
L ?avC29
L ?avC30
L ?avC31
L ?avC32
L ?avC33
L ?avC20
L ?avC21
L ?avC22
L ?avC23
L ?avC24
L ?avC25
L ?avC26

===============================================================[full_adder_opt]
====== Bad Matched Nets (don't really match) ==================================
===============================================================================

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(badmatch 1)
Schematic Net:  S_b
S      *1   of pmos1v {D S}
S      *1   of pmos1v G
S       1   of nmos1v {D S}
S      *1   of nmos1v G
S      *1   of pmos1v:ParMos3#1 {OUT OUT2}
S      *1   of nmos1v:ParMos3#1 {OUT OUT2}

Layout Net:  avC13
L       1   of nmos1v {D S}

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(badmatch 2)
Schematic Net:  net40
S       1   of nmos1v {D S}
S      *1   of nmos1v:ParMos3#1 {OUT OUT2}
S      *1   of nmos1v:ParMos3#1 TERM4

Layout Net:  avC14
L       1   of nmos1v {D S}

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(badmatch 3)
Schematic Net:  Cout_b
S      *1   of pmos1v {D S}
S       2   of pmos1v G
S      *1   of nmos1v {D S}
S       2   of nmos1v G
S      *1   of pmos1v:ParMos2#1 {OUT OUT2}
S      *1   of nmos1v:ParMos2#1 {OUT OUT2}

Layout Net:  avS77
L      *1   of pmos1v G
L      *1   of nmos1v G

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(badmatch 4)
Schematic Net:  net29
S       2   of nmos1v {D S}
S      *1   of nmos1v B

Layout Net:  avC15
L      *1   of nmos1v {D S}

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(badmatch 5)
Schematic Net:  net30
S       2   of nmos1v {D S}
S       1   of nmos1v B

Layout Net:  avC1
L      *14  of nmos1v {D S}
L      *14  of nmos1v B

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(badmatch 6)
Schematic Net:  net18
S      *1   of nmos1v {D S}
S      *1   of nmos1v:ParMos2#1 {OUT OUT2}
S      *1   of nmos1v:ParMos2#1 TERM4

Layout Net:  avS78
L      *1   of pmos1v G
L      *1   of nmos1v G

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(badmatch 7)
Schematic Net:  net8
S       2   of nmos1v {D S}
S      *1   of nmos1v B

Layout Net:  avC16
L      *1   of nmos1v {D S}

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(badmatch 8)
Schematic Net:  net44
S      *1   of pmos1v {D S}
S      *1   of pmos1v:ParMos3#1 {OUT OUT2}
S      *1   of pmos1v:ParMos3#1 TERM4

Layout Net:  avS79
L      *1   of pmos1v G
L      *1   of nmos1v G

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(badmatch 9)
Schematic Net:  net32
S      *2   of pmos1v {D S}
S      *1   of pmos1v B

Layout Net:  avC17
L      *1   of nmos1v {D S}

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (badmatch 10)
Schematic Net:  net33
S      *2   of pmos1v {D S}
S      *1   of pmos1v B

Layout Net:  avS80
L      *1   of pmos1v G
L      *1   of nmos1v G

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (badmatch 11)
Schematic Net:  net19
S      *1   of pmos1v {D S}
S      *1   of pmos1v:ParMos2#1 {OUT OUT2}
S      *1   of pmos1v:ParMos2#1 TERM4

Layout Net:  avC18
L      *1   of nmos1v {D S}

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (badmatch 12)
Schematic Net:  net10
S       2   of pmos1v {D S}
S      *1   of pmos1v B

Layout Net:  avC27
L      *1   of pmos1v {D S}

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (badmatch 13)
Schematic Net:  A
S       2   of pmos1v G
S       2   of nmos1v G
S      *1   of pmos1v:ParMos3#1 {IN1 IN2 IN3}
S      *1   of pmos1v:ParMos2#1 {IN1 IN2}
S      *1   of nmos1v:ParMos3#1 {IN1 IN2 IN3}
S      *1   of nmos1v:ParMos2#1 {IN1 IN2}

Layout Net:  avS76
L      *1   of pmos1v G
L      *1   of nmos1v G

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (badmatch 14)
Schematic Net:  B
S       2   of pmos1v G
S       2   of nmos1v G
S      *1   of pmos1v:ParMos3#1 {IN1 IN2 IN3}
S      *1   of pmos1v:ParMos2#1 {IN1 IN2}
S      *1   of nmos1v:ParMos3#1 {IN1 IN2 IN3}
S      *1   of nmos1v:ParMos2#1 {IN1 IN2}

Layout Net:  avS81
L      *1   of pmos1v G
L      *1   of nmos1v G

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (badmatch 15)
Schematic Net:  Cin
S      *2   of pmos1v G
S      *2   of nmos1v G
S      *1   of pmos1v:ParMos3#1 {IN1 IN2 IN3}
S      *1   of nmos1v:ParMos3#1 {IN1 IN2 IN3}

Layout Net:  avC19
L      *1   of nmos1v {D S}

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (badmatch 16)
Schematic Net:  Cout
S       1   of pmos1v {D S}
S      *1   of nmos1v {D S}

Layout Net:  avC28
L       1   of pmos1v {D S}

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (badmatch 17)
Schematic Net:  S
S      *1   of pmos1v {D S}
S      *1   of nmos1v {D S}

Layout Net:  avS82
L      *1   of pmos1v G
L      *1   of nmos1v G

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (badmatch 18)
Schematic Net:  vdd!
S       6   of pmos1v {D S}
S       6   of pmos1v B

Layout Net:  avC3
L      *14  of pmos1v {D S}
L      *14  of pmos1v B

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (badmatch 19)
Schematic Net:  gnd!
S       6   of nmos1v {D S}
S      *6   of nmos1v B

Layout Net:  avC6
L      *1   of nmos1v {D S}

===============================================================[full_adder_opt]
====== Problem Schematic Nets (no exact match in layout) ======================
===============================================================================
S
S ?Cout ?S
S (total 2) with:
S       1   of pmos1v {D S}
S       1   of nmos1v {D S}
S
S ?net32 ?net33 ?net10
S (total 3) with:
S       2   of pmos1v {D S}
S       1   of pmos1v B
S
S ?vdd!
S       6   of pmos1v {D S}
S       6   of pmos1v B
S
S ?net29 ?net30 ?net8
S (total 3) with:
S       2   of nmos1v {D S}
S       1   of nmos1v B
S
S ?gnd!
S       6   of nmos1v {D S}
S       6   of nmos1v B
S
S ?net44
S       1   of pmos1v {D S}
S       1   of pmos1v:ParMos3#1 {OUT OUT2}
S       1   of pmos1v:ParMos3#1 TERM4
S
S ?net19
S       1   of pmos1v {D S}
S       1   of pmos1v:ParMos2#1 {OUT OUT2}
S       1   of pmos1v:ParMos2#1 TERM4
S
S ?net40
S       1   of nmos1v {D S}
S       1   of nmos1v:ParMos3#1 {OUT OUT2}
S       1   of nmos1v:ParMos3#1 TERM4
S
S ?net18
S       1   of nmos1v {D S}
S       1   of nmos1v:ParMos2#1 {OUT OUT2}
S       1   of nmos1v:ParMos2#1 TERM4
S
S ?Cin
S       2   of pmos1v G
S       2   of nmos1v G
S       1   of pmos1v:ParMos3#1 {IN1 IN2 IN3}
S       1   of nmos1v:ParMos3#1 {IN1 IN2 IN3}
S
S ?S_b
S       1   of pmos1v {D S}
S       1   of pmos1v G
S       1   of nmos1v {D S}
S       1   of nmos1v G
S       1   of pmos1v:ParMos3#1 {OUT OUT2}
S       1   of nmos1v:ParMos3#1 {OUT OUT2}
S
S ?Cout_b
S       1   of pmos1v {D S}
S       2   of pmos1v G
S       1   of nmos1v {D S}
S       2   of nmos1v G
S       1   of pmos1v:ParMos2#1 {OUT OUT2}
S       1   of nmos1v:ParMos2#1 {OUT OUT2}
S
S ?A ?B
S (total 2) with:
S       2   of pmos1v G
S       2   of nmos1v G
S       1   of pmos1v:ParMos3#1 {IN1 IN2 IN3}
S       1   of pmos1v:ParMos2#1 {IN1 IN2}
S       1   of nmos1v:ParMos3#1 {IN1 IN2 IN3}
S       1   of nmos1v:ParMos2#1 {IN1 IN2}

===============================================================[full_adder_opt]
====== Problem Layout Nets (no exact match in schematic) ======================
===============================================================================
L
L ?avC27 ?avC28 ?avC29 ?avC30 ?avC31 ?avC32 ?avC33 ?avC20 ?avC21 ?avC22 ?avC23
L ?avC24 ?avC25 ?avC26
L (total 14) with:
L       1   of pmos1v {D S}
L
L ?avC13 ?avC14 ?avC15 ?avC16 ?avC17 ?avC18 ?avC19 ?avC6 ?avC7 ?avC8 ?avC9
L ?avC10 ?avC11 ?avC12
L (total 14) with:
L       1   of nmos1v {D S}
L
L ?avC3
L       14  of pmos1v {D S}
L       14  of pmos1v B
L
L ?avS76 ?avS77 ?avS78 ?avS79 ?avS80 ?avS81 ?avS82 ?avS69 ?avS70 ?avS71 ?avS72
L ?avS73 ?avS74 ?avS75
L (total 14) with:
L       1   of pmos1v G
L       1   of nmos1v G
L
L ?avC1
L       14  of nmos1v {D S}
L       14  of nmos1v B

===============================================================[full_adder_opt]
====== Unmatched Schematic Instances ==========================================
===============================================================================

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (schinst 1)
Schematic Instance: PS_INV  pmos1v

S Pin        Net
S ---        ---
S D          S
S G          S_b
S S          vdd!
S B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (schinst 2)
Schematic Instance: PS_CB  pmos1v

S Pin        Net
S ---        ---
S D          net44
S G          Cout_b
S S          vdd!
S B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (schinst 3)
Schematic Instance: PS_C1  pmos1v

S Pin        Net
S ---        ---
S D          S_b
S G          Cin
S S          net32
S B          net32

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (schinst 4)
Schematic Instance: PS_B1  pmos1v

S Pin        Net
S ---        ---
S D          net32
S G          B
S S          net33
S B          net33

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (schinst 5)
Schematic Instance: PS_A1  pmos1v

S Pin        Net
S ---        ---
S D          net33
S G          A
S S          vdd!
S B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (schinst 6)
Schematic Instance: PC_C  pmos1v

S Pin        Net
S ---        ---
S D          net19
S G          Cin
S S          vdd!
S B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (schinst 7)
Schematic Instance: PC_B1  pmos1v

S Pin        Net
S ---        ---
S D          Cout_b
S G          B
S S          net10
S B          net10

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (schinst 8)
Schematic Instance: NS_INV  nmos1v

S Pin        Net
S ---        ---
S D          S
S G          S_b
S S          gnd!
S B          gnd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (schinst 9)
Schematic Instance: NS_CB  nmos1v

S Pin        Net
S ---        ---
S D          net40
S G          Cout_b
S S          gnd!
S B          gnd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(schinst 10)
Schematic Instance: NS_C1  nmos1v

S Pin        Net
S ---        ---
S D          net29
S G          Cin
S S          gnd!
S B          gnd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(schinst 11)
Schematic Instance: NS_B1  nmos1v

S Pin        Net
S ---        ---
S D          net30
S G          B
S S          net29
S B          net29

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(schinst 12)
Schematic Instance: NC_INV  nmos1v

S Pin        Net
S ---        ---
S D          Cout
S G          Cout_b
S S          gnd!
S B          gnd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(schinst 13)
Schematic Instance: NC_C  nmos1v

S Pin        Net
S ---        ---
S D          net18
S G          Cin
S S          gnd!
S B          gnd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(schinst 14)
Schematic Instance: NC_B1  nmos1v

S Pin        Net
S ---        ---
S D          net8
S G          B
S S          gnd!
S B          gnd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(schinst 15)
Schematic Instance: NC_A1  nmos1v

S Pin        Net
S ---        ---
S D          Cout_b
S G          A
S S          net8
S B          net8

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(schinst 16)
Schematic Instance: I##29  pmos1v:ParMos3#1

S Pin        Net
S ---        ---
S OUT        S_b
S OUT2       net44
S TERM4      net44
S IN1        A
S IN2        B
S IN3        Cin

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(schinst 17)
Schematic Instance: I##30  pmos1v:ParMos2#1

S Pin        Net
S ---        ---
S OUT        Cout_b
S OUT2       net19
S TERM4      net19
S IN1        A
S IN2        B

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(schinst 18)
Schematic Instance: I##31  nmos1v:ParMos3#1

S Pin        Net
S ---        ---
S OUT        S_b
S OUT2       net40
S TERM4      net40
S IN1        A
S IN2        B
S IN3        Cin

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(schinst 19)
Schematic Instance: I##32  nmos1v:ParMos2#1

S Pin        Net
S ---        ---
S OUT        Cout_b
S OUT2       net18
S TERM4      net18
S IN1        A
S IN2        B

===============================================================[full_adder_opt]
====== Unmatched Layout Instances =============================================
===============================================================================

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (layinst 1)
Layout Instance:    avD1_2  nmos1v

L Pin        Net
L ---        ---
L D          net40
L G          Cout_b
L S          net30
L B          net30

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (layinst 2)
Layout Instance:    avD1_3  nmos1v

L Pin        Net
L ---        ---
L D          net29
L G          net18
L S          net30
L B          net30

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (layinst 3)
Layout Instance:    avD1_4  nmos1v

L Pin        Net
L ---        ---
L D          net8
L G          net44
L S          net30
L B          net30

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (layinst 4)
Layout Instance:    avD1_5  nmos1v

L Pin        Net
L ---        ---
L D          net32
L G          net33
L S          net30
L B          net30

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (layinst 5)
Layout Instance:    avD1_6  nmos1v

L Pin        Net
L ---        ---
L D          net19
L G          B
L S          net30
L B          net30

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (layinst 6)
Layout Instance:    avD1_7  nmos1v

L Pin        Net
L ---        ---
L D          Cin
L G          S
L S          net30
L B          net30

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (layinst 7)
Layout Instance:    avD1_8  nmos1v

L Pin        Net
L ---        ---
L D          gnd!
L G          ?avS69
L S          net30
L B          net30

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (layinst 8)
Layout Instance:    avD1_9  nmos1v

L Pin        Net
L ---        ---
L D          ?avC7
L G          ?avS70
L S          net30
L B          net30

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = (layinst 9)
Layout Instance:    avD1_10  nmos1v

L Pin        Net
L ---        ---
L D          ?avC8
L G          ?avS71
L S          net30
L B          net30

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 10)
Layout Instance:    avD1_11  nmos1v

L Pin        Net
L ---        ---
L D          ?avC9
L G          ?avS72
L S          net30
L B          net30

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 11)
Layout Instance:    avD1_12  nmos1v

L Pin        Net
L ---        ---
L D          ?avC10
L G          ?avS73
L S          net30
L B          net30

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 12)
Layout Instance:    avD1_13  nmos1v

L Pin        Net
L ---        ---
L D          ?avC11
L G          ?avS74
L S          net30
L B          net30

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 13)
Layout Instance:    avD1_14  nmos1v

L Pin        Net
L ---        ---
L D          ?avC12
L G          ?avS75
L S          net30
L B          net30

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 14)
Layout Instance:    avD7_3  pmos1v

L Pin        Net
L ---        ---
L D          ?avC29
L G          net18
L S          vdd!
L B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 15)
Layout Instance:    avD7_4  pmos1v

L Pin        Net
L ---        ---
L D          ?avC30
L G          net44
L S          vdd!
L B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 16)
Layout Instance:    avD7_5  pmos1v

L Pin        Net
L ---        ---
L D          ?avC31
L G          net33
L S          vdd!
L B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 17)
Layout Instance:    avD7_6  pmos1v

L Pin        Net
L ---        ---
L D          ?avC32
L G          B
L S          vdd!
L B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 18)
Layout Instance:    avD7_7  pmos1v

L Pin        Net
L ---        ---
L D          ?avC33
L G          S
L S          vdd!
L B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 19)
Layout Instance:    avD7_8  pmos1v

L Pin        Net
L ---        ---
L D          ?avC20
L G          ?avS69
L S          vdd!
L B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 20)
Layout Instance:    avD7_9  pmos1v

L Pin        Net
L ---        ---
L D          ?avC21
L G          ?avS70
L S          vdd!
L B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 21)
Layout Instance:    avD7_10  pmos1v

L Pin        Net
L ---        ---
L D          ?avC22
L G          ?avS71
L S          vdd!
L B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 22)
Layout Instance:    avD7_11  pmos1v

L Pin        Net
L ---        ---
L D          ?avC23
L G          ?avS72
L S          vdd!
L B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 23)
Layout Instance:    avD7_12  pmos1v

L Pin        Net
L ---        ---
L D          ?avC24
L G          ?avS73
L S          vdd!
L B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 24)
Layout Instance:    avD7_13  pmos1v

L Pin        Net
L ---        ---
L D          ?avC25
L G          ?avS74
L S          vdd!
L B          vdd!

= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =(layinst 25)
Layout Instance:    avD7_14  pmos1v

L Pin        Net
L ---        ---
L D          ?avC26
L G          ?avS75
L S          vdd!
L B          vdd!

===============================================================[full_adder_opt]
====== Summary of Errors ======================================================
===============================================================================

Schematic  Layout     Error Type
---------  ------     ----------
 19         19        Bad Matched Nets
 -          25        Unmatched Internal Nets
 19         25        Unmatched Instances
 5          -         Unbound Pin

