# tag this phase (stage) with the 'as' keyword with the name 'builder'.
FROM node:alpine as builder

WORKDIR /app
COPY ./package.json .

RUN npm install

COPY . .

RUN npm run build
# outputted to /app/build

#################### END OF BUILDER STAGE ##############


# specifying the next stage by saying FROM base_image.
# we do not have to put any 'as' keyword in here to say that the initial phase is stopping.
# by just putting in a second FROM statement, that essentially says 'ok, previouse block, all complete, don't worry about it'.
# any single block/stage/phase can only have one FROM statement.
FROM nginx

# copy over the 'build' folder into this new stage (container) we're putting together.
# we're saying that we want to copy over something from that other phase (stage) that we were just working on.
# in this case from the 'builder' phase.
# specifying the folder we want to copy (/app/build) and the we specify where we want to copy the thing to inside this nginx container we're putting together.
COPY --from=builder /app/build /usr/share/nginx/html

# the default command of the nginx image is going to start up nginx for us.
# so we don't have to specifically RUN anything to start up nginx.
