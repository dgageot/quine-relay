ruby QR.rb > QR.scala
scalac QR.scala && scala QR > QR.scm
gosh QR.scm > QR.sci
scilab -nw -nb -f QR.sci > QR.bash
bash QR.bash > QR.sl
slsh QR.sl > QR.st
gst QR.st > QR.spl
splrun QR.spl > QR.sml
mlton @MLton fixed-heap 200M -- QR.sml && ./QR > QR.sq
ruby vendor/subleq.rb QR.sq > QR.tcl
tclsh QR.tcl > QR.t
ruby vendor/thue.rb QR.t > QR.unl
ruby vendor/unlambda.rb QR.unl > QR.vala
valac QR.vala && ./QR > QR.v
iverilog -o QR QR.v && ./QR -vcd-none > QR.vb
vbnc QR.vb && mono ./QR.exe > QR.ws
ruby vendor/whitespace.rb QR.ws > QR.xslt
xsltproc QR.xslt > QR.yorick
yorick -batch QR.yorick > QR.azm
zoem -i QR.azm > QR.+
a+ QR.+ > qr.adb
gnatmake qr.adb && ./qr > QR.als
axi QR.als > QR.a68
a68g QR.a68 > QR.ante
ruby vendor/ante.rb QR.ante > QR.asy
asy QR.asy > QR.dats
atscc -o QR QR.dats && ./QR > QR.awk
awk -f QR.awk > QR.bc
BC_LINE_LENGTH=4000000 bc -q QR.bc > QR.bef
cfunge QR.bef > QR.Blc
ruby vendor/blc.rb < QR.Blc > QR.boo
booi QR.boo > QR.bf
bf QR.bf > QR.c
gcc -o QR QR.c && ./QR > QR.cpp
g++ -o QR QR.cpp && ./QR > QR.cs
mcs QR.cs && mono QR.exe > QR.cd
cduce QR.cd > QR.chef
PERL5LIB=vendor/local/lib/perl5 compilechef QR.chef QR.chef.pl && perl QR.chef.pl > QR.clj
clojure QR.clj > QR.cob
cobc -O2 -x QR.cob && ./QR > QR.coffee
coffee QR.coffee > QR.lisp
clisp QR.lisp > QR.d
gdc -o QR QR.d && ./QR > QR.dc
dc QR.dc > QR.ec
ecp -c QR.ec -o QR.sym && ecc -c QR.ec -o QR.c && ecs -console QR.sym QR.imp -o QR.main.ec && ecp -c QR.main.ec -o QR.main.sym && ecc -c QR.main.ec -o QR.main.c && gcc -o QR QR.c QR.main.c -lecereCOM && ./QR > QR.el
emacs -Q --script QR.el > QR.erl
escript QR.erl > QR.fsx
fsharpc QR.fsx -o QR.exe && mono QR.exe > QR.fal
falcon QR.fal > QR.false
ruby vendor/false.rb QR.false > QR.fs
gforth QR.fs > QR.f
f2c QR.f && gcc -o QR QR.c -L/usr/lib -lf2c -lm && ./QR > QR.f90
gfortran -o QR QR.f90 && ./QR > QR.gbs
gbs3 QR.gbs > QR.g
gap -q QR.g > QR.gel
genius QR.gel > QR.plt
gnuplot QR.plt > QR.go
go run QR.go > QR.gpt
gpt -o QR QR.gpt && ./QR > QR.gri
gri QR.gri > QR.groovy
groovy QR.groovy > QR.hs
ghc QR.hs && ./QR > QR.hx
haxe -main QR.hx -neko QR.n && neko QR.n > QR.icn
icont -s QR.icn && ./QR > QR.i
ick -bfO QR.i && ./QR > QR.j
jasmin QR.j && java QR > QR.java
javac QR.java && java QR > QR.js
rhino QR.js > QR.jl
julia QR.jl > QR.k
kayac QR.k && ./QR > QR.lazy
lazyk QR.lazy > qr.li
lisaac qr.li && ./qr > QR.ll
llvm-as QR.ll && lli QR.bc > QR.logo
logo QR.logo > QR.lol
lci QR.lol > QR.lua
lua QR.lua > QR.mk
make -f QR.mk > QR.mac
maxima -q --init-mac=QR.mac > QR.il
ilasm QR.il && mono QR.exe > QR.asm
nasm -felf QR.asm && ld -m elf_i386 -o QR QR.o && ./QR > QR.neko
nekoc QR.neko && neko QR.n > QR.5c
nickle QR.5c > QR.m
gcc -o QR QR.m && ./QR > QR.ml
ocaml QR.ml > QR.octave
octave -qf QR.octave > QR.ook
ruby vendor/ook-to-bf.rb QR.ook QR.ook.bf && bf QR.ook.bf > QR.gp
gp -f -q QR.gp > QR.pasm
parrot QR.pasm > QR.pas
fpc QR.pas && ./QR > QR.pl
perl QR.pl > QR.php
php QR.php > QR.png
npiet QR.png > QR.pike
pike QR.pike > QR.ps
gs -dNODISPLAY -q QR.ps > QR.ppt
ppt -d < QR.ppt > QR.prolog
swipl -q -t qr -f QR.prolog > QR.py
python QR.py > QR.R
R --slave -f QR.R > QR.ratfor
ratfor -o QR.ratfor.f QR.ratfor && gfortran -o QR QR.ratfor.f && ./QR > QR.rexx
rexx ./QR.rexx > QR2.rb
