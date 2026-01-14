FROM ubuntu:22.04

RUN apt update && apt install -y cmake g++ 

WORKDIR /work

COPY . . 

RUN bash script_for_8.sh

RUN cd prac_8 && mkdir build && cd build && cmake .. && make 

CMD ["./prac_8/build/app/output"] 