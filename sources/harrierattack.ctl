> $4000 @org=$4000
b $4000 Loading screen
D $4000 #UDGTABLE { #SCR(loading) | Harrier Attack Loading Screen. } TABLE#
@ $4000 label=LOADING
B $4000,6144,32 Pixels
B $5800,768,32 Attributes

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
C $6007,$18 #REGhl=$581F
@ $600F label=LOOP
  $601F,$03 Call #R$6E89.
  $602A,$0B Copies $100 bytes of data from $5800
  $6035,$0B Copies $800 bytes of data from ...

c $604D
  $604D,$0B Copies the byte contained at $5900 to the following $FF bytes.
  $6058,$0B Copies the byte contained at $4800 to the following $7FF bytes.
  $6063,$02 Check if D3 of #REGa is set?

c $60D6
N $60D6 On entry #REGhl is a number between 0-$F20 corresponding to the playarea.
  $60D6,$01 Stash #REGaf on the stack.
  $60D7,$01 
  $60E3,$03 Set bit 6 of #REGb which converts #REGbc to a screen address.
  $60E6,$01 Retrieve #REGaf from the stack.
  $60E7,$01 Return.

c $60E8 Fetch UDG Address.
@ $60E8 label=UDG_ADDRESS
  $60E8,$01 Stash #REGhl on the stack.
  $60E9,$0B Point #REGde at the graphic data for the corresponding tile (at #R$6580($6580)+8*#REGa).
  $60F4,$01 Retrieve #REGhl from the stack.
  $60F5,$01 Return.

c $60F6
  $60F6,$01 Stash #REGhl on the stack.
  $60F7,$01 #REGa=MSB of #REGhl.
  $60F8,$03 Moves the LSB to the MSB of #REGhl and writes $00 to the LSB.
  $60FB,$05 #REGhl * 5.
  $6100,$02 OR ... TODO and store the result in #REGl.
  $6102,$03 #REGde=$5800
  $6105,$02 Store the result in #REGde.
  $6107,$01 Retrieve #REGhl from the stack.
  $6108,$01 Return.

c $6109 Draw UDG.
N $6109 On entry #REGbc should point to a screen address and #REGde to the address of a #R$6580(UDG) tile.
@ $6109 label=UDG_DRAW
@ $610D label=UDG_DRAW_LOOP
  $6109,$02 Copies #REGbc containing the screen address into #REGhl.
  $610B,$09 Draw the UDG graphic data to the screen.
  $6113,$01 Return.

c $6114
  $6115,$03 Call #R$60F6.
  $6118,$03 Check if the current attribute byte is $2F?
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
@ $613E label=XXXX
  $6143,$01 Retrieve #REGaf from the stack.
  $6144,$01 Return.
N $6145 Else, loop back to the start.
@ $6145 label=XXXXX
  $6145,$01 Retrieve #REGaf from the stack.
  $6146,$02 Jump back to #R$612B.

c $6148

b $6580 Game UDGs
@ $6580 label=UDGS
  $6580,$08 #UDG(#PC,attr=56)
L $6580,$08,$6C

s $68E0 Buffer Of Some Kind...

c $69A8

b $6A1C

c $6BE7

c $6C77

c $6CF6
  $6CFA,$01 Grab the counter off the stack.
  $6CFB,$02 Decrease counter by one and loop back to #R$6CF6 until counter is zero.
  $6CFD,$01 Return.
  $6CFE,$0A Copies $32 bytes of data from ...

c $6D09

c $6BD0
c $6DB4

c $6DD0

c $6E0E

c $6E89

c $6EF0

c $6F47 Crash Sound/ Border Flash.
N $6F47 On entry #REGc is a counter for how long the effect will last.
@ $6F47 label=CRASH_SOUND
  $6F47,$03 Point to #R$6A1C.
  $6F4A,$01 #REGa=$00.
@ $6F4B label=CRASH_SOUND_LOOP
  $6F4B,$01 #REGb=Fetch the sound data byte.
  $6F4C,$01 Move onto the next sound data byte.
@ $6F4D label=
  $6F4D,$02 #R$6F4D.
  $6F4F,$02 #REGa=$10.
  $6F51,$02 Border colour.
  $6F53,$01 #REGb=Fetch the sound data byte.
  $6F54,$01 Move onto the next sound data byte.
@ $6F55 label=
  $6F55,$02 #R$6F55.
  $6F57,$02 #REGa=$00.
  $6F59,$02 Border colour.
  $6F5B,$01 #REGa=$01.
  $6F5C,$03
  $6F5F,$01 #REGa=$00.
  $6F60,$02 Border colour.
  $6F62,$01 Return. 

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

  $7178,$0B Writes $2D to all but the botttom row of the playarea attribute space and UDG #R$6580($00) to each block using #R$612B.
  $7183,$0A Writes $79 to the bottom row of the playarea attribute space and UDG #R$65C8($09) to each block using #R$612B.
  $718D,$09 Writes $00 to the next row down of the attribute space and UDG #R$6580($00) to each block using #R$612B.


b $721A 
  $723F #UDG(#PC)
L $723F,$08,$0B

c $72CA
  $72CA,$03 #REGa=#R$5B22

c $739D

c $7533

  $753D,$01 Return.
B $753E,$02 PAPER $00 ("black")
B $7540,$02 INK $07 ("white")
B $7542,$03 AT $#N(#PEEK$7543), $#N(#PEEK$7544)
B $7545,$0F ????

  $755D,$05 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C6A.html">FLAGS2</a> force CAPS LOCK on.)

  $7562,$05 #HTML(<a href="https://skoolkid.github.io/rom/asm/1601.html">CHAN_OPEN</a> (open upper screen channel).)
  $7567,$03 #REGde=#R$753E
  $756A,$03 #REGbc=Characters to print.
  $756D,$03 #HTML(Calls <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)
  $7570,$03 #REGde=#R$7862
  $7573,$03 #REGbc=Characters to print.
  $7576,$03 #HTML(Calls <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)

  $7579,$03 #REGhl=$5B00

  $7583,$03 #HTML(#REGa=#2 <a href="https://skoolkid.github.io/rom/asm/5C00.html">KSTATE</a> call counter.)
  $7586,$03 If #REGa is zero jump back to #R$7583.
  $7589,$03 #HTML(#REGa=<a href="https://skoolkid.github.io/rom/asm/5C08.html">LAST-K</a> (last key pressed).)
  $758C,$02 Subtract $31.
  $758E,$02 If there is carry jump back to #R$7583.
  $7590,$02 Is the result $05?
  $7592,$02 If there is no carry jump back to #R$7583.
  $7594,$01 Increment #REGa by one.
  $7595,$03 Store #REGa at #R$5B27.
  $7598,$03 #HTML(#REGhl=<a href="https://skoolkid.github.io/rom/asm/5C78.html">FRAMES</a> as a random number seed.)

  $75A4,$0B Copy $0F bytes of data from #R$7545 to $5B0A.

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
N $7649 High Score entry #EVAL(10-(#PC-$7649)/$0C)
T $7649,$06 Name
  $764F,$01 Level
  $7650,$02 Hits
  $7652,$03 Score
L $7649,$0C,$0A

c $76C1
  $76C5,$01 Disables interrupts.

  $7729,$03 #REGde=#R$77F6
  $772C,$03 #REGbc=Characters to print.
  $772F,$03 #HTML(Calls <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)

  $775D,$03 Print "0" to the screen.

  $7760,$03 #REGbc=Characters to print.
  $7763,$03 #REGde=#R$7884
  $7766,$03 #HTML(Calls <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)

  $7771,$03 #REGde=#R$783F
  $7774,$03 #REGbc=Characters to print.
  $7777,$03 #HTML(Calls <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)
  $777A,$01 Enable interrupts.
  $777B,$01 Return.

  $7790,$03 #REGbc=Characters to print.
  $7793,$03 #REGde=#R$788A
  $7796,$03 #HTML(Calls <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)
  $7799,$01 Enable interrupts.

  $77C0,$03 #REGde=#R$7887
  $77C3,$03 #REGbc=Characters to print.
  $77C6,$03 #HTML(Calls <a href="https://skoolkid.github.io/rom/asm/1FFC.html#203C">PR_STRING</a>.)

N $77F6 Block #1
@ $77F6 label=SPLASH_TEXT
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

i $8000
