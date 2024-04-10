%
O9250 (DYNAMIC ROTATION CALC)
(AUTHOR PAUL SITES)
(DATE 2024.04.10)
(PURPOSE ROTATE ABOUT A SPECIFIED AXIS GIVEN AN INITIAL)
(WORK OFFSET AND ROTATION AMOUNT IN DEGREES FROM AN ORIGIN)
(OF ROTATION) 

(A 1 = ROTATION AXIS X 1, Y 2, Z 3)
(C 3 = C_ROT OFFSET)
(I 4 = INITIAL OFFSET)
(S 19 = RESULT OFFSET)
(R 18 = ROTATION FROM INITIAL IN DEG)
IF [#1 EQ #0] THEN #3000=1(NEED ROTATION AXIS)
IF [#4 EQ #0] THEN #3000=1(NEED INITIAL OFFSET)
IF [#19 EQ #0] THEN #3000=1(NEED DESTINATION OFFSET)
IF [#18 EQ #0] THEN #3000=1(NEED ROTATION ANGLE)

#101 = 0  (CENTER OF ROTATION X)
#102 = 0  (CENTER OF ROTATION Y)
#103 = 0  (CENTER OF ROTATION Z)
#104 = 0  (INITIAL WORK OFFSET X)
#105 = 0  (INITIAL WORK OFFSET Y)
#106 = 0  (INITIAL WORK OFFSET Z)
#107 = 0  (INITIAL WORK OFFSET THETA)
#108 = #1  (ROTATION AXIS A)
#109 = [#18 * -1.0] (ROTATION ANGLE IN DEGREES R)

N50
(SET CENTER OF ROTATION BASED ON C)
IF [#3 EQ #0] GOTO59
#150=51
#156=#3
GOTO900
N51
#101 = #[#151]
#102 = #[#152]
#103 = #[#153]
N59

N60
(SET INITIAL WORK OFFSET BASED ON I)
#150=61
#156=#4
GOTO900
N61
#104 = #[#151]
#105 = #[#152]
#106 = #[#153]
#107 = #[#154]

N70  (ROTATION CALCULATIONS)
IF [#108 EQ 1] GOTO 100
IF [#108 EQ 2] GOTO 200
IF [#108 EQ 3] GOTO 300
GOTO 999

N100  (ROTATION ABOUT X-AXIS)
#110 = #105 - #102  (RELATIVE Y)
#111 = #106 - #103  (RELATIVE Z)
#112 = #104  (X REMAINS UNCHANGED)
#113 = #110 * COS[#109] - #111 * SIN[#109] + #102  (NEW Y)
#114 = #110 * SIN[#109] + #111 * COS[#109] + #103  (NEW Z)
#115 = #107  (COPY ROTATION OFFSET)
GOTO 400

N200  (ROTATION ABOUT Y-AXIS)
#110 = #104 - #101  (RELATIVE X)
#111 = #106 - #103  (RELATIVE Z)
#112 = #110 * COS[#109] + #111 * SIN[#109] + #101  (NEW X)
#113 = #105  (Y REMAINS UNCHANGED)
#114 = -#110 * SIN[#109] + #111 * COS[#109] + #103  (NEW Z)
#115 = #107  (COPY ROTATION OFFSET)
GOTO 400

N300  (ROTATION ABOUT Z-AXIS)
#110 = #104 - #101  (RELATIVE X)
#111 = #105 - #102  (RELATIVE Y)
#112 = #110 * COS[#109] - #111 * SIN[#109] + #101  (NEW X)
#113 = #110 * SIN[#109] + #111 * COS[#109] + #102  (NEW Y)
#114 = #106  (Z REMAINS UNCHANGED)
#115 = #107  (COPY ROTATAION OFFSET)

N400  (SAVE RESULT TO OFFSET)
(SET INITIAL WORK OFFSET BASED ON I)
#150=700
#156=#19
GOTO900
N700
#[#151] = #112
#[#152] = #113
#[#153] = #114
#[#154] = #115

(SKIP OVER SUPPORT FUNCTIONS)
GOTO999

N900  (CONVERT OFFSET)
IF [#156 GT 100] GOTO 902
IF [#156 LT 7] GOTO 901
#156 = #156 - 53.
N901
IF [#156 LT 1] THEN #3000=1(ILLEGAL OFFSET)
IF [#156 GT 6] THEN #3000=1(ILLEGAL OFFSET)
#151 = [#156 * 20 + 5201]
#152 = [#156 * 20 + 5202]
#153 = [#156 * 20 + 5203]
#154 = [#156 * 20 + 5204]
GOTO 910
N902
#156 = #156 - 100.
IF [#156 LT 1.] THEN #3000=1(ILLEGAL OFFSET)
IF [#156 GT 48.] THEN #3000=1(ILLEGAL OFFSET)
#151 = [#156 * 20 + 6981]
#152 = [#156 * 20 + 6982]
#153 = [#156 * 20 + 6983]
#154 = [#156 * 20 + 6984]
N910
GOTO#150

N999
M99
%