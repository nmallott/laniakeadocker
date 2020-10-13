#!/bin/sh

#service docker start
#cd /laniakea
#. `poetry env info --path`/bin/activate
echo ARGUMENTS $@
cd /laniakea && $HOME/.poetry/bin/poetry run prefect $@
