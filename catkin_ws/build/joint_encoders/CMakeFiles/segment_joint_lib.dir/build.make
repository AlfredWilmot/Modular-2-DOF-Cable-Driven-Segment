# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

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
CMAKE_SOURCE_DIR = /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/build

# Include any dependencies generated for this target.
include joint_encoders/CMakeFiles/segment_joint_lib.dir/depend.make

# Include the progress variables for this target.
include joint_encoders/CMakeFiles/segment_joint_lib.dir/progress.make

# Include the compile flags for this target's objects.
include joint_encoders/CMakeFiles/segment_joint_lib.dir/flags.make

joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o: joint_encoders/CMakeFiles/segment_joint_lib.dir/flags.make
joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o: /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/src/joint_encoders/src/publish_segment_joint_values.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o"
	cd /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/build/joint_encoders && /usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o -c /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/src/joint_encoders/src/publish_segment_joint_values.cpp

joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.i"
	cd /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/build/joint_encoders && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/src/joint_encoders/src/publish_segment_joint_values.cpp > CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.i

joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.s"
	cd /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/build/joint_encoders && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/src/joint_encoders/src/publish_segment_joint_values.cpp -o CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.s

joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o.requires:

.PHONY : joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o.requires

joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o.provides: joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o.requires
	$(MAKE) -f joint_encoders/CMakeFiles/segment_joint_lib.dir/build.make joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o.provides.build
.PHONY : joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o.provides

joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o.provides.build: joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o


# Object files for target segment_joint_lib
segment_joint_lib_OBJECTS = \
"CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o"

# External object files for target segment_joint_lib
segment_joint_lib_EXTERNAL_OBJECTS =

/home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/devel/lib/libsegment_joint_lib.so: joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o
/home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/devel/lib/libsegment_joint_lib.so: joint_encoders/CMakeFiles/segment_joint_lib.dir/build.make
/home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/devel/lib/libsegment_joint_lib.so: joint_encoders/CMakeFiles/segment_joint_lib.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared library /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/devel/lib/libsegment_joint_lib.so"
	cd /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/build/joint_encoders && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/segment_joint_lib.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
joint_encoders/CMakeFiles/segment_joint_lib.dir/build: /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/devel/lib/libsegment_joint_lib.so

.PHONY : joint_encoders/CMakeFiles/segment_joint_lib.dir/build

joint_encoders/CMakeFiles/segment_joint_lib.dir/requires: joint_encoders/CMakeFiles/segment_joint_lib.dir/src/publish_segment_joint_values.cpp.o.requires

.PHONY : joint_encoders/CMakeFiles/segment_joint_lib.dir/requires

joint_encoders/CMakeFiles/segment_joint_lib.dir/clean:
	cd /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/build/joint_encoders && $(CMAKE_COMMAND) -P CMakeFiles/segment_joint_lib.dir/cmake_clean.cmake
.PHONY : joint_encoders/CMakeFiles/segment_joint_lib.dir/clean

joint_encoders/CMakeFiles/segment_joint_lib.dir/depend:
	cd /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/src /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/src/joint_encoders /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/build /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/build/joint_encoders /home/alfie/Desktop/Modular-2-DOF-Cable-Driven-Segment/catkin_ws/build/joint_encoders/CMakeFiles/segment_joint_lib.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : joint_encoders/CMakeFiles/segment_joint_lib.dir/depend
