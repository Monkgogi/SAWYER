
FROM ros:kinetic

# Set non-interactive frontend
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    curl \
    lsb-release \
    gnupg2 \
    software-properties-common \
    python-rosdep \
    python-wstool \
    python-vcstools \
    python-argparse \
    ros-kinetic-catkin \
    ros-kinetic-xacro \
    ros-kinetic-rviz \
    ros-kinetic-tf2-ros \
    ros-kinetic-cv-bridge \
    ros-kinetic-control-msgs \
    ros-kinetic-joystick-drivers \
    ros-kinetic-actionlib \
    ros-kinetic-actionlib-msgs \
    ros-kinetic-dynamic-reconfigure \
    ros-kinetic-trajectory-msgs \
    ros-kinetic-rospy-message-converter \
    && rm -rf /var/lib/apt/lists/*

# Setup ROS environment
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

# Create catkin workspace
WORKDIR /root/catkin_ws
RUN mkdir -p src && \
    bash -c "source /opt/ros/kinetic/setup.bash && cd /root/catkin_ws && catkin_make"



# Add sawyer_robot and intera_common manually
RUN git clone https://github.com/RethinkRobotics/sawyer_robot.git /root/catkin_ws/src/sawyer_robot

# Create a manual rosinstall file for intera_common
RUN printf '%s\n' \
    "- git:" \
    "    local-name: intera_common" \
    "    uri: https://github.com/RethinkRobotics/intera_common.git" \
    "    version: master" > /root/catkin_ws/src/sawyer.rosinstall

# Use wstool to init and update
RUN cd /root/catkin_ws && \
    wstool init src /root/catkin_ws/src/sawyer.rosinstall && \
    wstool update -t src


RUN git clone https://github.com/RethinkRobotics/intera_sdk.git /root/catkin_ws/src/intera_sdk
# Setup rosdep and install dependencies
RUN rosdep update && \
    rosdep install --from-paths src --ignore-src -r -y

# Final build
RUN bash -c "source /opt/ros/kinetic/setup.bash && cd /root/catkin_ws && catkin_make"

RUN apt-get update && apt-get install -y net-tools \
    nano \
    vim \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

RUN cp /root/catkin_ws/src/intera_sdk/intera.sh /root/catkin_ws/





# Default shell
CMD ["bash"]
