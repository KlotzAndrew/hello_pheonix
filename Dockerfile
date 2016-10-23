FROM ubuntu:14.04.3

# wget for convenience, use curl if you want to
RUN apt-get -y install curl

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs 

# Set the locale, otherwise elixir will complain later on
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# wget for convenience, use curl if you want to
RUN apt-get -y -q install wget

# add erlang otp
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update
RUN apt-get install -y -q imagemagick esl-erlang elixir


ADD . /app
WORKDIR /app

RUN mix local.hex --force
RUN mix deps.get
RUN mix compile
RUN npm install
CMD ["mix", "phoenix.server"]

