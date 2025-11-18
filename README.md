# SAWYER
HOW-TO

This repo will be used to set up communication with the Sawyer robot through Docker.
useful links: https://web.archive.org/web/20171018072342/http://sdk.rethinkrobotics.com/intera/Main_Page <br />

In the Docker shell, edit the intera.sh file via nano. Change the ros_hostname to the robot's IP address and your_ip to your pc IP address. Save the file. <br />


# Docker Commands
docker build -t sawyer_moveit .

docker run -it --net=host --env DISPLAY=$DISPLAY --env QT_11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix sawyer_moveit:latest

Once in the docker container, open the shell script, intera.sh: nano *intera.sh*. Change the *robot_hostname* to the robot ip and change *your_ip* to you computer's ip. Save and close the shell script and source the script, *source ./intera.sh*.

To test if the ROS communication is working, use this command *rostopic list*
