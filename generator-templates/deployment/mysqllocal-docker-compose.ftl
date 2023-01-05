version: "3.9"
services:
  db:
    image: mariadb:latest
    restart: on-failure
    environment:
      MYSQL_DATABASE: '${app.baseName?lower_case}'
      # So you don't have to use root, but you can if you like
      MYSQL_USER: '${app.baseName?lower_case}'
      # You can use whatever password you like
      MYSQL_PASSWORD: '${app.baseName?lower_case}'
      # Password for root access
      MYSQL_ALLOW_EMPTY_PASSWORD: 'yes'
    ports:
      # <Port exposed> : < MySQL Port running inside container>
      - '3306:3306'
    healthcheck:
      test: ["CMD", "mysql" ,"-h", "localhost", "-P", "3306", "-u", "root", "-e", "select 1", "${app.baseName?lower_case}"]
      interval: 5s
      timeout: 60s
      retries: 30
    volumes:
      - ${app.baseName?lower_case}v2-db-data:/var/lib/mysql
    networks: # Networks to join (Services on the same network can communicate with each other using their name)
      - backend

# Names our volume
volumes:
  ${app.baseName?lower_case}v2-db-data:

 # Networks to be created to facilitate communication between containers
networks:
  backend: