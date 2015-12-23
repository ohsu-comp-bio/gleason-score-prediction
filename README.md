## Gleason Score Prediction ##

This Docker image contains the dependencies to run Gleason Score Prediction.
In addition, it provides a configuration that allows a researcher to develop
code within the same Docker-based environment that is used for model building
in production.

## Project Structure ##


```
.
├── Dockerfile                     # Dockerfile for building image containing
|                                  # environment for model development and
|                                  # building.
├── README.md
|
├── bin
│   ├── build_model                # Script to build model.
|   |
│   ├── collect_features           # Script to join features across input files.
|   |
│   └── query_es                   # Script to fetch features from
|                                  # ElasticSearch.
├── data
│   └── ...                        # Sample data. Used for hosting "inputs" to
|                                  # workflow. We mount this volume to the
|                                  # Docker container at runtime.
|
├── docker-compose.yml             # Docker Compose configuration so we can
|                                  # develop our notebook.
|
├── gleason_score_train_model.wdl  # WDL workflow for executing the
|                                  # modle-building process.
|
├── output                         # Directory containing outputs from the
|                                  # workflow.
|
├── gleason_score_train_model.json.template # Workflow configuration to run the pipeline
|                                           # with sample data.
|
└── workspace                      # Workspace for developing the notebook. Note
    └── ...                        # that the script to build the model is
                                   # located here.
```


### Model Development ###

1. Install [Docker Compose](https://docs.docker.com/compose/install/).

2. If using OSX or Windows:

  + Install [Docker Machine](https://docs.docker.com/machine/install-machine/)

    + Create the machine: `docker-machine create gleason-score --driver virtualbox`

    + Activate that machine with `eval $(docker-machine env gleason-score)`

2. Spin up IPython Notebook with `docker-compose up`.

3. Access IPython Notebook via the virtual machine IP (`docker-machine ip gleason-score`).
