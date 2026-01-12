FROM ubuntu:22.04

# the below line is noon interactive else the build stop at the -y error 
#RUN apt update && apt install -y cmake && apt install g++ 

RUN apt update && apt install -y cmake g++ 


WORKDIR /work 

COPY . . 

RUN mkdir build && cd build && cmake .. && make 

CMD ["./build/output"]