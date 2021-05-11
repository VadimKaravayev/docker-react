# BUILD PHASE SECTION

# base image
FROM node:alpine as builder

# create working directory of container
WORKDIR '/app'

# copy package.json file to /app directory of container
COPY package.json .

# run npm install command to load all dependencies from package.json
RUN npm install

# copy your source code to /app directory
COPY . . 

# run build command to get code for production. It will create /app/build
RUN npm run build

# create image from nginx base image
FROM nginx

# copy contents from node:alpine container to /usr/share/nginx/html of nginx container
COPY --from=builder /app/build /usr/share/nginx/html

