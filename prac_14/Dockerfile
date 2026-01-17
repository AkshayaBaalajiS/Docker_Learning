FROM ubuntu:22.04

RUN apt update && apt install -y cmake g++

WORKDIR /work 

COPY . . 

RUN bash  script.sh

RUN mkdir prac_9/build && cd prac_9/build && cmake .. && make 

RUN cd prac_9/build

CMD ["./prac_9/build/output"]
#Docker file does not support single quote