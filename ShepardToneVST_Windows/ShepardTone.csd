<Cabbage>
form size (500, 200), caption ("Caption"), pluginID ("ID"), colour("white")
image channel("Image1"), bounds(0, 0, 500, 200), file("ShepardToneBackground.png")

button	channel ("Trigger"), bounds (85, 65, 100, 70), text("Start"), colour:0("white"), colour:1(255,77,77), fontcolour:0("black"), fontcolour:1("black")
button	channel ("Direction"), bounds (70, 150, 50, 30), text("Down", "Up"), colour:0("white"), colour:1("white"), value(1), fontcolour:0("black"), fontcolour:1("black")
rslider channel ("Range"), bounds (160, 145, 45, 45), trackercolour("white"), text ("Range"), range(0.5, 3, 2), textcolour("white"), trackeroutsideradius(1), trackerinsideradius(0.5)

rslider channel ("Volume"), bounds (400, 130, 60, 60), text ("Volume"), range(0, 1, 0.5), trackercolour("white"), textcolour("white"), trackeroutsideradius(1), trackerinsideradius(0.5)
rslider channel ("HP"), bounds (320, 60, 60, 60), trackercolour("white"), text ("High-Pass"), range(20, 20000, 10, 0.2), textcolour("white"), trackeroutsideradius(1), trackerinsideradius(0.5)
rslider channel ("LP"), bounds (400, 60, 60, 60), trackercolour("white"), text ("Low-Pass"), range(100, 20000, 20000, 0.2), textcolour("white"), trackeroutsideradius(1), trackerinsideradius(0.5)
rslider channel ("Rate"), bounds (320, 130, 60, 60), trackercolour("white"), text ("Rate"), range(1, 20, 8), textcolour("white"), trackeroutsideradius(1), trackerinsideradius(0.5)

;form size (600, 500), caption ("Caption"), pluginID ("ID"), colour("white")
;csoundoutput bounds(0, 200, 600, 300)	;Prints the compiler. Used for debugging
</Cabbage>

<CsoundSynthesizer>

<CsOptions>
-odac0 -b1024 -B2048
</CsOptions>

<CsInstruments>
ksmps = 64
nchnls = 2
0dbfs = 1

;***************************************************
; 		INSTRUMENT 1
;***************************************************
instr 1


;***************************************************
;		KONTROLLVERDIER
;***************************************************
a1, a2 ins
	kVolume		chnget	"Volume"	
	kTrig		chnget	"Trigger"
	kTrig2		=	0
	kDir		chnget	"Direction"
	kHP		chnget	"HP"
	kHP		port	kHP, 0.1
	kLP		chnget	"LP"
	kLP		port	kLP, 0.1
	kFreq		chnget	"Rate"
	kFreq		port	kFreq, 0.04
	kRange		chnget	"Range"
	kRange		port	kRange, 0.04

	iDur		=	2
	iFade		=	0.4

	kFreq		=	kFreq/1000
	kTime1		=	100
	kTime2		=	0
	if	(kDir	==	1)	then
		kValue0		=	0.1
		kValue1		=	kRange
	elseif	(kDir	==	0)	then
		kValue0		=	kRange
		kValue1		=	0.1
	endif

	kEnvValue0	=	0
	kEnvTime1	=	50
	kEnvValue1	=	1
	kEnvTime2	=	100
	kEnvValue2	=	1
	kEnvTime3	=	50

;---------  1  ---------
	iPhase_1	=	0
	kPitch_1	loopseg	kFreq, kTrig2, iPhase_1, kValue0, kTime1, kValue1, kTime2
	aOut1L, kRec1L	sndloop	a1, kPitch_1, kTrig, iDur, iFade
	aOut1R, kRec1R	sndloop	a2, kPitch_1, kTrig, iDur, iFade

	kEnv_1	loopseg kFreq, kTrig2, iPhase_1, kEnvValue0, kEnvTime1, kEnvValue1, kEnvTime2, kEnvValue2, kEnvTime3
	aOut1L	= aOut1L * kEnv_1
	aOut1R	= aOut1R * kEnv_1

;---------  2  ---------
	iPhase_2	=	0.25
	kPitch_2	loopseg	kFreq, kTrig2, iPhase_2, kValue0, kTime1, kValue1, kTime2
	aOut2L, kRec2L	sndloop	a1, kPitch_2, kTrig, iDur, iFade
	aOut2R, kRec2R	sndloop	a2, kPitch_2, kTrig, iDur, iFade

	kEnv_2	loopseg kFreq, kTrig2, iPhase_2, kEnvValue0, kEnvTime1, kEnvValue1, kEnvTime2, kEnvValue2, kEnvTime3
	aOut2L	= aOut2L * kEnv_2
	aOut2R	= aOut2R * kEnv_2

;---------  3  ---------
	iPhase_3	=	0.5	
	kPitch_3	loopseg	kFreq, kTrig2, iPhase_3, kValue0, kTime1, kValue1, kTime2
	aOut3L, kRec3L	sndloop	a1, kPitch_3, kTrig, iDur, iFade
	aOut3R, kRec3R	sndloop	a2, kPitch_3, kTrig, iDur, iFade

	kEnv_3	loopseg kFreq, kTrig2, iPhase_3, kEnvValue0, kEnvTime1, kEnvValue1, kEnvTime2, kEnvValue2, kEnvTime3
	aOut3L	= aOut3L * kEnv_3
	aOut3R	= aOut3R * kEnv_3

;---------  4  ---------
	iPhase_4	=	0.75
	kPitch_4	loopseg	kFreq, kTrig2, iPhase_4, kValue0, kTime1, kValue1, kTime2
	aOut4L, kRec4L	sndloop	a1, kPitch_4, kTrig, iDur, iFade
	aOut4R, kRec4R	sndloop	a2, kPitch_4, kTrig, iDur, iFade

	kEnv_4	loopseg kFreq, kTrig2, iPhase_4, kEnvValue0, kEnvTime1, kEnvValue1, kEnvTime2, kEnvValue2, kEnvTime3
	aOut4L	= aOut4L * kEnv_4
	aOut4R	= aOut4R * kEnv_4


;***************************************************

	aOutL	=	aOut1L + aOut2L + aOut3L + aOut4L
	aOutR	=	aOut1R + aOut2R + aOut3R + aOut4R

	aMasterL	butterlp	aOutL, kLP
	aMasterR	butterlp	aOutR, kLP
	aMasterL	butterhp	aMasterL, kHP
	aMasterR	butterhp	aMasterR, kHP

outs	aMasterL * kVolume, aMasterR * kVolume

endin

;***************************************************


</CsInstruments>

<CsScore>
i1	0	84600
e
</CsScore>

</CsoundSynthesizer>