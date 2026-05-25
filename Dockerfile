FROM ubuntu:24.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

#ARG HTTP_PROXY
#ARG HTTPS_PROXY
#ARG NO_PROXY

# Set environment variables for proxy (for non-apt tools)
ENV http_proxy="<your proxy>"
ENV https_proxy="<your proxy>"
ENV no_proxy="<your setting>"

# Configure APT proxy settings
RUN echo 'Acquire::http::Proxy "<your proxy>";' > /etc/apt/apt.conf && \
    echo 'Acquire::https::Proxy "<your proxy>";' >> /etc/apt/apt.conf

# Update package lists
RUN apt-get update
RUN apt-get install -y zip curl vim
RUN apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

# Copy edge-developer-kit-reference-scripts to /opt/edge-developer-kit-reference-scripts
COPY edge-developer-kit-reference-scripts /opt/edge-developer-kit-reference-scripts
COPY assets /opt/edge-developer-kit-reference-scripts/usecases/ai/edge-ai-demo-studio/workers/robotics-ai/platforms/so101/urdf/assets/


# Add proxy settings to ~/.bashrc
RUN echo 'export http_proxy="<your proxy>"' >> ~/.bashrc && \
    echo 'export https_proxy="<your proxy>"' >> ~/.bashrc && \
    echo 'export ftp_proxy="<your proxy>"' >> ~/.bashrc && \
    echo 'export ALL_PROXY="<your proxy>"' >> ~/.bashrc && \
    echo 'export all_proxy="<your proxy>"' >> ~/.bashrc && \
    echo 'export no_proxy="<your setting>"' >> ~/.bashrc

# for prc, add huggingface mirror or copy the pre-downloaded model
ENV HF_ENDPOINT=https://hf-mirror.com
#COPY models /opt/edge-developer-kit-reference-scripts/usecases/ai/edge-ai-demo-studio/models/

ENV PATH="/opt/edge-developer-kit-reference-scripts/usecases/ai/edge-ai-demo-studio:${PATH}"

# Run installation and setup scripts
RUN install_dependencies.sh -y
RUN setup.sh -v

# Default command
CMD ["/bin/bash"]
