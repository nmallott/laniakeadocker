#!/bin/sh

# Ok sur le même compute
docker run --name dask_scheduler -itd --network=host --rm nmallott/laniakea dask-scheduler
docker run --name dask_worker -itd --network=host --rm  nmallott/laniakea dask-worker tcp://localhost:8786
docker run --name prefect_server -itd --network=host --rm -v /var/run/docker.sock:/var/run/docker.sock -e PREFECT__ENGINE__EXECUTOR__DEFAULT_CLASS="prefect.engine.executors.DaskExecutor" -e PREFECT__ENGINE__EXECUTOR__DASK__ADDRESS="tcp://localhost:8786" nmallott/laniakea prefect server start
docker run --name prefect_agent -itd --network=host --rm -v /var/run/docker.sock:/var/run/docker.sock -e PREFECT__ENGINE__EXECUTOR__DEFAULT_CLASS="prefect.engine.executors.DaskExecutor" -e PREFECT__ENGINE__EXECUTOR__DASK__ADDRESS="tcp://localhost:8786" nmallott/laniakea prefect agent start
