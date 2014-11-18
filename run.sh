#!/bin/bash

docker rm -f q-ruby q-scala q-scheme q-shell q-smalltalk q-tcl q-unlambda q-vala q-verilog q-whitespace q-ada q-algol68 q-awk q-boo q-brainfuck q-c q-cpp q-csharp q-clojure q-cobol q-coffeescript q-clisp q-forth q-fortran77 q-fortran90 q-go q-groovy q-haskell q-icon q-intercal q-jasmin q-java q-llvm q-logo q-lua q-make q-msil q-nodejs q-objectivec q-ocaml q-octave q-parrot q-pascal q-perl q-php q-pike q-prolog q-python q-r q-rexx

set -e

docker run -d --memory=1G --name=q-rexx -e LANGUAGE=rexx dgageot/quine-relay
docker run -d --memory=1G --name=q-r -e LANGUAGE=R --link=q-rexx:next dgageot/quine-relay
docker run -d --memory=1G --name=q-python -e LANGUAGE=python --link=q-r:next dgageot/quine-relay
docker run -d --memory=1G --name=q-prolog -e LANGUAGE=prolog --link=q-python:next dgageot/quine-relay
docker run -d --memory=1G --name=q-pike -e LANGUAGE=pike --link=q-prolog:next dgageot/quine-relay
docker run -d --memory=1G --name=q-php -e LANGUAGE=php --link=q-pike:next dgageot/quine-relay
docker run -d --memory=1G --name=q-perl -e LANGUAGE=perl --link=q-php:next dgageot/quine-relay
docker run -d --memory=1G --name=q-pascal -e LANGUAGE=pascal --link=q-perl:next dgageot/quine-relay
docker run -d --memory=1G --name=q-parrot -e LANGUAGE=parrot --link=q-pascal:next dgageot/quine-relay
docker run -d --memory=1G --name=q-octave -e LANGUAGE=octave --link=q-parrot:next dgageot/quine-relay
docker run -d --memory=1G --name=q-ocaml -e LANGUAGE=ocaml --link=q-octave:next dgageot/quine-relay
docker run -d --memory=1G --name=q-objectivec -e LANGUAGE=objectivec --link=q-ocaml:next dgageot/quine-relay
docker run -d --memory=1G --name=q-nodejs -e LANGUAGE=nodejs --link=q-objectivec:next dgageot/quine-relay
docker run -d --memory=1G --name=q-msil -e LANGUAGE=msil --link=q-nodejs:next dgageot/quine-relay
docker run -d --memory=1G --name=q-make -e LANGUAGE=make --link=q-msil:next dgageot/quine-relay
docker run -d --memory=1G --name=q-lua -e LANGUAGE=lua --link=q-make:next dgageot/quine-relay
docker run -d --memory=1G --name=q-logo -e LANGUAGE=logo --link=q-lua:next dgageot/quine-relay
docker run -d --memory=1G --name=q-llvm -e LANGUAGE=llvm --link=q-logo:next dgageot/quine-relay
docker run -d --memory=1G --name=q-java -e LANGUAGE=java --link=q-llvm:next dgageot/quine-relay
docker run -d --memory=1G --name=q-jasmin -e LANGUAGE=jasmin --link=q-java:next dgageot/quine-relay
docker run -d --memory=1G --name=q-intercal -e LANGUAGE=intercal --link=q-jasmin:next dgageot/quine-relay
docker run -d --memory=1G --name=q-icon -e LANGUAGE=icon --link=q-intercal:next dgageot/quine-relay
docker run -d --memory=1G --name=q-haskell -e LANGUAGE=haskell --link=q-icon:next dgageot/quine-relay
docker run -d --memory=1G --name=q-groovy -e LANGUAGE=groovy --link=q-haskell:next dgageot/quine-relay
docker run -d --memory=1G --name=q-go -e LANGUAGE=go --link=q-groovy:next dgageot/quine-relay
docker run -d --memory=1G --name=q-fortran90 -e LANGUAGE=fortran90 --link=q-go:next dgageot/quine-relay
docker run -d --memory=1G --name=q-fortran77 -e LANGUAGE=fortran77 --link=q-fortran90:next dgageot/quine-relay
docker run -d --memory=1G --name=q-forth -e LANGUAGE=forth --link=q-fortran77:next dgageot/quine-relay
docker run -d --memory=1G --name=q-clisp -e LANGUAGE=clisp --link=q-forth:next dgageot/quine-relay
docker run -d --memory=1G --name=q-coffeescript -e LANGUAGE=coffeescript --link=q-clisp:next dgageot/quine-relay
docker run -d --memory=1G --name=q-cobol -e LANGUAGE=cobol --link=q-coffeescript:next dgageot/quine-relay
docker run -d --memory=1G --name=q-clojure -e LANGUAGE=clojure --link=q-cobol:next dgageot/quine-relay
docker run -d --memory=1G --name=q-csharp -e LANGUAGE=csharp --link=q-clojure:next dgageot/quine-relay
docker run -d --memory=1G --name=q-cpp -e LANGUAGE=cpp --link=q-csharp:next dgageot/quine-relay
docker run -d --memory=1G --name=q-c -e LANGUAGE=c --link=q-cpp:next dgageot/quine-relay
docker run -d --memory=1G --name=q-brainfuck -e LANGUAGE=brainfuck --link=q-c:next dgageot/quine-relay
docker run -d --memory=1G --name=q-boo -e LANGUAGE=boo --link=q-brainfuck:next dgageot/quine-relay
docker run -d --memory=1G --name=q-awk -e LANGUAGE=awk --link=q-boo:next dgageot/quine-relay
docker run -d --memory=1G --name=q-algol68 -e LANGUAGE=algol68 --link=q-awk:next dgageot/quine-relay
docker run -d --memory=1G --name=q-ada -e LANGUAGE=ada --link=q-algol68:next dgageot/quine-relay
docker run -d --memory=1G --name=q-whitespace -e LANGUAGE=whitespace --link=q-ada:next dgageot/quine-relay
docker run -d --memory=1G --name=q-verilog -e LANGUAGE=verilog --link=q-whitespace:next dgageot/quine-relay
docker run -d --memory=1G --name=q-vala -e LANGUAGE=vala --link=q-verilog:next dgageot/quine-relay
docker run -d --memory=1G --name=q-unlambda -e LANGUAGE=unlambda --link=q-vala:next dgageot/quine-relay
docker run -d --memory=1G --name=q-tcl -e LANGUAGE=tcl --link=q-unlambda:next dgageot/quine-relay
docker run -d --memory=1G --name=q-smalltalk -e LANGUAGE=smalltalk --link=q-tcl:next dgageot/quine-relay
docker run -d --memory=1G --name=q-shell -e LANGUAGE=shell --link=q-smalltalk:next dgageot/quine-relay
docker run -d --memory=1G --name=q-scheme -e LANGUAGE=scheme --link=q-shell:next dgageot/quine-relay
docker run -d --memory=1G --name=q-scala -e LANGUAGE=scala --link=q-scheme:next dgageot/quine-relay
docker run -d --memory=1G --name=q-ruby -e LANGUAGE=ruby -p 8080:8080 --link=q-scala:next dgageot/quine-relay
./logs.sh q-ruby q-scala q-scheme q-shell q-smalltalk q-tcl q-unlambda q-vala q-verilog q-whitespace q-ada q-algol68 q-awk q-boo q-brainfuck q-c q-cpp q-csharp q-clojure q-cobol q-coffeescript q-clisp q-forth q-fortran77 q-fortran90 q-go q-groovy q-haskell q-icon q-intercal q-jasmin q-java q-llvm q-logo q-lua q-make q-msil q-nodejs q-objectivec q-ocaml q-octave q-parrot q-pascal q-perl q-php q-pike q-prolog q-python q-r q-rexx