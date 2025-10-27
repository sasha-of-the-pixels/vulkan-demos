# Credit
Much of the code here (basically, everything needed to display a single rectangle onscreen) is adapted from the official Vulkan tutorial by the Khronos Group.

# What is this?
This is my way of familiarizing myself with Vulkan through practice.

My current goal is to simulate waves in water, as outlined in chapter 1 of *GPU Gems*. This is a work in progress. Currently I just have a few ripples moving about on a plane. I want to add a normal map and other textural elements, orbit controls, and more scenery.

# Installation
Clone the repo and build using CMake. I'm currently compiling the shader using the `makefile`, by running `make shader` (in the source directory).

I'm using the portability enumeration extension because I'm on MacOS, so if the code breaks and you're on a different platform, you could try tweaking lines related to that.