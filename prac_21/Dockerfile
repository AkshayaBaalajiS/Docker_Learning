FROM ubuntu:22.04

RUN apt update && \
	apt install -y cmake g++ 

WORKDIR /work

COPY . .

ENV USER=Akshaya_Baalaji

ARG FOL=${USER}

ARG MODEE=TCP

ENV FOLDER=${FOL}

RUN bash script.sh 

WORKDIR /work/${FOLDER}

RUN mkdir build

WORKDIR /work/${FOLDER}/build

RUN cmake -DMODE=${MODEE} .. && make 

WORKDIR /work/${FOLDER}/build/output

CMD ["./server"]