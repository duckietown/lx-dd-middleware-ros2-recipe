<p align="center">
<a href="https://duckietown.com"><img src="https://raw.githubusercontent.com/duckietown/lx-dd-middleware-ros2/ente/assets/images/dtlogo.png" alt="Duckietown Logo" width="50%"></a>
</p>

# Recipe: ROS2 Middleware LX

This is the recipe for the [`lx-dd-middleware-ros2`](https://github.com/duckietown/lx-dd-middleware-ros2)
Learning Experience. It holds everything the learner never sees: the Docker images, the
dependencies, and the launcher.

Learners do not clone this repository. The Duckietown Shell pulls it automatically, because
`lx-dd-middleware-ros2/.dtproject` points at it:

    RECIPE_REPOSITORY=duckietown/lx-dd-middleware-ros2-recipe
    RECIPE_BRANCH=ente

## What is here

| Path | Purpose |
| --- | --- |
| `Dockerfile` | image that runs the LX code on a Duckiedrone |
| `Dockerfile.vscode` | image behind `dts code editor`, the browser editor the learner works in |
| `dependencies-apt.txt`, `dependencies-py3.txt` | runtime APT packages and Python packages shared by both images |
| `dependencies-apt.vscode.txt` | ROS 2 and colcon APT packages for the editor image |
| `launchers/default.sh` | what runs when the LX container starts |
| `settings.yaml` | Duckiematrix map and vehicle used by `dts code start_matrix` |
| `assets/vscode/setup.sh` | code-server settings, ROS-enabled terminals, and writable build directories |
| `packages/` | instructor-only code, hidden from the learner |

## Browser-terminal environment

The editor image uses Ubuntu 24.04 (Noble) with ROS 2 Jazzy. Its Dockerfile installs
the official ROS 2 APT-source package before the editor dependencies and checks
that the base image is still Noble.

New Bash terminals load ROS 2 and, when present, the built workspace overlay.
The image sets `ROS2_DISTRO=jazzy`, `COLCON_WS=/code`, and `ROS_DOMAIN_ID=42`.
The editor user can write to `/code/build`, `/code/install`, and `/code/log`;
the LX source is mounted below `/code/src`.

To test local recipe changes, check out this repository beside the LX repository
and run this command from the LX directory. It rebuilds and opens the editor
using the local recipe instead of the remote recipe branch:

    dts code editor --recipe ../lx-dd-middleware-ros2-recipe

In the browser editor, choose **Terminal > New Terminal** and check the local
interface and package workflow:

    ros2 interface show sensor_msgs/msg/CompressedImage
    ros2 interface show sensor_msgs/msg/Imu
    cd "$COLCON_WS"
    colcon list
    colcon build --packages-select ros2_pubsub
    source install/setup.bash
    ros2 pkg executables ros2_pubsub

Open another terminal to check that it finds the built package automatically.
Terminals already open before a build still need to source `install/setup.bash`.
