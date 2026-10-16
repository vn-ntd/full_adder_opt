================================================================================
GOI DONG GOI HOAN CHINH LAB 3: THIET KE BO CONG TOAN PHAN CMOS (FULL ADDER)
Sinh vien: Nguyen Tien Dung - Lop: ICI211
Thu vien Cadence Virtuoso: LAB3
================================================================================

1. CAU TRUC THU MUC:
   - LAB3/         : Thu vien thiet ke chinh gom:
                     + full_adder     : Mach 36T (NAND + XOR) - Schematic & Layout (0 loi DRC)
                     + full_adder_opt : Mach 28T Mirror CMOS - Schematic & Layout (0 loi DRC)
                     + nand2, xor2    : Cac cong logic thanh phan (Schematic, Symbol, Layout)
                     + full_adder_tb  : Testbench mo phong 8 to hop song vuong
   - cds_work/     : Thu muc lam viec Cadence (cds.lib, RSF, rule file, file log kiem tra DRC)
   - reports/      : Bao cao thuc hanh chi tiet (file .docx va .md) kem anh dang song mo phong
   - verification/ : Ket qua chay kiem tra Assura DRC (drc_lab3) bao cao 0 loi

2. HUONG DAN IMPORT VA CHAY TRONG CADENCE VIRTUOSO:
   - Copy thu muc LAB3 vao Workspace cua ban.
   - Them dong sau vao file cds.lib:
     DEFINE LAB3 <duong_dan_den_thu_muc>/LAB3
   - Mo Cadence Virtuoso -> Library Manager -> chon LAB3.
   - Mo layout va chay Assura -> Run DRC -> Ket qua: 0 loi (DRC Clean).
================================================================================
