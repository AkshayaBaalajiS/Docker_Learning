add_library(utils SHARED utils.cpp)

set_target_properties(utils PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${SOURCE_DIR}/build)