#!/bin/bash

PROJECT=${FOLDER}

echo "THis is the Whole CPP + CMAKE + Docker Thing created for learning"

mkdir -p ${PROJECT}/{include,app,lib}

cat<<EOF>${PROJECT}/lib/header.cpp
#include "header.hpp"
using namespace std;

void Structure::func()
{
	cout<<"@void Structure::func()\n";
}
EOF

cat<<'EOF'> ${PROJECT}/lib/CMakeLists.txt
add_library(header SHARED header.cpp)

set_target_properties(header PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${LIB_DIR})

target_include_directories(header PUBLIC ${INC_DIR})

if(TCP)
target_compile_definitions(header PUBLIC TCP)
else()
target_compile_definitions(header PUBLIC UDP)
endif()
EOF

cat<<'EOF' > ${PROJECT}/CMakeLists.txt
cmake_minimum_required(VERSION 3.19)

project(CMAKE_PRAC20)

set(INC_DIR ${CMAKE_SOURCE_DIR}/include)

file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/build/output)
file(MAKE_DIRECTORY ${CMAKE_SOURCE_DIR}/build/library)

file(GLOB LIB_DIR ${CMAKE_SOURCE_DIR}/build/library)
set(OUTPUT_DIR ${CMAKE_SOURCE_DIR}/build/output)

set(MODE "UDP" CACHE STRING "Default UDP provided")

if(MODE STREQUAL TCP)
option(TCP "TCP Turned ON  "  ON)
else()
option(TCP "TCP turned OFF" OFF)
endif()

add_subdirectory(lib)

add_subdirectory(app)
EOF

cat<<EOF > ${PROJECT}/app/server.cpp
#include <iostream>
#include <arpa/inet.h>
#include <sys/wait.h>
#include "header.hpp"

using namespace std;

int main()
{
	#ifdef TCP
	cout<<"Socket IPv4 TCP  \n";
	#else
	cout<<"Socket IPv4 UDP \n";
	#endif

	#ifdef TCP
	int serverDesc = socket(AF_INET, SOCK_STREAM, 0);
	#else
	int serverDesc = socket(AF_INET, SOCK_DGRAM, 0);
	#endif
	
	sockaddr_in serverDet;
	serverDet.sin_port = htons(8080);
	serverDet.sin_addr.s_addr = INADDR_ANY;
	serverDet.sin_family = AF_INET;

	bind(serverDesc, (sockaddr *)(&serverDet), sizeof(serverDet));

	listen(serverDesc, 10);

	#ifdef TCP
	int clientDes = accept(serverDesc, nullptr, nullptr);
	#endif


	void * ptr = (void *)sizeof(1000);
	int arr[23];

	Structure * Obj = new Structure();

	#ifdef TCP
	recv(clientDes,Obj, sizeof(*Obj),0);
	#else
	socklen_t clientSize = sizeof(serverDet);
	recvfrom(serverDesc,Obj, sizeof(*Obj), 0, (struct sockaddr  *)(&serverDet),&clientSize);
	#endif

	cout<<"Data ----------------------\n";
	cout<<(*Obj).arr[0] << " " <<(*Obj).arr[1] << " " <<(*Obj).arr[2] << " " <<(*Obj).arr[3] << " " <<(*Obj).arr[4] << " " <<(*Obj).arr[5] << " " <<(*Obj).arr[6] << " " <<(*Obj).arr[7] << endl;// 
	cout<<"----------------------------\n";

	close(serverDesc);
}
EOF

cat<<EOF > ${PROJECT}/app/client.cpp
#include <iostream>
#include "header.hpp"
#include <arpa/inet.h>

using namespace std;

int main()
{
	#ifdef TCP
	cout<<"Client side of socket TCP  \n";
	#else
	cout<<"Client side of socket  UDP \n";
	#endif	

	#ifdef TCP
	int clientDes = socket(AF_INET, SOCK_STREAM, 0);
	#else 
	int clientDes = socket(AF_INET, SOCK_DGRAM, 0);
	#endif

	sockaddr_in clientDet ;
	clientDet.sin_port = htons(8080);
	clientDet.sin_addr.s_addr = inet_addr("127.0.0.1");
	clientDet.sin_family = AF_INET ;
	
	connect(clientDes, (sockaddr *)(&clientDet), sizeof(clientDet));

	int * ptr = new int[100];
	
	
	Structure * Obj = new Structure();
	(*Obj).arr[0] = 12;
	(*Obj).arr[1] = 23;
	(*Obj).arr[2] = 34;
	(*Obj).arr[3] = 45;
	(*Obj).arr[4] = 56;
	(*Obj).arr[5] = 67;
	(*Obj).arr[6] = 78;
	(*Obj).arr[7] = 89;

	#ifdef TCP
	send(clientDes, Obj , sizeof(*Obj),0);
	#else
	socklen_t clientSize  = sizeof(clientDet);
	sendto(clientDes, Obj , sizeof(*Obj),0, (sockaddr *)(&clientDet), clientSize);
	#endif	


}
EOF

cat<<'EOF' > ${PROJECT}/app/CMakeLists.txt
add_executable(server server.cpp)
add_executable(client client.cpp)

set_target_properties(server PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR})
set_target_properties(client PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR})

target_link_libraries(server PRIVATE header)
target_link_libraries(client PRIVATE header) 

# we are not including the macro or the iclude dir cause we re including ghe lib where all get defined 
EOF

cat<<EOF > ${PROJECT}/include/header.hpp
#include <iostream>

struct Structure
{
	int arr[100];
	void func();
};
EOF

echo "This is our own script where we have done #!/bin/bash"
echo "#! -- shebang : tell which interpreter should run this script"
echo "Without shebang ./script.sh will not have idea which to run "
echo "If we are doing explicitly then it is fine without shebang like bash script.sh"
