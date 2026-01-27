FROM ubuntu:22.04

RUN apt update && apt install -y cmake g++ 

ENV user=Baalaji

ENV ALGO_MODE=RELEASE_MODE

WORKDIR /work

COPY . .

RUN bash setup_prac_13.sh

RUN cd $user && mkdir build && cd build && cmake -DALGO_MODE=$ALGO_MODE .. && make 

CMD ["./Baalaji/build/output/output"]