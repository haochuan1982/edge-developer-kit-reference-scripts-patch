# Robotics AI Setup

## Setup Instructions

### Prerequisites

- Ubuntu 24.04.4 or later with Docker installed
- RealSense camera working properly (verify with `realsense-viewer` tool)
- LeRobot controller detected at `/dev/ttyACM0` (verify with the command below)

```bash
$ ls /dev/ttyACM0
```

### 1. Download source code and pull Docker image

```bash
$ git clone https://github.com/haochuan1982/edge-developer-kit-reference-scripts-patch.git
$ cd edge-developer-kit-reference-scripts-patch

$ docker pull chenhaochuan82/robotic-ai:latest
```

### 2. Launch the container

```bash
$ export ROBOT_AI_DIR=/opt/edge-developer-kit-reference-scripts/usecases/ai/edge-ai-demo-studio/workers/robotics-ai

$ docker run -it --rm \
  --device /dev/dri/card1 \
  --device /dev/dri/renderD128 \
  --device /dev/video0 \
  --device /dev/video1 \
  --device /dev/video2 \
  --device /dev/video3 \
  --device /dev/video4 \
  --device /dev/video5 \
  --device /dev/accel/accel0 \
  --device /dev/ttyACM0 \
  --group-add video \
  --group-add render \
  --group-add plugdev \
  -v $PWD/calibration:/root/.cache/huggingface/lerobot/calibration \
  -v $PWD/config.yaml:$ROBOT_AI_DIR/config.yaml \
  -p 8080:8080 \
  chenhaochuan82/robotic-ai:latest \
  bash -c "start.sh"
```

### 3. Open your browser and navigate to http://localhost:8080

![Dashboard](image/dashboard.png)

### 4. Start the Robotics AI sample

Once the dashboard loads, navigate to the "Samples" section in the sidebar and select "Robotics AI". Then click the "Start Required" button to initialize and launch the robotics AI application. Wait for a while as the service starts up. Once the service is fully launched, click the "Launch Demo" button to open the robotics AI demo interface.

![Launch Demo](image/launch-demo.png)

### 5. Configure and test the robot

In the Robotics AI interface, select robot type "SO-ARM101" from the robot selection dropdown. Then click the "Reload Camera" button to initialize the camera feed. To verify that everything is working correctly, test the AI Chat Assistant by saying "Hello" and confirming you receive a response.

![Hello Demo](image/hello.png)

### 6. Calibrate the robot (First-time setup only)

For the first-time setup, you need to calibrate both the LeRobot arm and the camera. Start with the arm calibration:

1. Navigate to the "Calibrate Guide" section in the interface
2. Click "Start Motor Calibrate"
3. Select "Run new calibration"
4. Follow the calibration video instructions shown in the prompt link above to complete the one-time arm calibration process

### 7. Calibrate the camera

After completing the arm calibration, proceed with camera calibration. Click the "Start Detection" button and ensure that both the plate and the red block are positioned in the center of the camera preview window.

![Camera Calibration](image/camera-calibration.png)

### 8. Control the robot with AI Chat Assistant

Now you're ready to control the robot! Use the AI Chat Assistant to command the robot arm. For example, ask it to pick up the object on the plate inside the red block. Simply type or speak your command, and the robot will execute the task.

## Tips

### If you get Docker image by sharing, concat by this command

```bash
$ cat robotic-ai-20260529.tar.0* > robotic-ai-20260529.tar
$ docker load -i robotic-ai-20260529.tar
```

### If you want to build the Docker image

```bash
$ git clone https://github.com/haochuan1982/edge-developer-kit-reference-scripts-patch.git
$ cd edge-developer-kit-reference-scripts-patch
$ git submodule update --init edge-developer-kit-reference-scripts
$ cd edge-developer-kit-reference-scripts
$ git am ../patch/*.patch
$ cd ..
$ docker build -t robotic-ai .
```
