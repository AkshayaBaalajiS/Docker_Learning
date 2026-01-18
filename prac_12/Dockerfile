FROM ubuntu:22.04

RUN apt update && apt install -y cmake g++

WORKDIR /work 

COPY . . 

ENV DIR_NAME=CMAKE
RUN bash script_for_prac.sh



RUN cd ${DIR_NAME} && mkdir build && cd build && cmake .. && make 

CMD ["./CMAKE/build/output"]
#To fix use the crt name of the folder 

#CMD ["./${DIR_NAME}/build/output"]
#Environment variables are NOT expanded in CMD exec form
#Error on execution 