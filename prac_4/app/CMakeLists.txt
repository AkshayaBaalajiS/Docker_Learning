add_executable(output main.cpp)

set_target_properties(output PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${SOURCE_DIR}/build)

target_link_libraries(output utils)