set (CMAKE_CXX_STANDARD 11)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_HOME_DIRECTORY}/bin)

add_executable(cocoa_key_events main.mm)

FIND_LIBRARY(COCOA_LIBRARY Cocoa)
target_link_libraries(cocoa_key_events ${COCOA_LIBRARY})
