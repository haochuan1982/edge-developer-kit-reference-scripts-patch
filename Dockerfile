FROM ubuntu:24.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG NO_PROXY

# Configure APT proxy settings
#RUN echo 'Acquire::http::Proxy "<your proxy>";' > /etc/apt/apt.conf && \
#    echo 'Acquire::https::Proxy "<your proxy>";' >> /etc/apt/apt.conf

# Update package lists
RUN apt-get update
RUN apt-get install -y zip curl vim iproute2
RUN apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

# Copy edge-developer-kit-reference-scripts to /opt/edge-developer-kit-reference-scripts
COPY edge-developer-kit-reference-scripts /opt/edge-developer-kit-reference-scripts
COPY assets /opt/edge-developer-kit-reference-scripts/usecases/ai/edge-ai-demo-studio/workers/robotics-ai/platforms/so101/urdf/assets/

# for prc, add huggingface mirror or copy the pre-downloaded model
ENV HF_ENDPOINT=https://hf-mirror.com
ENV PATH="/opt/edge-developer-kit-reference-scripts/usecases/ai/edge-ai-demo-studio:${PATH}"

# Run installation and setup scripts
RUN install_dependencies.sh -y
RUN setup.sh -v

# Default command
CMD ["/bin/bash"]
