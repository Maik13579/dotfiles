#/bin/bash
# Icon to differentiate between ros container and host
export ROS_LOGO="🤖 ROS_1 |"

# Set ROS IP
refresh_ip(){
	IP_ADDR=$(ifconfig | grep -o "192.168.[1-9]*.[1-9]*" | head -1)
	export ROS_IP=$IP_ADDR
	export ROS_HOSTNAME=$IP_ADDR
}

export ROS_IP=127.0.0.1
export ROS_HOSTNAME=127.0.0.1
export ROS_MASTER_URI=http://127.0.0.1:11311

# Run container with ROS noetic and mount current directory
ros(){
    CURRENT_DIR=$(pwd)
    docker run --rm -it \
    --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY \
    -e ROS_MASTER_URI\
    -e ROS_IP\
    -e ROS_HOSTNAME\
    --net=host \
    -v ${CURRENT_DIR}:${CURRENT_DIR} \
    fbe-dockerreg.rwu.de/prj-iki-robotics/orga/ros-docker-base:noetic_clean \
    bash -c \
        "echo 'source /opt/ros/noetic/setup.bash' >> /root/.bashrc &&\
        echo 'PS1=\"${ROS_LOGO} \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]\"' >> /root/.bashrc &&\
        cd ${CURRENT_DIR}
        bash"
}

# Start a roscore
roscore(){
    docker run --rm -it \
    --privileged \
    --name roscore \
    --net=host \
    -e ROS_MASTER_URI\
    -e ROS_IP\
    -e ROS_HOSTNAME\
    -e WAIT_FOR_ROSCORE=0\
    fbe-dockerreg.rwu.de/prj-iki-robotics/orga/ros-docker-base:noetic_clean \
    roscore
}


#Start rviz and mount config directory
rviz(){
    docker run --rm -it \
    --privileged \
    --name rviz \
    --net=host \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY \
    -e ROS_MASTER_URI \
    -e ROS_IP \
    -e ROS_HOSTNAME \
    -v $HOME/.config/rviz:/opt/ros/noetic/share/rviz/config \
    fbe-dockerreg.rwu.de/prj-iki-robotics/orga/ros-docker-base:noetic_clean \
    rviz
}