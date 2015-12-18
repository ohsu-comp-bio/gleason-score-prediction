FROM jupyter/scipy-notebook

# Required for the execution engine
RUN mkdir /output /data

ADD ./bin /usr/local/bin
ADD ./workspace /home/jovyan/work

VOLUME /output

CMD /bin/build_model
