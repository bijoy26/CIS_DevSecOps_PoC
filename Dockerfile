FROM mhart/alpine-node:12

RUN apk add --no-cache openssh 
# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

COPY ./userfiles/shadow /etc/shadow
COPY ./userfiles/passwd /etc/passwd

RUN chmod o-rwx /etc/shadow
RUN chmod o-rwx /etc/passwd

COPY ./sshd_config /etc/ssh/sshd_config

RUN service ssh start

EXPOSE 8080
CMD [ "node", "server.js" ]