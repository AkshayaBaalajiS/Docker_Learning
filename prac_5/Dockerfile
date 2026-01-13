FROM ubuntu:22.04

RUN apt update && apt install -y cmake g++ 

WORKDIR /work 

COPY . .

RUN bash script_to_generate.sh

RUN mkdir prac_7/build/ && cd prac_7/build/ && cmake .. && make 

CMD ["./prac_7/build/app/output"]