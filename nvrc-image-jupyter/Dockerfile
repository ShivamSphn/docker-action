FROM nvcr.io/nvidia/pytorch:23.12-py3
WORKDIR /
COPY . .

# Make the git installation script executable and run it
COPY install_git_and_lfs.sh /install_git_and_lfs.sh
RUN chmod +x /install_git_and_lfs.sh && \
    /install_git_and_lfs.sh

RUN pip install protobuf SentencePiece torch
RUN pip install jupyterlab

EXPOSE 8888
EXPOSE 8000
EXPOSE 8001
EXPOSE 8002

# Default token can be overridden at runtime with -e JUPYTER_TOKEN=yourpassword
ENV JUPYTER_TOKEN=default_password

CMD ["/bin/sh", "-c", "jupyter lab --LabApp.token='${JUPYTER_TOKEN}' --LabApp.ip='0.0.0.0' --LabApp.allow_root=True"]
