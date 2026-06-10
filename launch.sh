export ROBOT_AI_DIR=/opt/edge-developer-kit-reference-scripts/usecases/ai/edge-ai-demo-studio/workers/robotics-ai

docker run -it --rm \
  --device /dev/dri/card1 \
  --device /dev/dri/renderD128 \
  --device /dev/video32 \
  --device /dev/video33 \
  --device /dev/video34 \
  --device /dev/video35 \
  --device /dev/video36 \
  --device /dev/video37 \
  --device /dev/accel/accel0 \
  --device /dev/ttyACM0 \
  --group-add video \
  --group-add render \
  --group-add plugdev \
  -v $PWD/calibration:/root/.cache/huggingface/lerobot/calibration \
  -v $PWD/config.yaml:$ROBOT_AI_DIR/config.yaml \
  -p 8080:8080 \
  robotic-ai:latest \
  bash -c "start.sh"

