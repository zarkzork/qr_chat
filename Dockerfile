FROM ruby

RUN curl -L -o websocketd.deb https://github.com/joewalnes/websocketd/releases/download/v0.2.12/websocketd-0.2.12_amd64.deb && \
    dpkg -i websocketd.deb && \
    rm websocketd.deb

RUN gem install redis
