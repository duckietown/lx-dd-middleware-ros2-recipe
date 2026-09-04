#!/bin/bash

source /environment.sh

# initialize launch file
dt-launchfile-init

# YOUR CODE BELOW THIS LINE
# ----------------------------------------------------------------------------

# NOTE: Use the variable DT_PROJECT_PATH to know the absolute path to your code
# NOTE: Use `dt-exec COMMAND` to run the main process (blocking process)

# set module's health
dt-set-module-healthy

# source ROS2 workspace
source /opt/ros/${ROS2_DISTRO}/setup.bash
source ${COLCON_WS}/install/setup.bash --extend

# TODO: launch the LX node here, if this LX ever ships one

# ----------------------------------------------------------------------------
# YOUR CODE ABOVE THIS LINE

# wait for app to end
dt-launchfile-join
