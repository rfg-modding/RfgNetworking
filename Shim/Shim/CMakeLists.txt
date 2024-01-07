
# Make sure cmake doesn't add the build config name to the end of built DLLs (eg. Host_debug.dll instead of Host.dll)
set(CMAKE_DEBUG_POSTFIX "")
set(CMAKE_RELEASE_POSTFIX "")
set(CMAKE_RELWITHDEBINFO_POSTFIX "")

# Add source to this project's executable.
add_library(sw_api SHARED "sw_api.cpp" "IBackend.h" "Typedefs.h" "Backend/Debug/DebugBackend.h" "Backend/Debug/DebugBackend.cpp" "Backend/IPC/IPCBackend.h" "Backend/IPC/IPCBackend.cpp" "Backend/BackendData.h")

# Make cmake output sw_api.dll to the RFGR directory
set_target_properties(sw_api
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${RFGR_DIRECTORY}"
    LIBRARY_OUTPUT_DIRECTORY "${RFGR_DIRECTORY}"
    RUNTIME_OUTPUT_DIRECTORY "${RFGR_DIRECTORY}"
)

target_include_directories(sw_api SYSTEM PRIVATE
    ${CMAKE_SOURCE_DIR}/Shim/
)

set_property(TARGET sw_api PROPERTY CXX_STANDARD 23)