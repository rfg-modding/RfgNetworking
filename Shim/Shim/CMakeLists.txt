
# Make sure cmake doesn't add the build config name to the end of built DLLs (eg. Host_debug.dll instead of Host.dll)
set(CMAKE_DEBUG_POSTFIX "")
set(CMAKE_RELEASE_POSTFIX "")
set(CMAKE_RELWITHDEBINFO_POSTFIX "")

# Add source to this project's executable.
add_library (sw_api SHARED "sw_api.cpp" "sw_api.h")

if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET sw_api PROPERTY CXX_STANDARD 20)
endif()

# TODO: Add tests and install targets if needed.
