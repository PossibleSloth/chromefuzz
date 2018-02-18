FROM ubuntu:14.04

RUN mkdir /opt/app
WORKDIR /opt/app

RUN apt-get update && apt-get install -y \
    git \
    curl \
    python

RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

ENV PATH="${PATH}:/opt/app/depot_tools"

RUN mkdir /opt/app/chromium && cd /opt/app/chromium && fetch --nohooks --no-history chromium

RUN apt-get install -y \
    g++

RUN cd chromium/src && build/install-build-deps.sh --no-prompt

RUN cd chromium/src && gclient runhooks

RUN cd chromium/src && gn gen out/libfuzzer '--args=use_libfuzzer=true is_asan=true is_debug=false enable_nacl=false' --check

ADD . /opt/app/chromium/src/chromefuzz



# RUN mkdir /opt/afl && cd /opt/afl && wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz && tar xvzf afl-latest.tgz && cd afl-2.52b && make

