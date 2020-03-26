FROM postgres:11.4

RUN apt-get update
RUN apt-get -y install libsybdb5 freetds-dev freetds-common libpq-dev git make gcc curl ca-certificates 

RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update && apt-get install -y lsb-release && apt-get clean all
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN apt-get update
RUN apt-get -y install postgresql-server-dev-11

RUN git clone -q https://github.com/tds-fdw/tds_fdw.git tds_fdw
WORKDIR tds_fdw
RUN make USE_PGXS=1
RUN make USE_PGXS=1 install

RUN apt-get -y remove git make curl gcc
