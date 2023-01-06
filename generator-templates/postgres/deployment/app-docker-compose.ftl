version: "3.9"
services:
  postgres:
    container_name: ${app.baseName?lower_case}-db
    image: postgres:latest
    environment:
      POSTGRES_DB: ${app.baseName?lower_case}
      POSTGRES_USER: ${app.baseName?lower_case}
      POSTGRES_PASSWORD: ${r"${DB_PW_"}${app.baseName}${r"}"}
      PGDATA: /var/lib/postgresql/data
    healthcheck:
      test: ['CMD-SHELL', 'pg_isready -U ${app.baseName?lower_case}'] # <<<---
      interval: 5s
      timeout: 60s
      retries: 30
    volumes:
      - ${app.baseName?lower_case}-db:/var/lib/postgresql/data
    ports:
      - "5433:5432"
    networks:
      - backend
    restart: unless-stopped
      
  ${app.baseName?lower_case}:
    image: ${app.baseName?lower_case}:latest
    depends_on:
      ${app.baseName?lower_case}-db:
        condition: service_healthy
    restart: on-failure
    environment:
      SPRING_DATASOURCE_URL: jdbc:postgresql://${app.baseName?lower_case}:5433/${app.baseName?lower_case}?useSSL=false&serverTimezone=UTC&useLegacyDatetimeCode=false
      SPRING_DATASOURCE_USERNAME: ${app.baseName?lower_case}
      SPRING_DATASOURCE_PASSWORD: ${r"${DB_PW_"}${app.baseName}${r"}"}
      KEYCLOAK_AUTH-SERVER-URL: https://${r"${DOMAIN}"}/auth
      SERVER_USE_FORWARD_HEADERS: "true"
      SERVER_FORWARD_HEADERS_STRATEGY: FRAMEWORK
    networks: # Networks to join (Services on the same network can communicate with each other using their name)
      - backend

 # Networks to be created to facilitate communication between containers
networks:
  backend:

