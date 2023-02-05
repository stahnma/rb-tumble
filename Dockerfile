
from ruby
RUN apt-get update && apt-get -y install vim git sqlite3 ack-grep && rm -rf /var/lib/apt/lists/*
WORKDIR "/tumble"
RUN /usr/local/bin/bundle config set --local path 'vendor/bundle'
COPY .bashrc /root/.bashrc
EXPOSE 4567
COPY  . /tumble
RUN bundle
CMD [ "rake", "app" ]
