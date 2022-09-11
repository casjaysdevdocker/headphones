FROM casjaysdevdocker/alpine:latest as build

ARG LICENSE=WTFPL \
  IMAGE_NAME=headphones \
  TIMEZONE=America/New_York \
  PORT=8181

ENV SHELL=/bin/bash \
  TERM=xterm-256color \
  HOSTNAME=${HOSTNAME:-casjaysdev-$IMAGE_NAME} \
  TZ=$TIMEZONE

RUN mkdir -p /bin/ /config/ /data/ && \
  rm -Rf /bin/.gitkeep /config/.gitkeep /data/.gitkeep && \
  apk update -U --no-cache && \
  apk add -U --no-cache python git && \
  git clone https://github.com/rembo10/headphones /var/lib/headphones -q

COPY ./bin/. /usr/local/bin/
COPY ./config/. /etc/
COPY ./data/. /data/

FROM scratch
ARG BUILD_DATE="$(date +'%Y-%m-%d %H:%M')"

LABEL org.label-schema.name="headphones" \
  org.label-schema.description="Containerized version of headphones" \
  org.label-schema.url="https://hub.docker.com/r/casjaysdevdocker/headphones" \
  org.label-schema.vcs-url="https://github.com/casjaysdevdocker/headphones" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.version=$BUILD_DATE \
  org.label-schema.vcs-ref=$BUILD_DATE \
  org.label-schema.license="$LICENSE" \
  org.label-schema.vcs-type="Git" \
  org.label-schema.schema-version="latest" \
  org.label-schema.vendor="CasjaysDev" \
  maintainer="CasjaysDev <docker-admin@casjaysdev.com>"

ENV SHELL="/bin/bash" \
  TERM="xterm-256color" \
  HOSTNAME="casjaysdev-headphones" \
  TZ="${TZ:-America/New_York}"

WORKDIR /root

VOLUME ["/root","/config","/data"]

EXPOSE $PORT

COPY --from=build /. /

ENTRYPOINT [ "tini", "--" ]
HEALTHCHECK CMD [ "/usr/local/bin/entrypoint-headphones.sh", "healthcheck" ]
CMD [ "/usr/local/bin/entrypoint-headphones.sh" ]

