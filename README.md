# laniakeadocker
Docker container for laniakea 
(laniakea is a custom packaging of prefect, see [laniakea repo](https://github.com/pujo-j/laniakea))

## Server start
docker run --network=host -it -v /var/run/docker.sock:/var/run/docker.sock laniakea server start

## Agent start
docker run --network=host -it -v /var/run/docker.sock:/var/run/docker.sock laniakea agent start -l \<label>
