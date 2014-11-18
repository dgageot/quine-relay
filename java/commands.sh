ruby QR.rb > QR.scala
scalac QR.scala && CLASSPATH=. scala QR > QR.scm
gosh QR.scm > QR.sci
scilab -nw -nb -f QR.sci > QR.bash
bash QR.bash > QR.sl
slsh QR.sl > QR.st
gst QR.st > QR.tcl
tclsh QR.tcl > QR.unl
ruby vendor/unlambda.rb QR.unl > QR.vala
valac QR.vala && ./QR > QR.v
iverilog -o QR QR.v && ./QR -vcd-none > QR.ws
ruby vendor/whitespace.rb QR.ws > qr.adb
gnatmake qr.adb && ./qr > QR.a68
a68g QR.a68 > QR.awk
awk -f QR.awk > QR.boo
booi QR.boo > QR.bf
bf QR.bf > QR.c
gcc -o QR QR.c && ./QR > QR.cpp
g++ -o QR QR.cpp && ./QR > QR.cs
mcs QR.cs && mono QR.exe > QR.clj
clojure QR.clj > QR.cob
cobc -O2 -x QR.cob && ./QR > QR.coffee
coffee QR.coffee > QR.lisp
clisp QR.lisp > QR.fs
gforth QR.fs > QR.f
f2c QR.f && gcc -o QR QR.c -L/usr/lib -lf2c && ./QR > QR.f90
gfortran -o QR QR.f90 && ./QR > QR.go
go run QR.go > QR.groovy
groovy QR.groovy > QR.hs
ghc QR.hs && ./QR > QR.icn
icont -s QR.icn && ./QR > QR.i
ick -bfO QR.i && ./QR > QR.j
jasmin QR.j && CLASSPATH=. java QR > QR.java
javac QR.java && CLASSPATH=. /usr/lib/jvm/java-8-openjdk-amd64/bin/java QR > QR.ll
llvm-as QR.ll && lli QR.bc > QR.logo
logo QR.logo > QR.lol
vendor/lci-*/lci QR.lol > QR.lua
lua QR.lua > QR.makefile
make -f QR.makefile > QR.mac
maxima -q --init-mac=QR.mac > QR.il
ilasm QR.il && mono QR.exe > QR.asm
nasm -felf QR.asm && ld -m elf_i386 -o QR QR.o && ./QR > QR.neko
nekoc QR.neko && neko QR.n > QR.5c
nickle QR.5c > QR.js
nodejs QR.js > QR.m
gcc -o QR QR.m && ./QR > QR.ml
ocaml QR.ml > QR.octave
octave -qf QR.octave > QR.ook
ruby vendor/ook.rb QR.ook > QR.gp
gp -f -q QR.gp > QR.pasm
parrot QR.pasm > QR.pas
fpc QR.pas && ./QR > QR.pl
perl QR.pl > QR.php
php QR.php > QR.png
vendor/npiet-*/npiet QR.png > QR.pike
pike QR.pike > QR.ps
gs -dNODISPLAY -q QR.ps > QR.ppt
ppt -d < QR.ppt > QR.prolog
swipl -q -t qr -f QR.prolog > QR.py
python QR.py > QR.R
R --slave -f QR.R > QR.r
ratfor -o QR.r.f QR.r && gfortran -o QR QR.r.f && ./QR > QR.rexx
rexx ./QR.rexx > QR.rb
