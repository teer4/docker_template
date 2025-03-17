#Notice environment/environments.yaml?
FROM pytorch/pytorch:1.13.0-cuda11.6-cudnn8-devel

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN echo 'Acquire::AllowInsecureRepositories "true";' > /etc/apt/apt.conf.d/90ignore-check &&     echo 'Acquire::AllowUnauthenticated "true";' >> /etc/apt/apt.conf.d/90ignore-check &&     sed -i 's|http://archive.ubuntu.com/ubuntu|http://mirrors.aliyun.com/ubuntu|g' /etc/apt/sources.list &&     sed -i 's|http://security.ubuntu.com/ubuntu|http://mirrors.aliyun.com/ubuntu|g' /etc/apt/sources.list &&     rm -f /etc/apt/sources.list.d/cuda* && rm -f /etc/apt/sources.list.d/nvidia* &&     apt-get update && apt-get install -y --no-install-recommends --allow-unauthenticated wget bzip2 &&     rm -rf /var/lib/apt/lists/*

# 安装 Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    ln -s /opt/miniconda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    /opt/miniconda/bin/conda init bash && \
    /opt/miniconda/bin/conda clean -afy && \
    /opt/miniconda/bin/conda --version

RUN apt-get update && apt-get install -y --no-install-recommends --allow-unauthenticated wget bzip2 git && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=/opt/conda/bin:$PATH

WORKDIR /workspace/{project_name}

COPY . /workspace/{project_name}

RUN conda env create -f environment.yaml && conda clean -afy

#env=name in environment.yaml
SHELL ["conda", "run", "-n", "env", "/bin/bash", "-c"]

CMD ["bash"]
