FROM node:lts-alpine
RUN npm install -g http-server

# make the 'app' folder the current working directory
WORKDIR /tictactoe

# copy both 'package.json' and 'package-lock.json' (if available)
COPY package*.json ./

# install project dependencies
RUN npm install

RUN npm add vuetify

# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY . .

# build app for production with minification
RUN npm run build

EXPOSE 8080
CMD [ "http-server", "dist" ]