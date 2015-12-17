## Gleason Score Prediction ##

This Docker image contains the dependencies to run Gleason Score Prediction.
In addition, it provides a configuration that allows a researcher to develop
code within the same Docker-based environment that is used for model building
in production.


### Model Development ###

1. Install [Docker Compose](https://docs.docker.com/compose/install/).

2. If using OSX or Windows:

  + Install [Docker Machine](https://docs.docker.com/machine/install-machine/)

    + Create the machine: `docker-machine create gleason-score --driver virtualbox`

    + Activate that machine with `eval $(docker-machine env gleason-score)`

  + Optionally, if using OSX, install [Pow](http://pow.cx/). This allows you to
    access IPython Notebook via [http://gleason-score.dev](http://gleason-score.dev).

      + Run `echo $DOCKER_HOST | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > ~/.pow/$DOCKER_MACHINE_NAME`

2. Spin up IPython Notebook with `docker-compose up`.

3. Access IPython Notebook via [http://gleason-score.dev](http://gleason-score.dev) (OS X)
  or via the virtual machine IP (`docker-machine ip gleason-score`).
