# Grafana Monitoring Dashboards - CentOS 7 Container
Do you want to have your own Grafana Docker Container over CentOS7? With this project, you'll be able to build and run your image in short time and update it with newer versions anytime!

## Installation Guidelines
Once you have this project downloaded in your workspace, you're off to start building your image! Just make sure you modify the '*makefile*' parameters to match the Grafana version you need, and then we'll be able to begin.

### Pre-requisites
Before building the image, you'll need this (if you don't plan on typing the commands by yourself!):
- [Docker](https://www.docker.com/get-docker) (of course!)
- [Make](https://www.gnu.org/software/make/)

### Build it with make!
Building and running the image with make will end up on you having more time to spend on working with Grafana!

The makefile in this project features the following functions:
- *make build*
- *make run*

Build and run parameters can be modified on the makefile, so set up your installation as you like!

### Set up persistence on host
If you're familiar with Docker, you'll already know how difficult is as of right now to share a volume between the container and your host without losing container data in the process.

Yeah, if you set it up with *-v /host/path* docker volumes will generate the volume and populate it with container's path content, but it won't help you much in concurrent re-runs. 

In order to solve this, here's an idea, setting up an script (which can be, easily, a make function!):
- Run the container without sharing a volume.
- Run 'docker cp' with the container name, dumping the data in the container to the host machine.
- Stop and remove the container, and then re-run it with the volume sharing.

You'll probably will have to set up permission with an user both your host and container share, but it'll solve the problem.
