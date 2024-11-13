# Use the official ROS 2 Humble image based on Ubuntu 22.04
FROM ros:humble-ros-base-jammy

# Set environment variables for ROS 2
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV ROS_DISTRO=humble
ENV DEBIAN_FRONTEND=noninteractive
ENV WORKSPACE=/ros_ws

# Install system dependencies for ROS 2 development
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    curl \
    python3-colcon-common-extensions \
    python3-pip \
    python3-rosdep \
    ros-humble-ros-base \
    ros-humble-rqt-common-plugins \
    ros-humble-rviz2 \
    && rm -rf /var/lib/apt/lists/*

# Setup ROS 2 workspace (optional - to include default workspace)
RUN mkdir -p /workspace/src

# Setup ROS 2 environment in the container for bash
SHELL ["/bin/bash", "-c"]
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN echo "source $WORKSPACE/install/setup.bash" >> ~/.bashrc

# Set working directory to /workspace (default ROS 2 workspace)
WORKDIR $WORKSPACE

# Copy source files into workspace
COPY ./src $WORKSPACE/src

# Update dependencies and install
RUN rosdep update && rosdep install --from-paths src -y --ignore-src

RUN source /opt/ros/humble/setup.bash && colcon build

# Expose any ports needed for ROS 2 communication (e.g., for DDS or ROS1 bridge)
EXPOSE 11311

# Default entrypoint, opens a bash shell with ROS 2 environment sourced
ENTRYPOINT ["/bin/bash", "-c", "source /opt/ros/humble/setup.bash && exec bash"]

