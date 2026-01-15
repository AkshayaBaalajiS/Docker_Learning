FROM ubuntu:22.04

RUN apt update && apt install -y cmake g++ 

WORKDIR /work 

COPY . . 


ENV user=Akshay

RUN bash script_target_compile_Definitions_1.sh


RUN cd scope_example && mkdir build && cd build && cmake .. && make 

CMD ["./scope_example/build/app/output"]