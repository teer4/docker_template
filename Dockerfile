FROM pytorch/pytorch:1.13.0-cuda11.6-cudnn8-devel

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN echo 'Acquire::AllowInsecureRepositories "true";' > /etc/apt/apt.conf.d/90ignore-check &&     echo 'Acquire::AllowUnauthenticated "true";' >> /etc/apt/apt.conf.d/90ignore-check &&     sed -i 's|http://archive.ubuntu.com/ubuntu|http://mirrors.aliyun.com/ubuntu|g' /etc/apt/sources.list &&     sed -i 's|http://security.ubuntu.com/ubuntu|http://mirrors.aliyun.com/ubuntu|g' /etc/apt/sources.list &&     rm -f /etc/apt/sources.list.d/cuda* && rm -f /etc/apt/sources.list.d/nvidia* &&     apt-get update && apt-get install -y --no-install-recommends --allow-unauthenticated wget bzip2 &&     rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/conda-forge/miniforge/releases/download/24.1.2-0/Mambaforge-24.1.2-0-Linux-x86_64.sh &&     bash Mambaforge-24.1.2-0-Linux-x86_64.sh -b -p /opt/mamba &&     rm Mambaforge-24.1.2-0-Linux-x86_64.sh &&     ln -s /opt/mamba/etc/profile.d/conda.sh /etc/profile.d/conda.sh &&     /opt/mamba/bin/mamba clean -afy

ENV PATH=/opt/mamba/bin:$PATH

WORKDIR /workspace

COPY environment.yaml /workspace/environment.yaml

RUN mamba env create -f /workspace/environment.yaml &&     mamba clean -afy

SHELL ["conda", "run", "-n", "env", "/bin/bash", "-c"]

CMD ["bash"]
