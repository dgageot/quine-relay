FROM quine/base

RUN apt-get update -qq && apt-get install -y llvm

COPY . ./