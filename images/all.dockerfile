FROM quine/base

RUN apt-get update -qq && apt-get install -y \
	aplus-fsf \
	asymptote \
	ats-lang-anairiats \
	bash \
	bsdgames \
	bf \
	clisp \
	ecere-sdk \
	f2c \
	falconpl \
	fp-compiler \
	fsharp \
	gambas3-script \
	gauche \
	gawk \
	gforth \
	gfortran \
	ghc \
	ghostscript \
	gnu-smalltalk \
	gobjc \
	gpt \
	gri \
	iconx \
	intercal \
	iverilog \
	libpng12-dev \
	lisaac \
	llvm \
	make \
	mono-devel \
	mono-mcs \
	mono-vbnc \
	nasm \
	openjdk-8-jdk \
	pari-gp \
	perl \
	php5-cli \
	pike7.8 \
	python \
	r-base \
	regina-rexx \
	ruby2.1 \
	slsh \
	spl-core \
	tcc

# mlton,
# make unzip cmake gcc g++ gdc libgd2-xpm-dev groff

COPY . ./
