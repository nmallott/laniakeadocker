FROM python:3.8-slim-buster
# Get packages
RUN apt-get remove docker docker-engine docker.io containerd runc | true
RUN apt-get update && apt-get -yq --no-install-suggests --no-install-recommends --allow-change-held-packages install gnupg curl apt-utils software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
RUN apt-get update && apt-get -yq --no-install-suggests --no-install-recommends --allow-change-held-packages install gcc freetds-dev default-libmysqlclient-dev libpq-dev apt-transport-https ca-certificates curl gnupg-agent software-properties-common docker-ce docker-ce-cli containerd.io
# Install POETRY
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
# Docker compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;chmod +x /usr/local/bin/docker-compose;ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
RUN $HOME/.poetry/bin/poetry new laniakea;
COPY conf/pyproject.toml laniakea/
RUN cd laniakea; $HOME/.poetry/bin/poetry config virtualenvs.create false
RUN cd laniakea; $HOME/.poetry/bin/poetry install -vv --no-dev --no-root
RUN cd laniakea; $HOME/.poetry/bin/poetry run prefect backend server
COPY scripts/prefect.sh laniakea/
ENV PATH=$PATH:/root/.poetry/bin
ENTRYPOINT ["/laniakea/prefect.sh"]
