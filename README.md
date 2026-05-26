# Robotics-ai setup

## Setup Instructions

### 1. Clone and apply patch

```bash

$ git clone git clone https://github.com/haochuan1982/edge-developer-kit-reference-scripts-patch.git
$ cd edge-developer-kit-reference-scripts-patch
$ git submodule update --init edge-developer-kit-reference-scripts
$ cd edge-developer-kit-reference-scripts
$ git am ../patch/*.patch
```

### 2. Docker image build and run

```bash
$ docker build  -t robotic-ai:latest  .

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
  -p 8080:8080 \
  robotic-ai:latest \
  bash -c start.sh
```
