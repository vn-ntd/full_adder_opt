cv = dbOpenCellViewByType("Anik" "full_adder_opt" "schematic")
printf("=== PINS OF full_adder_opt ===\n")
foreach(term cv~>terminals
    printf("PIN: %s (dir: %s)\n", term~>name, term~>direction)
)
printf("=== END PINS ===\n")
dbClose(cv)
exit()
