This repository contains a template for a java spring boot backend and a React frontend.

## Contact

denjoo@oss.volkswagen.com (backend)
ipdramon@oss.volkswagen.com (frontend)

## Used Technologies

* Spring Boot
* React
* Java 14 or higher
* Maven 3
* MariaDB / MySQL

## Structure

The app is structured into five submodules:
* **application**
* **rest**
* **service**
* **persistence**
* **webclient**

## Preface

1. Search your app for TODOs (e.g. 'grep -rni "TODO" .' in this apps root folder ). There will be some locations you have to change
2. Install or update NodeJS (if not already done). You can use [NodeJS Version Management Tool](https://github.com/tj/n) and command ´n´ for doing that:
  ```bash
  # Node JS UPDATE
  npm cache clean -f
  sudo npm install -g n
  sudo n stable
  sudo n latest
  ```
3. Run `npm install` in webclient/app
This will download the dependencies listed in package.json
4. Ensure, that database (mariaDB/MySQL) and user is created:
  ```sql
  CREATE DATABASE react-spring;
  CREATE USER 'react-spring'@'%' IDENTIFIED BY 'erik';
  grant all ON react-spring.* TO 'erik'@'localhost';
  ```

## Build

Build spring backend
```bash
mvn clean package
```

Build spring backend + React frontend
```bash
mvn clean package -P frontend
```

## Run

Run example application.
```bash
cd application
java -jar target/application-<version>.dev.jar 
```
Your application is reachable under http://localhost:8080/react-spring

Test simple rest call.
```
http://localhost:8080/react-spring/api/health
http://localhost:8080/react-spring/api/health/log
http://localhost:8080/react-spring/api/devices
```
```
curl -X GET -H 'Content-Type: application/json' -i http://localhost:8080/react-spring/api/health
curl -X GET -H 'Content-Type: application/json' -i http://localhost:8080/react-spring/api/health/log
curl -X GET -H 'Content-Type: application/json' -i http://localhost:8080/react-spring/api/devices
```
## Development & Debugging

* you can start the application by running main class `application/Application.java` in your IDE
* to enable fast changes to frontend, you can run `npm start` in webclient/app directory

