# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
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
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build

# Include any dependencies generated for this target.
include force_unroll/CMakeFiles/LLVMHW2.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include force_unroll/CMakeFiles/LLVMHW2.dir/compiler_depend.make

# Include the progress variables for this target.
include force_unroll/CMakeFiles/LLVMHW2.dir/progress.make

# Include the compile flags for this target's objects.
include force_unroll/CMakeFiles/LLVMHW2.dir/flags.make

force_unroll/CMakeFiles/LLVMHW2.dir/force_unroll.cpp.o: force_unroll/CMakeFiles/LLVMHW2.dir/flags.make
force_unroll/CMakeFiles/LLVMHW2.dir/force_unroll.cpp.o: ../force_unroll/force_unroll.cpp
force_unroll/CMakeFiles/LLVMHW2.dir/force_unroll.cpp.o: force_unroll/CMakeFiles/LLVMHW2.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object force_unroll/CMakeFiles/LLVMHW2.dir/force_unroll.cpp.o"
	cd /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build/force_unroll && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT force_unroll/CMakeFiles/LLVMHW2.dir/force_unroll.cpp.o -MF CMakeFiles/LLVMHW2.dir/force_unroll.cpp.o.d -o CMakeFiles/LLVMHW2.dir/force_unroll.cpp.o -c /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/force_unroll/force_unroll.cpp

force_unroll/CMakeFiles/LLVMHW2.dir/force_unroll.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LLVMHW2.dir/force_unroll.cpp.i"
	cd /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build/force_unroll && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/force_unroll/force_unroll.cpp > CMakeFiles/LLVMHW2.dir/force_unroll.cpp.i

force_unroll/CMakeFiles/LLVMHW2.dir/force_unroll.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LLVMHW2.dir/force_unroll.cpp.s"
	cd /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build/force_unroll && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/force_unroll/force_unroll.cpp -o CMakeFiles/LLVMHW2.dir/force_unroll.cpp.s

# Object files for target LLVMHW2
LLVMHW2_OBJECTS = \
"CMakeFiles/LLVMHW2.dir/force_unroll.cpp.o"

# External object files for target LLVMHW2
LLVMHW2_EXTERNAL_OBJECTS =

force_unroll/LLVMHW2.so: force_unroll/CMakeFiles/LLVMHW2.dir/force_unroll.cpp.o
force_unroll/LLVMHW2.so: force_unroll/CMakeFiles/LLVMHW2.dir/build.make
force_unroll/LLVMHW2.so: force_unroll/CMakeFiles/LLVMHW2.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared module LLVMHW2.so"
	cd /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build/force_unroll && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/LLVMHW2.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
force_unroll/CMakeFiles/LLVMHW2.dir/build: force_unroll/LLVMHW2.so
.PHONY : force_unroll/CMakeFiles/LLVMHW2.dir/build

force_unroll/CMakeFiles/LLVMHW2.dir/clean:
	cd /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build/force_unroll && $(CMAKE_COMMAND) -P CMakeFiles/LLVMHW2.dir/cmake_clean.cmake
.PHONY : force_unroll/CMakeFiles/LLVMHW2.dir/clean

force_unroll/CMakeFiles/LLVMHW2.dir/depend:
	cd /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/force_unroll /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build/force_unroll /n/eecs583a/home/lanbas/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build/force_unroll/CMakeFiles/LLVMHW2.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : force_unroll/CMakeFiles/LLVMHW2.dir/depend

