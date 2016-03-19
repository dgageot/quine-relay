FROM quine/base

RUN apt-get update -qq && apt-get install -y \
	aplus-fsf \
	asymptote \
	ats-lang-anairiats \
	bash \
	bsdgames \
	bf \
	clisp \
	cmake \
	ecere-sdk \
	f2c \
	falconpl \
	fp-compiler \
	fsharp \
	g++ \
	gambas3-script \
	gauche \
	gawk \
	gcc \
	gdc \
	gforth \
	gfortran \
	ghc \
	ghostscript \
	gnu-smalltalk \
	gobjc \
	gpt \
	gri \
	groff \
	iconx \
	intercal \
	iverilog \
	libgd2-xpm-dev \
	libpng12-dev \
	lisaac \
	llvm \
	make \
	mlton \
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

RUN (curl -sSL https://github.com/mame/quine-relay/archive/86f3b4d17faac3b9626dd35eaaada055e12769fa.tar.gz | tar zx --strip-components 1) \
	&& make -C vendor

COPY . ./
