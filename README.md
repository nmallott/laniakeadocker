# laniakeadocker
Docker container for laniakea 
(laniakea is a custom packaging of prefect, see [laniakea repo](https://github.com/pujo-j/laniakea))

## General form
docker run --network=host -v /var/run/docker.sock:/var/run/docker.sock laniakea \<command and args for prefect or dask>

## Server start
docker run --network=host -v /var/run/docker.sock:/var/run/docker.sock laniakea prefect server start

## Agent start
docker run --network=host -v /var/run/docker.sock:/var/run/docker.sock laniakea prefect agent start -l \<label>
