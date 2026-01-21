FROM ubuntu:22.04

RUN apt update && apt install -y cmake g++ 

ENV user=Baalaji
#lower case variable on docker as env variable is risky

#ENV FOLDER=$user
#this is not using the user rather it created the fodler user 

ENV FOLDER=${user}

WORKDIR /work

COPY . .

RUN bash script_11.sh

RUN cd ${FOLDER} && mkdir build && cd build && cmake .. && make 

CMD ["./Baalaji/build/output/output"]