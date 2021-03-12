FROM ubuntu
RUN apt-get update && apt-get install -y locales nginx nano wget && rm -rf /var/lib/apt/lists/* \
    && localedef -i es_ES -c -f UTF-8 -A /usr/share/locale/locale.alias es_ES.UTF-8
ENV LANG es_ES.utf8

RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb 
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update;\ 
  apt-get install -y apt-transport-https && \
  apt-get update && \
  apt-get install -y dotnet-sdk-5.0

RUN rm -r /etc/nginx/sites-enabled

COPY apiConversor /var/www/apiConversor
COPY frontConversor /var/www/frontConversor
COPY sites-enabled /etc/nginx/sites-enabled

WORKDIR /var/www/apiConversor

ENTRYPOINT service nginx restart && dotnet Conversor_REST.dll && bash
#CMD ["/bin/bash"]

