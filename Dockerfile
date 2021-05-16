FROM alpine

RUN apk update
RUN apk add \
    cmake \
    make \
    g++ \
    git \
    python3

RUN mkdir -p /root/code/
WORKDIR /root/code/


RUN git clone https://github.com/Z3Prover/z3.git z3
WORKDIR /root/code/z3
RUN git checkout z3-4.8.10

RUN git clean -nx src
RUN git clean -fx src

RUN mkdir build
WORKDIR /root/code/z3/build
RUN cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release ../

RUN make
RUN make install

RUN cp /root/code/z3/LICENSE.txt /usr/local/bin/z3-LICENSE.txt
RUN rm -rf /root/code
RUN z3 --version
