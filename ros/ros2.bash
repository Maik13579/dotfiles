#/bin/bash
export ROS_DOMAIN_ID=11

# Icon to differentiate between ros container and host
export ROS2_LOGO="🤖 ROS_2 |"

# Run container with ROS and mount current directory
ros2(){
    CURRENT_DIR=$(pwd)
    if [ -n "$1" ]; then
        export ROS_DOMAIN_ID=$1
    fi
    docker run --rm -it \
    --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev/shm:/dev/shm \
    -e DISPLAY \
    -e ROS_DOMAIN_ID\
    --net=host \
    -v ${CURRENT_DIR}:${CURRENT_DIR} \
    fbe-dockerreg.rwu.de/prj-iki/barrob/robots/dumper/dumper-base \
    bash -c \
        "echo 'source /opt/ros/humble/setup.bash' >> /root/.bashrc &&\
        echo 'PS1=\"${ROS2_LOGO} \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]\"' >> /root/.bashrc &&\
        cd ${CURRENT_DIR}
        bash"
}

rviz2(){
    if [ -n "$1" ]; then
        export ROS_DOMAIN_ID=$1
    fi
    docker run --rm -it \
    --privileged \
    --name rviz2 \
    --net=host \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev/shm:/dev/shm \
    -e DISPLAY \
    -e ROS_DOMAIN_ID \
    -v $HOME/.config/rviz2:/root/.rviz2 \
    fbe-dockerreg.rwu.de/prj-iki/barrob/robots/dumper/dumper-base \
    rviz2
}

# Set use_sim_time to true for all nodes
ros2_set_sim_time() {
    CURRENT_DIR=$(pwd)
    if [ -n "$1" ]; then
        export ROS_DOMAIN_ID=$1
    fi
    docker run --rm -it \
    --privileged \
    -v /dev/shm:/dev/shm \
    -e ROS_DOMAIN_ID \
    --net=host \
    fbe-dockerreg.rwu.de/prj-iki/barrob/robots/dumper/dumper-base \
    bash -c \
        "source /opt/ros/humble/setup.bash && \
        echo 'ROS2 environment sourced.' && \
        echo 'Listing ROS2 nodes...' && \
        ros2 node list && \
        echo 'Setting use_sim_time parameter...' && \
        NODES=\$(ros2 node list); \
        for node in \$NODES; do \
            echo \"Setting use_sim_time to true for \$node...\"; \
            timeout 1s ros2 param set \"\$node\" use_sim_time true && echo \"Done for \$node\" || echo \"Failed for \$node\"; \
        done"
}