<CsoundSynthesizer>
<CsOptions>
-odac -d -m128
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

seed 1
rndseed random:i(0,1)

//make all random in All_bounces

instr Produce_Chaos
 iTotalDur = 60
 iHowMany = 50
 iInstance = 0
 while iInstance < iHowMany do
  iStart = random(0,iTotalDur)
  iDur = random:i(1,10)
  schedule("All_bounces",iStart,iDur)
  iInstance += 1
 od 
endin

instr All_bounces
 //INPUTS
 iLineStart = rnd:i(1) //usually 1
 iLineEnd = rnd:i(1) //usually nearly 0
 iFirstDistRatio = rnd:i(.5) //ratio of first distance to overall duration (< 1)
 iVolDb = random:i(-30,-10) //default -12
 print(p3,iLineStart,iLineEnd,iFirstDistRatio,iVolDb)
 //CALCULATION AND TRIGGERING
 kDecayLine = linseg:k(iLineStart,p3,iLineEnd)
 kMetroFreq = 1/(p3*iFirstDistRatio*kDecayLine) 
  if  metro(kMetroFreq) == 1 then
   kDurDistRatio = random:k(.2,2) //ratio between one bounce's duration and time distance to next bounce
   schedulek("One_bounce",0,kDurDistRatio/kMetroFreq,kDecayLine,iVolDb)
  endif 
endin

instr One_bounce
 //INPUT
 iDecayPoint = p4 //receives what is kDecayLine in 'All_bounces'
 iVolDb = p5
 iCarBasFreq = 80 //default 80
 iCarBasFreqMaxDev = 130 //default 130
 iModAmpMax = 70 //default 70
 iPan = .5 //default .5
 iPanMaxDev = .5 //default 0
 //CALCULATION
 aMod = poscil:a(iDecayPoint*iModAmpMax,120)
 aEnv = linseg:a(0,0.002,1,p3-0.002,0)^2
 aCarrFreq = iCarBasFreq+iCarBasFreqMaxDev*iDecayPoint*aEnv^2
 aCar = poscil:a(iDecayPoint*ampdb(iVolDb),aCarrFreq+aMod)
 aL, aR pan2 aCar*aEnv, iPan+birnd:i(iPanMaxDev)
 out(aL,aR)
endin

schedule("Produce_Chaos",0,0)

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
