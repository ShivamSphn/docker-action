FROM nvcr.io/nvidia/pytorch:23.12-py3
WORKDIR /
COPY . .
RUN pip install protobuf SentencePiece torch
RUN pip install jupyterlab
EXPOSE 8888
EXPOSE 8000
EXPOSE 8001
EXPOSE 8002
CMD ["/bin/sh", "-c", "jupyter lab --LabApp.token='password' --LabApp.ip='0.0.0.0' --LabApp.allow_root=True"]