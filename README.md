# google-datalab-scripts
Scripts for working with Google Cloud Datalab

## Setup

### Prerequisites

You must have [Docker](https://www.docker.com/) and the [Google Cloud SDK](https://cloud.google.com/sdk/downloads) installed to run the Datalab scripts.


### For use in a project

Use this as a git submodule in the root of your project.

```bash
cd project-name
git submodule add https://github.com/TheLarsonAgency/google-datalab-scripts.git scripts
```

Any notebooks within the project will be exposed to Datalab.


### Configuration

Execute the `setup.sh` script initialize your gcloud installation.  This just executes `gcloud init` for the console, allowing you to initialize or change settings in your environment.


### Google Cloud Services

In order to use these scripts, you may need to have Google Cloud services setup with a project and access to the following APIs for the project:

* Google Cloud Resource Manager API
* Google Compute Engine
* BigQuery API
* potentially others, depending on your use

The exception to these is if you run Datalab and everything in a Docker container locally, though it will still depend on the needs of your notebooks.


## Scripts


#### scripts/setup.sh (recommended)

Execute this script if you need to setup or change your environment configuration for gcloud.

*Note: the other scripts require that you have a configured environment.*


#### scripts/docker_run_locally.sh

Launches the Datalab notebooks in a local docker container.  *Recommended: run this to execute on a small local dataset.*


#### scripts/gce_kernel_vm.sh

Launches the Datalab kernel of the notebooks in a Google Cloud VM while running the interface locally in a Docker container.  *Recommended: run this to execute on a large dataset with low algorithmic efficiency (high big-O values).*


#### scripts/gce_run_vm.sh

Launches the Datalab system remotely in a Google Cloud VM, then ssh's to it.  *Recommended: run this to execute everything on another machine (ie- you have limited local resources and/or don't have docker installed).*



## Contributing

Please feel free to submit pull requests.


## Author

[Bobby Larson](http://bobby.social) of [The Larson Agency](http://larson.agency).

