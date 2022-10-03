<CsoundSynthesizer>
<CsOptions>
-odac -m128
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

seed 3
rndseed random:i(0,1)

//make all random in All_bounces and also in One_bounce

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
 iCarBasPitch = random:i(1,84) //pitch a midi note number
 iCarBasFreq = mtof:i(iCarBasPitch)
 iCarBasFreqMaxDev = random:i(100,500) //default 130
 iModAmpMax = random:i(50,100) //default 70
 iPan = random:i(.2,.8) //default .5
 iPanMaxDev = random:i(0,.2) //default 0
 //CALCULATION
 aMod = poscil:a(iDecayPoint*iModAmpMax,120)
 aEnv = linseg:a(0,0.002,1,p3-0.002,0)^2
 //change gliss direction
 if rnd:i(1) < 0.9 then
  aCarFreqEnv = aEnv^2
 else
  aCarFreqEnv = 1 - aEnv^2
 endif
 aCarrFreq = iCarBasFreq+iCarBasFreqMaxDev*iDecayPoint*aCarFreqEnv
 aCar = poscil:a(iDecayPoint*ampdb(iVolDb),aCarrFreq+aMod)
 aL, aR pan2 aCar*aEnv, iPan+birnd:i(iPanMaxDev)
 out(aL,aR)
endin

</CsInstruments>
<CsScore>
i "Produce_Chaos" 0 70
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
