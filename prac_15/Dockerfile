FROM ubuntu:22.04

RUN apt update && apt install -y cmake g++

WORKDIR /work 

COPY . . 

ENV user=Baaalaji

RUN bash setup_prac_12.sh

RUN mkdir prac_12/build && cd prac_12/build && cmake .. && make 

RUN cd prac_12/build

CMD ["./prac_12/build/output/output"]
#Docker file does not support single quote