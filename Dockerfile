FROM node:11.13.0-alpine

# create destination directory
RUN mkdir -p /usr/src
WORKDIR /usr/src

# update and install dependency
RUN apk update && apk upgrade
RUN apk add git yarn

# copy the app, note .dockerignore
COPY src/. /usr/src
RUN yarn install

# build necessary, even if no static files are needed,
# since it builds the server as well
RUN yarn run build

# expose 5000 on container
EXPOSE 5000

# set app serving to permissive / assigned
ENV NUXT_HOST=0.0.0.0
# set app port
ENV NUXT_PORT=5000

# start the app
CMD [ "yarn", "start" ]
