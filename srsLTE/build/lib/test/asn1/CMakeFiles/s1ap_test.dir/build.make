# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/monitorgsm/srsLTE

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/monitorgsm/srsLTE/build

# Include any dependencies generated for this target.
include lib/test/asn1/CMakeFiles/s1ap_test.dir/depend.make

# Include the progress variables for this target.
include lib/test/asn1/CMakeFiles/s1ap_test.dir/progress.make

# Include the compile flags for this target's objects.
include lib/test/asn1/CMakeFiles/s1ap_test.dir/flags.make

lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.o: lib/test/asn1/CMakeFiles/s1ap_test.dir/flags.make
lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.o: ../lib/test/asn1/s1ap_test.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/monitorgsm/srsLTE/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.o"
	cd /home/monitorgsm/srsLTE/build/lib/test/asn1 && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/s1ap_test.dir/s1ap_test.cc.o -c /home/monitorgsm/srsLTE/lib/test/asn1/s1ap_test.cc

lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/s1ap_test.dir/s1ap_test.cc.i"
	cd /home/monitorgsm/srsLTE/build/lib/test/asn1 && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/monitorgsm/srsLTE/lib/test/asn1/s1ap_test.cc > CMakeFiles/s1ap_test.dir/s1ap_test.cc.i

lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/s1ap_test.dir/s1ap_test.cc.s"
	cd /home/monitorgsm/srsLTE/build/lib/test/asn1 && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/monitorgsm/srsLTE/lib/test/asn1/s1ap_test.cc -o CMakeFiles/s1ap_test.dir/s1ap_test.cc.s

lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.o.requires:

.PHONY : lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.o.requires

lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.o.provides: lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.o.requires
	$(MAKE) -f lib/test/asn1/CMakeFiles/s1ap_test.dir/build.make lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.o.provides.build
.PHONY : lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.o.provides

lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.o.provides.build: lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.o


# Object files for target s1ap_test
s1ap_test_OBJECTS = \
"CMakeFiles/s1ap_test.dir/s1ap_test.cc.o"

# External object files for target s1ap_test
s1ap_test_EXTERNAL_OBJECTS =

lib/test/asn1/s1ap_test: lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.o
lib/test/asn1/s1ap_test: lib/test/asn1/CMakeFiles/s1ap_test.dir/build.make
lib/test/asn1/s1ap_test: lib/src/common/libsrslte_common.a
lib/test/asn1/s1ap_test: lib/src/asn1/libsrslte_asn1.a
lib/test/asn1/s1ap_test: /usr/lib/x86_64-linux-gnu/libmbedcrypto.so
lib/test/asn1/s1ap_test: lib/test/asn1/CMakeFiles/s1ap_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/monitorgsm/srsLTE/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable s1ap_test"
	cd /home/monitorgsm/srsLTE/build/lib/test/asn1 && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/s1ap_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
lib/test/asn1/CMakeFiles/s1ap_test.dir/build: lib/test/asn1/s1ap_test

.PHONY : lib/test/asn1/CMakeFiles/s1ap_test.dir/build

lib/test/asn1/CMakeFiles/s1ap_test.dir/requires: lib/test/asn1/CMakeFiles/s1ap_test.dir/s1ap_test.cc.o.requires

.PHONY : lib/test/asn1/CMakeFiles/s1ap_test.dir/requires

lib/test/asn1/CMakeFiles/s1ap_test.dir/clean:
	cd /home/monitorgsm/srsLTE/build/lib/test/asn1 && $(CMAKE_COMMAND) -P CMakeFiles/s1ap_test.dir/cmake_clean.cmake
.PHONY : lib/test/asn1/CMakeFiles/s1ap_test.dir/clean

lib/test/asn1/CMakeFiles/s1ap_test.dir/depend:
	cd /home/monitorgsm/srsLTE/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/monitorgsm/srsLTE /home/monitorgsm/srsLTE/lib/test/asn1 /home/monitorgsm/srsLTE/build /home/monitorgsm/srsLTE/build/lib/test/asn1 /home/monitorgsm/srsLTE/build/lib/test/asn1/CMakeFiles/s1ap_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : lib/test/asn1/CMakeFiles/s1ap_test.dir/depend

