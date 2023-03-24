FROM nginx:alpine

RUN apk update
RUN apk add --no-cache bash

RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx/config.conf /etc/nginx/conf.d

COPY ./build /usr/share/nginx/html/
CMD ls -al /usr/share/nginx/html
EXPOSE 80

# Copy .env file and shell script to container
WORKDIR /usr/share/nginx/html
CMD ls -al /usr/share/nginx/html

COPY ./env.sh .
COPY .env .

CMD ls -al /usr/share/nginx/html

# Make our shell script executable
RUN chmod +x env.sh

CMD ["/bin/bash", "-c", "/usr/share/nginx/html/env.sh && nginx -g \"daemon off;\""]



