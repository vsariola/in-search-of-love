--{
d={ 
 1,1,1,1,1,1,2,2,2,2, -- chn1
 0,3,1,1,2,2,1,1,2,2, -- chn2
 3,3,3,3,3,3,3,3,3,3, -- chn3
 0,4,4,4,4,4,0,4,4,4,4, -- chn4  
 -2,
 1,0,0,1,0,0,1,0,0,1,0,2, -- pat1
 1,0,3,5,0,3,5,0,5,3,0,3, -- pat2
 0,0,0,1,0,0,0,0,0,1,0,0, -- pat3
 1,1,0,0,0,0,1,0,0,0,1,0, -- pat4
 2,1,6,2,1,4,5, 
 circb,function(...)print(p,...)end,function(...)x,y,k,e=...circ(x-k,y,1.2*k,e+2)circ(x+k,y,1.2*k,e+2)tri(x-k*2.3,y,x+k*2.3,y,x,y+k*3,e+2)end
}

function TIC()
 for k=0,3 do
  p=t//672 -- orderlist pos
  poke(65896,48) -- set chn 2 wave
  i=t<<d[k+42] -- envelope pos
  -- n is note (semitones), 0=no note
  n=d[
      12*d[10*k+p+1]+31 -- patstart
      +i//14%12 -- patrow
     ]
  d[-k]=n*d[10*k+p+1]//-30*i%14
  u=d[
    p%9//6*3 -- key pat
    +91+t//168%4 -- key row
   ] -- key change
  
  sfx(
   k, -- channel k uses wave k
   11 -- global pitch:
    +((n+k%3%2*t%7*2-1-u//3*2)*7//6+u+7*k)*12//7 -- note
    -k//3*i%14*7 -- pitch drop
    , 
   2,
   k,
   d[-k] -- stored envelope
  )
 end
 cls((6+p/2)%9+2) 
 
 xx=xx+d[-3]

 for i=9,1,-.1 do 
  for k=1,99 do
   x=(
      s(i)*8e3
      -xx
      +s(k/19+i^6.5-t/61)*9
     )/i%300-60
   d[98+p%3](
    x,
    130-k/i+1e5/t,
    (11-k/9)/i,
    d[-3]/3-i
   )
  end
  d[98+p//7*2](
   x,
   (i^6.5-t)/i%300-60,
   15/i+1,
   -d[-2]/3
  )
 end

 for i=p//10*-9,1 do
  for k=-15,15 do
  	 --{
    y=s(xx/43+k/53+t/61-i)*50+60
    x=80+k+s(xx/43+t/61-i)*50+
      i*8e3*2^-p+s((k+t)/13)*9
    --}
    circ(
     x,
     y,
     9/(1-i//14)-k^2/14+d[0]/3,
     -k/3+i*6
    )
    rect(
     x,
     y,
     2,
     9/(1-i//14)-k-9,
     -k/3+i*6
    )
  end 
 end
 t=t+1,p<11 or exit()--,p>0or print("in search of love",9,9,12)
end
t=1
xx=1
s=math.sin
--}

--![ pakettic ignores the following

TOC=TIC
TIC=function()
 TOC()
 updatetime = false
 if btn(2) then
  t=t-100
  if t<0 then t=0 end
  updatetime=true
 end   
 if btn(3) then
  t=t+100
  updatetime=true
 end
 if updatetime then
  xx=0
  for i=0,t-1 do  
   for k=0,3 do  
    p=i//672 -- orderlist pos
    e=i<<d[k+42]
    n=d[
     12*d[10*k+p+1]+31 -- patstart
     +e//14%12 -- patrow
    ]
    d[-k]=n*d[10*k+p+1]//-30*e%14
   end
   xx=xx+d[-3]   
  end
 end
end

--!]
-- <TILES>
-- 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
-- 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <TRACKS>
-- 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </TRACKS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

