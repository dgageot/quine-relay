#!/bin/bash

docker build -t quine .

docker rm -f q-ruby q-scala q-scheme q-scilab q-shell q-slang q-smalltalk q-spl q-ml q-subleq q-tcl q-thue q-unlambda q-vala q-verilog q-vbasic q-whitespace q-xslt q-yorick q-zoem q-aplus q-ada q-afnix q-algol68 q-ante q-asymptote q-ats q-awk q-bc q-befunge q-blc8 q-boo q-brainfuck q-c q-cpp q-csharp q-cduce q-chef q-clojure q-cobol q-coffeescript q-clisp q-d q-dc q-ec q-emacslist q-erlang q-fsharp q-falcon q-false q-forth q-fortran77 q-fortran90 q-gambas q-gap q-gel q-gnuplot q-go q-gpt q-gri q-groovy q-haskell q-haxe q-icon q-intercal q-jasmin q-java q-javascript q-julia q-katya q-lazyk q-lisaac q-llvm q-logo q-lolcode q-lua q-make q-maxima q-msil q-nasm q-neko q-nickle q-objectivec q-ocaml q-octave q-ook q-parigp q-parrot q-pascal q-perl q-php q-piet q-pike q-postscript q-ppt q-prolog q-python q-r q-ratfor q-rexx

set -e

docker run -d --memory=1G --name=q-rexx -e LANGUAGE=rexx quine
docker run -d --memory=1G --name=q-ratfor -e LANGUAGE=ratfor --link=q-rexx:next quine
docker run -d --memory=1G --name=q-r -e LANGUAGE=r --link=q-ratfor:next quine
docker run -d --memory=1G --name=q-python -e LANGUAGE=python --link=q-r:next quine
docker run -d --memory=1G --name=q-prolog -e LANGUAGE=prolog --link=q-python:next quine
docker run -d --memory=1G --name=q-ppt -e LANGUAGE=ppt --link=q-prolog:next quine
docker run -d --memory=1G --name=q-postscript -e LANGUAGE=postscript --link=q-ppt:next quine
docker run -d --memory=1G --name=q-pike -e LANGUAGE=pike --link=q-postscript:next quine
docker run -d --memory=1G --name=q-piet -e LANGUAGE=piet --link=q-pike:next quine
docker run -d --memory=1G --name=q-php -e LANGUAGE=php --link=q-piet:next quine
docker run -d --memory=1G --name=q-perl -e LANGUAGE=perl --link=q-php:next quine
docker run -d --memory=1G --name=q-pascal -e LANGUAGE=pascal --link=q-perl:next quine
docker run -d --memory=1G --name=q-parrot -e LANGUAGE=parrot --link=q-pascal:next quine
docker run -d --memory=1G --name=q-parigp -e LANGUAGE=parigp --link=q-parrot:next quine
docker run -d --memory=1G --name=q-ook -e LANGUAGE=ook --link=q-parigp:next quine
docker run -d --memory=1G --name=q-octave -e LANGUAGE=octave --link=q-ook:next quine
docker run -d --memory=1G --name=q-ocaml -e LANGUAGE=ocaml --link=q-octave:next quine
docker run -d --memory=1G --name=q-objectivec -e LANGUAGE=objectivec --link=q-ocaml:next quine
docker run -d --memory=1G --name=q-nickle -e LANGUAGE=nickle --link=q-objectivec:next quine
docker run -d --memory=1G --name=q-neko -e LANGUAGE=neko --link=q-nickle:next quine
docker run -d --memory=1G --name=q-nasm -e LANGUAGE=nasm --link=q-neko:next quine
docker run -d --memory=1G --name=q-msil -e LANGUAGE=msil --link=q-nasm:next quine
docker run -d --memory=1G --name=q-maxima -e LANGUAGE=maxima --link=q-msil:next quine
docker run -d --memory=1G --name=q-make -e LANGUAGE=make --link=q-maxima:next quine
docker run -d --memory=1G --name=q-lua -e LANGUAGE=lua --link=q-make:next quine
docker run -d --memory=1G --name=q-lolcode -e LANGUAGE=lolcode --link=q-lua:next quine
docker run -d --memory=1G --name=q-logo -e LANGUAGE=logo --link=q-lolcode:next quine
docker run -d --memory=1G --name=q-llvm -e LANGUAGE=llvm --link=q-logo:next quine
docker run -d --memory=1G --name=q-lisaac -e LANGUAGE=lisaac --link=q-llvm:next quine
docker run -d --memory=1G --name=q-lazyk -e LANGUAGE=lazyk --link=q-lisaac:next quine
docker run -d --memory=1G --name=q-katya -e LANGUAGE=katya --link=q-lazyk:next quine
docker run -d --memory=1G --name=q-julia -e LANGUAGE=julia --link=q-katya:next quine
docker run -d --memory=1G --name=q-javascript -e LANGUAGE=javascript --link=q-julia:next quine
docker run -d --memory=1G --name=q-java -e LANGUAGE=java --link=q-javascript:next quine
docker run -d --memory=1G --name=q-jasmin -e LANGUAGE=jasmin --link=q-java:next quine
docker run -d --memory=1G --name=q-intercal -e LANGUAGE=intercal --link=q-jasmin:next quine
docker run -d --memory=1G --name=q-icon -e LANGUAGE=icon --link=q-intercal:next quine
docker run -d --memory=1G --name=q-haxe -e LANGUAGE=haxe --link=q-icon:next quine
docker run -d --memory=1G --name=q-haskell -e LANGUAGE=haskell --link=q-haxe:next quine
docker run -d --memory=1G --name=q-groovy -e LANGUAGE=groovy --link=q-haskell:next quine
docker run -d --memory=1G --name=q-gri -e LANGUAGE=gri --link=q-groovy:next quine
docker run -d --memory=1G --name=q-gpt -e LANGUAGE=gpt --link=q-gri:next quine
docker run -d --memory=1G --name=q-go -e LANGUAGE=go --link=q-gpt:next quine
docker run -d --memory=1G --name=q-gnuplot -e LANGUAGE=gnuplot --link=q-go:next quine
docker run -d --memory=1G --name=q-gel -e LANGUAGE=gel --link=q-gnuplot:next quine
docker run -d --memory=1G --name=q-gap -e LANGUAGE=gap --link=q-gel:next quine
docker run -d --memory=1G --name=q-gambas -e LANGUAGE=gambas --link=q-gap:next quine
docker run -d --memory=1G --name=q-fortran90 -e LANGUAGE=fortran90 --link=q-gambas:next quine
docker run -d --memory=1G --name=q-fortran77 -e LANGUAGE=fortran77 --link=q-fortran90:next quine
docker run -d --memory=1G --name=q-forth -e LANGUAGE=forth --link=q-fortran77:next quine
docker run -d --memory=1G --name=q-false -e LANGUAGE=false --link=q-forth:next quine
docker run -d --memory=1G --name=q-falcon -e LANGUAGE=falcon --link=q-false:next quine
docker run -d --memory=1G --name=q-fsharp -e LANGUAGE=fsharp --link=q-falcon:next quine
docker run -d --memory=1G --name=q-erlang -e LANGUAGE=erlang --link=q-fsharp:next quine
docker run -d --memory=1G --name=q-emacslist -e LANGUAGE=emacslist --link=q-erlang:next quine
docker run -d --memory=1G --name=q-ec -e LANGUAGE=ec --link=q-emacslist:next quine
docker run -d --memory=1G --name=q-dc -e LANGUAGE=dc --link=q-ec:next quine
docker run -d --memory=1G --name=q-d -e LANGUAGE=d --link=q-dc:next quine
docker run -d --memory=1G --name=q-clisp -e LANGUAGE=clisp --link=q-d:next quine
docker run -d --memory=1G --name=q-coffeescript -e LANGUAGE=coffeescript --link=q-clisp:next quine
docker run -d --memory=1G --name=q-cobol -e LANGUAGE=cobol --link=q-coffeescript:next quine
docker run -d --memory=1G --name=q-clojure -e LANGUAGE=clojure --link=q-cobol:next quine
docker run -d --memory=1G --name=q-chef -e LANGUAGE=chef --link=q-clojure:next quine
docker run -d --memory=1G --name=q-cduce -e LANGUAGE=cduce --link=q-chef:next quine
docker run -d --memory=1G --name=q-csharp -e LANGUAGE=csharp --link=q-cduce:next quine
docker run -d --memory=1G --name=q-cpp -e LANGUAGE=cpp --link=q-csharp:next quine
docker run -d --memory=1G --name=q-c -e LANGUAGE=c --link=q-cpp:next quine
docker run -d --memory=1G --name=q-brainfuck -e LANGUAGE=brainfuck --link=q-c:next quine
docker run -d --memory=1G --name=q-boo -e LANGUAGE=boo --link=q-brainfuck:next quine
docker run -d --memory=1G --name=q-blc8 -e LANGUAGE=blc8 --link=q-boo:next quine
docker run -d --memory=1G --name=q-befunge -e LANGUAGE=befunge --link=q-blc8:next quine
docker run -d --memory=1G --name=q-bc -e LANGUAGE=bc --link=q-befunge:next quine
docker run -d --memory=1G --name=q-awk -e LANGUAGE=awk --link=q-bc:next quine
docker run -d --memory=1G --name=q-ats -e LANGUAGE=ats --link=q-awk:next quine
docker run -d --memory=1G --name=q-asymptote -e LANGUAGE=asymptote --link=q-ats:next quine
docker run -d --memory=1G --name=q-ante -e LANGUAGE=ante --link=q-asymptote:next quine
docker run -d --memory=1G --name=q-algol68 -e LANGUAGE=algol68 --link=q-ante:next quine
docker run -d --memory=1G --name=q-afnix -e LANGUAGE=afnix --link=q-algol68:next quine
docker run -d --memory=1G --name=q-ada -e LANGUAGE=ada --link=q-afnix:next quine
docker run -d --memory=1G --name=q-aplus -e LANGUAGE=aplus --link=q-ada:next quine
docker run -d --memory=1G --name=q-zoem -e LANGUAGE=zoem --link=q-aplus:next quine
docker run -d --memory=1G --name=q-yorick -e LANGUAGE=yorick --link=q-zoem:next quine
docker run -d --memory=1G --name=q-xslt -e LANGUAGE=xslt --link=q-yorick:next quine
docker run -d --memory=1G --name=q-whitespace -e LANGUAGE=whitespace --link=q-xslt:next quine
docker run -d --memory=1G --name=q-vbasic -e LANGUAGE=vbasic --link=q-whitespace:next quine
docker run -d --memory=1G --name=q-verilog -e LANGUAGE=verilog --link=q-vbasic:next quine
docker run -d --memory=1G --name=q-vala -e LANGUAGE=vala --link=q-verilog:next quine
docker run -d --memory=1G --name=q-unlambda -e LANGUAGE=unlambda --link=q-vala:next quine
docker run -d --memory=1G --name=q-thue -e LANGUAGE=thue --link=q-unlambda:next quine
docker run -d --memory=1G --name=q-tcl -e LANGUAGE=tcl --link=q-thue:next quine
docker run -d --memory=1G --name=q-subleq -e LANGUAGE=subleq --link=q-tcl:next quine
docker run -d --memory=1G --name=q-ml -e LANGUAGE=ml --link=q-subleq:next quine
docker run -d --memory=1G --name=q-spl -e LANGUAGE=spl --link=q-ml:next quine
docker run -d --memory=1G --name=q-smalltalk -e LANGUAGE=smalltalk --link=q-spl:next quine
docker run -d --memory=1G --name=q-slang -e LANGUAGE=slang --link=q-smalltalk:next quine
docker run -d --memory=1G --name=q-shell -e LANGUAGE=shell --link=q-slang:next quine
docker run -d --memory=1G --name=q-scilab -e LANGUAGE=scilab --link=q-shell:next quine
docker run -d --memory=1G --name=q-scheme -e LANGUAGE=scheme --link=q-scilab:next quine
docker run -d --memory=1G --name=q-scala -e LANGUAGE=scala --link=q-scheme:next quine
docker run -d --memory=1G --name=q-ruby -e LANGUAGE=ruby -p 8080:8080 --link=q-scala:next quine

./logs.sh q-ruby q-scala q-scheme q-scilab q-shell q-slang q-smalltalk q-spl q-ml q-subleq q-tcl q-thue q-unlambda q-vala q-verilog q-vbasic q-whitespace q-xslt q-yorick q-zoem q-aplus q-ada q-afnix q-algol68 q-ante q-asymptote q-ats q-awk q-bc q-befunge q-blc8 q-boo q-brainfuck q-c q-cpp q-csharp q-cduce q-chef q-clojure q-cobol q-coffeescript q-clisp q-d q-dc q-ec q-emacslist q-erlang q-fsharp q-falcon q-false q-forth q-fortran77 q-fortran90 q-gambas q-gap q-gel q-gnuplot q-go q-gpt q-gri q-groovy q-haskell q-haxe q-icon q-intercal q-jasmin q-java q-javascript q-julia q-katya q-lazyk q-lisaac q-llvm q-logo q-lolcode q-lua q-make q-maxima q-msil q-nasm q-neko q-nickle q-objectivec q-ocaml q-octave q-ook q-parigp q-parrot q-pascal q-perl q-php q-piet q-pike q-postscript q-ppt q-prolog q-python q-r q-ratfor q-rexx
