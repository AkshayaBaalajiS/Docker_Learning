FROM ubuntu:22.04

RUN apt update && apt install -y cmake g++ 


ARG EENABLE_LOG=OFF
ARG EMODE=SLOW


ENV USER=Baalaji
#lower case variable on docker as env variable is risky

#ENV FOLDER=$USER
#this is not using the user rather it created the fodler user 

ENV FOLDER=${USER}

WORKDIR /work

COPY . .

RUN bash script_11.sh

# the belw Sim to mkdir build && cd build 
WORKDIR /work/${FOLDER}/build 
RUN cmake -DMODE=${EMODE} -DENABLE_LOG=${EENABLE_LOG} .. && make 

WORKDIR /work/${FOLDER}/build/output

CMD ["./output"]