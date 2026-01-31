FROM ubuntu:22.04

RUN apt update && apt install -y cmake g++ 

ENV user=AkshayaBaalaji

ARG FOLDER=${user}

WORKDIR /${user}

COPY . . 

RUN mkdir build 

WORKDIR /${user}/build

RUN cmake .. & make 

CMD ["./output/server"]
