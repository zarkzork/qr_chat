FROM ruby

RUN curl -L -o websocketd.deb https://github.com/joewalnes/websocketd/releases/download/v0.3.0/websocketd-0.3.0_amd64.deb && \
    dpkg -i websocketd.deb && \
    rm websocketd.deb

RUN gem install redis
