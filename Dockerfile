FROM postgres:11.3

RUN apt-get update
RUN apt-get -y install libsybdb5 freetds-dev freetds-common libpq-dev

RUN apt-get -y install git make gcc curl ca-certificates

RUN git clone -q https://github.com/tds-fdw/tds_fdw.git tds_fdw
WORKDIR tds_fdw

RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN apt-get update
RUN apt-get -y install postgresql-server-dev-11


RUN make USE_PGXS=1
RUN make USE_PGXS=1 install

RUN apt-get -y remove git make curl gcc