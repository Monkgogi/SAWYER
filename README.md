# SAWYER
HOW-TO

This repo will be used to set up communication with the Sawyer robot through Docker.
useful links: https://web.archive.org/web/20171018072342/http://sdk.rethinkrobotics.com/intera/Main_Page <br />

In the Docker shell, edit the intera.sh file via nano. Change the ros_hostname to the robot's IP address and your_ip to your pc IP address. Save the file. <br />

MORE COMING ...

# Docker Commands
docker build -t sawyer_moveit .

docker run -it --net=host --env DISPLAY=$DISPLAY --env QT_11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix sawyer_moveit:latest

