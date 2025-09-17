FROM ubuntu:22.04

RUN apt update && apt install -y cmake g++ 

WORKDIR /home/akshay

COPY . .

RUN mkdir build && cd build && cmake .. && make 

CMD ["./build/pipe_out"]