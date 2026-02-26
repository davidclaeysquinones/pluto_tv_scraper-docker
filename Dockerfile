FROM node:23-alpine
ARG BIN_FOLDER=/bin
ARG PLUTO_FOLDER=pluto
ARG FIXES_FOLDER_ARG=fixes
ARG START_SCRIPT_ARG=$BIN_FOLDER/$PLUTO_FOLDER/start.sh
ENV WORKDIR=${BIN_FOLDER}/${PLUTO_FOLDER}
ENV START_SCRIPT=$START_SCRIPT_ARG
COPY config.json /config/config.json
RUN mkdir $(echo "${WORKDIR}") -p
COPY start.sh $WORKDIR
COPY build.sh .
RUN apk update \
  && apk upgrade --available \
  && apk add tzdata bash \
  && chmod +x build.sh  \
  && bash build.sh \
  && ln -s /config/config.json $(echo "${WORKDIR}/config.json") \
  && mkdir /public \
  && chmod +x "$START_SCRIPT" \
  && rm -rf /var/cache/apk/* \
  && rm build.sh
SHELL ["/bin/bash", "-c"]
ENTRYPOINT bash $START_SCRIPT  work-dir="$WORKDIR"
EXPOSE 5050