FROM ubuntu:22.04

RUN apt update && apt install -y cmake g++

WORKDIR /home/akshay

COPY . .

RUN cd /home/akshay 

RUN mkdir build && cd build	&& cmake .. && make

CMD ["./output"] 