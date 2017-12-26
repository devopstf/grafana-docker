![Grafana](https://i.imgur.com/7sHvVLx.png)

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
- *make run-persistence*
- *make run-no-detach*
- *make logs*
- *make inspect*

You can check what exactly each of these functions do in the *makefile*.

Build and run parameters can be modified on the makefile, so set up your installation as you like.

### Persist Grafana data
Just use the make function '*make run-persistence*'. Using the variables defines in the makefile, it'll set up the volume below '*/var/lib/docker/volumes/**volume-name**/_data*' and docker itself will fill the host share with what's inside the docker container. Make sure the volume-name is not already created in /var/lib/docker/volumes or it won't work!
