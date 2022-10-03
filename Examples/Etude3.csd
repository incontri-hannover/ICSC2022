<CsoundSynthesizer>
<CsOptions>
-odac -m128
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

instr All_bounces
 kLine = linseg:k(p4, p3, p5)
 kMetroFreq = 1/(p3/10*kLine)
 kTrigger = metro(kMetroFreq)
  if  kTrigger == 1 then
   schedulek("One_bounce",0,p6,kLine,p7,p8)
  endif 
endin

instr One_bounce
 iDecay = p4 //receives what is kLine in 'All_bounces'
 iMFRandom = random:i(1, 1000)
 iMFRandom2 = random:i(1/10, 10)
 kModFreq = randomi:k(p5, p5+iMFRandom, iMFRandom2)
 aMod = poscil:a(iDecay*70,kModFreq)
 aEnv = linseg:a(0,0.002,1,p3-0.002,0)^2
 aCarrFreq = 1+p6*iDecay*aEnv^2
 aCar = poscil:a(iDecay*0.2,aCarrFreq+aMod)
 outall(aCar*aEnv*0.2)
endin

</CsInstruments>
<CsScore>
;               s.t.  dur.  s.L.  e.L. 1bDur  MF    CF   
i "All_bounces" 0     6.7   1     0    4      930   4400 
i "All_bounces" 6.7   7.3   0     1    1.8    760   250  
i "All_bounces" 12.1  9.2   0     1    3.5    718   47
i "All_bounces" 13.5  5     0     1    4.2    370   144
i "All_bounces" 22.6  4.8   0     1    0.1    20    148
i "All_bounces" 23.7  3.2   0     1    2.7    17    87
i "All_bounces" 24    7     0     1    2.8    9     103
i "All_bounces" 25.8  8     1     0    2.4    13    4100
i "All_bounces" 27    9.1   1     0    0.6    150   82
i "All_bounces" 35.2  10.2  1     0    3.1    136   50
i "All_bounces" 35.9  4.3   0     1    3.4    310   31
i "All_bounces" 37.2  8.5   1     0    3.8    9     1190
i "All_bounces" 39.4  9     1     0    4.7    58    1280
i "All_bounces" 46    2.8   1     0    0.4    8     1250
i "All_bounces" 46.6  6.5   0     1    2.7    104   3.1
i "All_bounces" 50.5  5.2   0     1    0.5    9     52
i "All_bounces" 51.2  3.9   0     1    2.5    82    4
i "All_bounces" 51.9  3     0     1    2      139   3000
i "All_bounces" 53.6  2.9   0     1    2      11    3
i "All_bounces" 53.8  6.6   1     0    3.4    58    99
i "All_bounces" 55    13.9  0     1    2.7    8     4
i "All_bounces" 66.6  5.3   0     1    1.2    64    5400
i "All_bounces" 68.6  2.6   0     1    0.5    28    650
i "All_bounces" 73.6  15.3  1     0    1.3    36    1
i "All_bounces" 81.1  1     1     0    0.3    81    2
i "All_bounces" 85.1  3     0     1    0.7    3     9
i "All_bounces" 85.8  9.3   0     1    5.5    14    350
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
