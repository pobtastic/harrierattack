; Copyright Durell Software LTD 1983, 2024 ArcadeGeek LTD.
; NOTE: Disassembly is Work-In-Progress.
; Label naming is loosely based on Action_ActionName_SubAction e.g. Print_HighScore_Loop.

> $4000 @rom
> $4000 @org=$4000
> $4000 @start=$7554
b $4000 Loading Screen
D $4000 #UDGTABLE { =h Harrier Attack Loading Screen. } { #SCR$02(loading) } UDGTABLE#
@ $4000 label=Loading
  $4000,$1800,$20 Pixels
  $5800,$0300,$20 Attributes

b $5B00

g $5B1B TODO

g $5B22 TODO
@ $5B22 label=E

g $5B27 TODO
@ $5B27 label=A

g $5C05 Skill level?
@ $5C05 label=B
g $5C08 TODO
@ $5C08 label=C

g $5C78 TODO
@ $5C08 label=D

c $6000
  $6000,$03 Call #R$6007.
  $6003,$03 Call #R$6C77.
  $6006,$01 Return.

c $6007
@ $6007 label=ENTRY
  $6007,$03 #REGhl=#N$581F.
  $600A,$03 #REGde=#N($001F,$04,$04).
  $600D,$02 #REGb=#N$0F (counter).
@ $600F label=LOOP
  $600F,$01
  $6010,$02,b$01 Keep only bits 3-5 (PAPER).
  $6012,$03 Shift the PAPER bits to the "front".
  $6015,$01 Store the result in #REGc.
  $6016,$01
  $6017,$02,b$01 Keep only bits 3-7 (PAPER, BRIGHT and FLASH bits).
  $6019,$01 Set the bits from #REGc.
  $601A,$01 Increment #REGhl by one.
  $601B,$01 Write #REGa to *#REGhl.
  $601C,$01 #REGhl+=#REGde.
  $601D,$02 Decrease counter by one and loop back to #R$600F until counter is zero.
  $601F,$03 Call #R$6E89.
  $602A,$0B Copies #N$100 bytes of data from #N$5800
  $6035,$0B Copies #N$800 bytes of data from ...

c $604D
  $604D,$0B Copies the byte contained at #N$5900 to the following #N$FF bytes.
  $6058,$0B Copies the byte contained at #N$4800 to the following #N$7FF bytes.
  $6063,$02 Check if D3 of #REGa is set?

c $60B6

c $60D6 Convert To Screen Buffer Address
@ $60D6 label=ScreenBufferAddress
N $60D6 On entry #REGhl is a number between #N($0000,$04,$04)-#N$F20 corresponding to the playarea.
  $60D6,$01 Stash #REGaf on the stack.
  $60D7,$01 #REGa=#REGh.
  $60D8,$04
  $60DC,$02,b$01 Keep only bits 5-7.
  $60DE,$01 Set the bits from #REGl.
  $60DF,$01 #REGc=#REGa.
  $60E0,$01 #REGa=#REGh.
  $60E1,$02,b$01 Keep only bits 3 and 4.
  $60E3,$03,b$01 Set bit 6 of #REGb which converts #REGbc to a screen address.
  $60E6,$01 Retrieve #REGaf from the stack.
  $60E7,$01 Return.

c $60E8 Fetch UDG Address
@ $60E8 label=Address_UDG
R $60E8 A UDG number
R $60E8 O:DE The address of the UDG
  $60E8,$01 Stash #REGhl on the stack.
  $60E9,$0B Point #REGde at the graphic data for the corresponding tile (at #R$6580(#N$6580)+#N$08*#REGa).
  $60F4,$01 Retrieve #REGhl from the stack.
  $60F5,$01 Return.

c $60F6
  $60F6,$01 Stash #REGhl on the stack.
  $60F7,$01 #REGa=MSB of #REGhl.
  $60F8,$03 Moves the LSB to the MSB of #REGhl and writes #N$00 to the LSB.
  $60FB,$05 #REGhl * #N$05.
  $6100,$02 OR ... TODO and store the result in #REGl.
  $6102,$03 #REGde=#N$5800
  $6105,$02 Store the result in #REGde.
  $6107,$01 Retrieve #REGhl from the stack.
  $6108,$01 Return.

c $6109 Draw UDG
N $6109 On entry #REGbc should point to a screen address and #REGde to the address of a #R$6580(UDG) tile.
@ $6109 label=Draw_UDG
@ $610D label=Draw_UDG_Loop
  $6109,$02 Copies #REGbc containing the screen address into #REGhl.
  $610B,$08 Draw the UDG graphic data to the screen.
  $6113,$01 Return.

c $6114
R $6114 A UDG ID
  $6114,$01 #REGb=#REGa.
  $6115,$03 Call #R$60F6.
  $6118,$03 Check if the current attribute byte is #N$2F?
  $611B,$02 No operation...
  $611D,$01 Return if it is.
  $611E,$02 Write #REGc to #REGde (attribute buffer).
  $6120,$01 #REGa=#REGb.
  $6121,$03 Call #R$60D6.
  $6124,$03 Call #R$60E8.
  $6127,$03 Call #R$6109.
  $612A,$01 Return.

c $612B
@ $612B label=XXX
  $612B,$01 Stash #REGaf on the stack for later.
  $612C,$03 Stash #REGbc, #REGhl and #REGde on the stack.
  $612F,$03 Call #R$6114.
  $6132,$03 Retrieve #REGde, #REGhl and #REGbc from the stack.
  $6137,$02,b$01 Keep only bits 5-7.
@ $613E label=XXXX
  $6143,$01 Retrieve #REGaf from the stack.
  $6144,$01 Return.
N $6145 Else, loop back to the start.
@ $6145 label=XXXXX
  $6145,$01 Retrieve #REGaf from the stack.
  $6146,$02 Jump back to #R$612B.

c $6148

c $61C4

b $620D
N $620D #UDGTABLE
. { #FOR$00,$0B,,$04(n,#UDG($6580+#PEEK($620D+n)*$08,attr=$07)) }
. UDGTABLE#
  $620D,$0C
  $6219,$01 Terminator.
N $621A #UDGTABLE
. { #FOR$00,$0B,,$04(n,#UDG($6580+#PEEK($621A+n)*$08,attr=$07)) }
. UDGTABLE#
  $621A,$0C
  $6226,$01 Terminator.

c $6227

b $633B
  $633B,$04
  $633F,$01 Terminator.
L $633B,$05,$04

b $634F

c $6358

b $6580 Game UDGs
@ $6580 label=UDGs
  $6580,$08 #UDG(#PC,attr=56)
L $6580,$08,$6C

b $68E0 Font
@ $68E0 label=Font
D $68E0 Copied from the Spectrum ROM, see #R$716D.
. #FOR$00,$C7,,$04(n,#POKES(#PC+n,#PEEK($3E00+n)))
N $68E0 #LET(id=#EVAL($40 + (#PC - $68E0) / $08))CHARACTER: "#MAP({id})(#CHR({id}),$20:SPACE,$60:£,$7F:©)".
  $68E0,b,$01 #UDG(#PC)
L $68E0,$08,$19

c $69A8 Handler: Flak
@ $69A8 label=Handler_Flak

b $6A1C

c $6A24

c $6ADA

c $6BE7

c $6C77

c $6CF6
  $6CFA,$01 Grab the counter off the stack.
  $6CFB,$02 Decrease counter by one and loop back to #R$6CF6 until counter is zero.
  $6CFD,$01 Return.
  $6CFE,$0A Copies #N$32 bytes of data from ...

c $6D09

c $6BD0 Process UDG Data
@ $6BD0 label=Process_UDG_Data
R $6BD0 B Length of UDG data
R $6BD0 C Colour attribute
R $6BD0 DE UDG data address
R $6BD0 HL Screen buffer address
  $6BD0,$01 Fetch UDG data reference.
  $6BD1,$01 Increment UDG data reference address pointer held in #REGde by one.
  $6BD2,$03 Stash #REGde, #REGhl and #REGbc on the stack.
  $6BD5,$03 Call #R$6114.
  $6BD8,$02 Restore #REGbc and #REGhl from the stack.
  $6BDA,$01 Increment #REGl by one.
  $6BDB,$01 #REGa=#REGl.
  $6BDC,$02,b$01 Keep only bits 5-7.
  $6BDE,$02 If the result is zero, jump to #R$6BE3.
  $6BE0,$02 #REGl=#N$00.
  $6BE2,$01 Increment #REGh by one.
@ $6BE3 label=Process_UDG_Data_Skip
  $6BE3,$01 Restore #REGde from the stack.
  $6BE4,$02 Decrease counter by one and loop back to #R$6BD0 until counter is zero.
  $6BE6,$01 Return.

c $6DB4

c $6DD0

c $6E0E

c $6E89

c $6EF0

c $6F47 Crash Sound/ Border Flash
R $6F47 C Duration counter
@ $6F47 label=Sounds_Crash
  $6F47,$03 Point to #R$6A1C.
  $6F4A,$01 #REGa=#N$00.
@ $6F4B label=Sounds_Crash_Loop
  $6F4B,$01 #REGb=Fetch the sound data byte.
  $6F4C,$01 Move onto the next sound data byte.
@ $6F4D label=
  $6F4D,$02 Decrease counter by one and loop back to #R$6F4D until counter is zero.
  $6F4F,$04 Turn the speaker on (set bit 4) and set the border colour.
  $6F53,$01 #REGb=Fetch the sound data byte.
  $6F54,$01 Move onto the next sound data byte.
@ $6F55 label=
  $6F55,$02 Decrease counter by one and loop back to #R$6F55 until counter is zero.
  $6F57,$04 Turn the speaker off (reset bit 4) and set the border colour.
  $6F5B,$01 Increment #REGa by one.
  $6F5C,$01 Decrease #REGc by one.
  $6F5D,$02 Jump back to #R$6F4B until #REGc is zero.
  $6F5F,$01 #REGa=#N$00.
  $6F60,$02 Border colour.
  $6F62,$01 Return.

c $6F63

c $6F9E

c $6FD8

c $6FFD

c $7078

c $7094

c $709D

c $70A8

c $70CD

c $70F5

c $710E

c $7125

c $7162
  $7162,$03 #REGa=#R$5B00.
  $7169,$04 Set the border to #COLOUR$00.
  $716D,$0B #HTML(Copy #N$00C8 bytes of data from <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/3D00.html#3E00">#N$3E00 (CHARSET)</a> to #R$68E0.)
N $7178 Draw the sky.
  $7178,$0B Writes #N$2D to all but the botttom row of the playarea attribute space and UDG #R$6580(#N$00) to each block using #R$612B.
N $7183 Draw the sea.
  $7183,$0A Writes #N$79 to the bottom row of the playarea attribute space and UDG #R$65C8(#N$09) to each block using #R$612B.
  $718D,$09 Writes #N$00 to the next row down of the attribute space and UDG #R$6580(#N$00) to each block using #R$612B.
  $7196,$03 #REGde=#R$723F.
  $7199,$02 #REGc=#N$07.
  $719B,$02 #REGb=#N$20.
  $719D,$03 Call #R$6BD0.
  $71A0,$01 #REGa=#N$00.
  $71A1,$03 #REGde=#N($0020,$04,$04).
  $71A4,$02 #REGc=#N$00.
  $71A6,$03 Call #R$612B.
N $71A9
  $71A9,$03 #REGde=#R$725F.
  $71AC,$02 #REGb=#N$20.
  $71AE,$02 #REGc=#N$07.
  $71B0,$03 Call #R$6BD0.
  $71B3,$03 Call #R$72BF.
N $71B6
  $71B6,$03 #REGde=#R$727F.
  $71B9,$02 #REGb=#N$20.
  $71BB,$02 #REGc=#N$07.
  $71BD,$03 Call #R$6BD0.
  $71C0,$03 Call #R$72BF.

N $71FF
  $71FF,$02 #REGa=#N$02.
  $7201,$03 #HTML(Call <a href="https://skoolkid.github.io/rom/asm/1601.html">CHAN_OPEN</a>.)
N $7204
  $7204,$03 #REGbc=#N$0607.
  $7207,$03 #HTML(Call <a href="https://skoolkid.github.io/rom/asm/0DD9.html">CL_SET</a>.)

  $720A,$05 #HTML(Write #N$07 to <a href="https://skoolkid.github.io/rom/asm/5C8F.html">ATTR-T</a>.)
  $720F,$04 #REGbc=#R$76BE(#N$76BF).
  $7213,$03 #HTML(Call <a href="https://skoolkid.github.io/rom/asm/1A1B.html">OUT_NUM_1</a>.)
  $7216,$03,c$01 Print "0" to the screen.
  $7219,$01 Return.

b $721A

b $723F Messaging: Banner
@ $723F label=Messaging_Banner
D $723F #FOR$00,$1F,,4(n,#UDG($6580+#PEEK(#PC+n)*$08,attr=$07))
. #FONT#(:(#STR(#PC,$00,$20)))$6480,attr=$07(banner)
  $723F,$20,$10 UDG IDs.

b $725F
D $725F #FOR$00,$1F,,4(n,#UDG($6580+#PEEK(#PC+n)*$08,attr=$07))
  $725F,$20,$10 UDG IDs.

b $727F
D $727F #FOR$00,$1F,,4(n,#UDG($6580+#PEEK(#PC+n)*$08,attr=$07))
  $727F,$20,$10 UDG IDs.

b $729F Gauge Data
@ $729F label=Data_Gauge
D $729F #FOR$00,$1F,,4(n,#UDG($6580+#PEEK(#PC+n)*$08,attr=$30))
  $729F,$20,$10 UDG IDs.

c $72BF Draw Gauge
@ $72BF label=Draw_Gauge
  $72BF,$03 #REGde=#R$729F (UDG data).
  $72C2,$02 #REGc=#N$30 (colour attribute).
  $72C4,$02 #REGb=#N$20 (data length).
  $72C6,$03 Call #R$6BD0.
  $72C9,$01 Return.

c $72CA
  $72CA,$03 #REGa=#R$5B22

c $739D

c $7533

  $753D,$01 Return.

b $753E
  $753E,$02 PAPER: #COLOUR(#PEEK(#PC+$01)).
  $7540,$02 INK: #COLOUR(#PEEK(#PC+$01)).
  $7542,$03 AT #N(#PEEK(#PC+$01)), #N(#PEEK(#PC+$02)).
  $7545,$0F ????

c $7554 Game Entry Point
  $7554,$09 Call #R$78B0 three times.
  $755D,$05 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C6A.html">FLAGS2</a> set CAPS LOCK on.)
  $7562,$05 #HTML(<a href="https://skoolkid.github.io/rom/asm/1601.html">CHAN_OPEN</a> (open upper screen channel).)
N $7567
  $7567,$03 #REGde=#R$753E
  $756A,$03 #REGbc=Characters to print.
  $756D,$03 #HTML(Call <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)
  $7570,$03 #REGde=#R$7862
  $7573,$03 #REGbc=Characters to print.
  $7576,$03 #HTML(Call <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)

  $7579,$03 #REGhl=#N$5B00

  $7583,$03 #HTML(#REGa=#2 <a href="https://skoolkid.github.io/rom/asm/5C00.html">KSTATE</a> call counter.)
  $7586,$03 If #REGa is zero jump back to #R$7583.
  $7589,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C08.html">LAST-K</a> (last key pressed).)
  $758C,$02 Subtract #N$31.
  $758E,$02 If there is carry jump back to #R$7583.
  $7590,$02 Is the result #N$05?
  $7592,$02 If there is no carry jump back to #R$7583.
  $7594,$01 Increment #REGa by one.
  $7595,$03 Store #REGa at #R$5B27.
  $7598,$03 #HTML(#REGhl=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> as a random number seed.)

  $75A4,$0B Copy #N$0F bytes of data from #R$7545 to #N$5B0A.

  $75D1,$03 #HTML(#REGhl=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> as a random number seed.)
  $75D8,$02

  $75E1,$03 #HTML(#REGa=#2 <a href="https://skoolkid.github.io/rom/asm/5C00.html">KSTATE</a> call counter.)
  $75E5,$02
  $75E7,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C08.html">LAST-K</a> (last key pressed).)


N $7603 Todo...
  $7603,$03 Call #R$6000.
  $7606,$03 Call #R$72CA.
  $7609,$03 #REGa=#R$5B00

  $7619
  $762F,$03 #HTML(#REGhl=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> as a random number seed.)
  $763A,$03 #HTML(#REGhl=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> as a random number seed.)

  $7646,$03 Jump back to #R$7579.

b $7649 High Score Table.
@ $7649 label=HIGH_SCORE_TABLE
N $7649 High Score entry #EVAL($0A-(#PC-$7649)/$0C)
T $7649,$06 Name
  $764F,$01 Level
  $7650,$02 Hits
  $7652,$03 Score
L $7649,$0C,$0A

c $76C1
  $76C5,$01 Disables interrupts.

  $7729,$03 #REGde=#R$77F6
  $772C,$03 #REGbc=Characters to print.
  $772F,$03 #HTML(Call <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)

  $775D,$03 Print "0" to the screen.

  $7760,$03 #REGbc=Characters to print.
  $7763,$03 #REGde=#R$7884
  $7766,$03 #HTML(Call <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)

  $7771,$03 #REGde=#R$783F
  $7774,$03 #REGbc=Characters to print.
  $7777,$03 #HTML(Call <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)
  $777A,$01 Enable interrupts.
  $777B,$01 Return.

  $7790,$03 #REGbc=Characters to print.
  $7793,$03 #REGde=#R$788A
  $7796,$03 #HTML(Call <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)
  $7799,$01 Enable interrupts.

  $77C0,$03 #REGde=#R$7887
  $77C3,$03 #REGbc=Characters to print.
  $77C6,$03 #HTML(Call <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)

t $77F6 Messaging: #1
@ $77F6 label=Messaging_SplashScreen
B $77F6,$02 INK $09 (contrast - i.e. "white")
B $77F8,$02 PAPER $00 ("black")
B $77FA,$03 AT $00,$00
B $77FD,$03 TAB
B $7800,$03 TAB
T $7803,$12 Harrier Attack Game Title
B $7815,$03 TAB
B $7818,$03 TAB
B $781B,$02 PAPER $06 ("yellow")
T $781D,$22 "NAME", "LEVEL", "HITS", "SCORE" texts.
N $783F Block #2
T $783F,$1F Whitespace or buffer?
B $785E,$02 PAPER $00 ("black")
B $7860,$02 BRIGHT ON
T $7862,$20 "ENTER SKILL LEVEL (1TO5)" text.
@ $7862 label=TEXT_SKILL_LEVEL
B $7882,$02 ENTER (i.e. "NEWLINE")
B $7884,$03 TAB

B $7887,$01 SPACE
B $7888,$01 CURSOR LEFT
B $7889,$01 CURSOR LEFT
B $788A,$02 FLASH ON
B $788C,$01 SPACE
B $788D,$02 FLASH OFF
B $788F,$01 CURSOR LEFT

c $7890
  $7890,$02 #REGb=#N$37 (counter).
  $7892,$03 #REGhl=#N$09C4 (loop delay parameter).
  $7895,$03 #REGde=#N($0001,$04,$04) (number of passes).
  $7898,$02 Stash #REGbc and #REGhl on the stack.
  $789A,$03 #HTML(Call <a href="https://skoolkit.ca/disassemblies/rom/hex/asm/03B5.html">BEEPER</a>.)
  $789D,$01 Restore #REGhl from the stack.
  $789E,$05 #REGhl-=#N($001E,$04,$04).
  $78A3,$01 Restore #REGbc from the stack.
  $78A4,$02 Decrease counter by one and loop back to #R$7895 until counter is zero.
  $78A6,$04 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a>.)
  $78AA,$02 #REGa+=#N$08.
  $78AC,$03 #HTML(Loop until #REGa and <a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> are equal.)
  $78AF,$01 Return.

c $78B0

u $78EC
  $78EC,$05

i $78F1
