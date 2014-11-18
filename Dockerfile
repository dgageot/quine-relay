# Build:
#   docker build -t dgageot/quine-relay .
#
# Run:
#   docker run --rm -p 8080:8080 -ti dgageot/quine-relay

# curl --data-binary @QR.rb http://localdocker:8080/

FROM ubuntu:14.10
MAINTAINER David Gageot <david@gageot.net>

# From instructions here: https://github.com/mame/quine-relay

RUN apt-get update -qq
RUN apt-get install -y algol68g
RUN apt-get install -y bash
RUN apt-get install -y bf
RUN apt-get install -y boo
RUN apt-get install -y bsdgames
RUN apt-get install -y clisp
RUN apt-get install -y clojure1.4
RUN apt-get install -y cmake
RUN apt-get install -y coffeescript
RUN apt-get install -y f2c
RUN apt-get install -y fp-compiler
RUN apt-get install -y g++
RUN apt-get install -y gauche
RUN apt-get install -y gawk
RUN apt-get install -y gcc
RUN apt-get install -y gforth
RUN apt-get install -y gfortran
RUN apt-get install -y ghc
RUN apt-get install -y ghostscript
RUN apt-get install -y git
RUN apt-get install -y gnat
RUN apt-get install -y gnu-smalltalk
RUN apt-get install -y gobjc
RUN apt-get install -y golang
RUN apt-get install -y groovy
RUN apt-get install -y icont
RUN apt-get install -y iconx
RUN apt-get install -y intercal
RUN apt-get install -y iverilog
RUN apt-get install -y jasmin-sable
RUN apt-get install -y libpng12-dev
RUN apt-get install -y llvm
RUN apt-get install -y lua5.2
RUN apt-get install -y make
RUN apt-get install -y maven
RUN apt-get install -y maxima
RUN apt-get install -y mono-devel
RUN apt-get install -y mono-mcs
RUN apt-get install -y nasm
RUN apt-get install -y neko
RUN apt-get install -y nickle
RUN apt-get install -y nodejs
RUN apt-get install -y ocaml
RUN apt-get install -y octave
RUN apt-get install -y open-cobol
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y pari-gp
RUN apt-get install -y parrot
RUN apt-get install -y perl
RUN apt-get install -y php5-cli
RUN apt-get install -y pike7.8
RUN apt-get install -y python
RUN apt-get install -y r-base
RUN apt-get install -y ratfor
RUN apt-get install -y regina-rexx
RUN apt-get install -y ruby2.0
RUN apt-get install -y scala
RUN apt-get install -y scilab
RUN apt-get install -y slsh
RUN apt-get install -y swi-prolog
RUN apt-get install -y tcl
RUN apt-get install -y ucblogo
RUN apt-get install -y valac

# Clone quine code
#
RUN git clone https://github.com/mame/quine-relay.git
WORKDIR /quine-relay
RUN git reset --hard 0c3dfc063783b11f5e63cef917e3b91f6bf9c57c
RUN cd vendor && make

# Warmup java build
#
WORKDIR /java/java
ADD docker/old_version.tgz /java
RUN mvn verify dependency:copy-dependencies -DskipTests \
    && rm -Rf /java

ADD steps /quine-relay/steps
ADD commands.sh /quine-relay/commands.sh

EXPOSE 8080
ENV LANGUAGE ruby

CMD ["/usr/lib/jvm/java-8-openjdk-amd64/bin/java", "-DPROD_MODE=true", "-Xmx32M", "-jar", "target/quine.jar"]

# Build java webapp
#
WORKDIR /java
ADD java /java
RUN mvn verify dependency:copy-dependencies -DskipTests

