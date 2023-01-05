version: "3.9"
services:
  postgres:
    container_name: ${app.baseName?lower_case}-db
    image: postgres:latest
    environment:
      POSTGRES_DB: ${app.baseName?lower_case}
      POSTGRES_USER: ${app.baseName?lower_case}
      POSTGRES_PASSWORD: ${app.baseName?lower_case}
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
  
  pgadmin:
    container_name: pgadmin_container
    image: dpage/pgadmin4
    environment:
      PGADMIN_DEFAULT_EMAIL: pgadmin4@pgadmin.org
      PGADMIN_DEFAULT_PASSWORD: admin
      PGADMIN_CONFIG_SERVER_MODE: 'False'
    volumes:
       - ${app.baseName?lower_case}-pgadmin:/var/lib/pgadmin
    ports:
      - "5050:80"
    networks:
      - backend
    restart: unless-stopped

  ${app.baseName?lower_case}-db-keycloak:
    image: postgres:latest
    restart: on-failure
    environment:
      POSTGRES_DB: 'keycloak'
      POSTGRES_USER: 'keycloak'
      POSTGRES_PASSWORD: 'keycloak'
      PGDATA: /var/lib/postgresql/data
    healthcheck:
      test: ['CMD-SHELL', 'pg_isready -U keycloak'] 
      interval: 5s
      timeout: 60s
      retries: 30
    volumes:
      - ${app.baseName?lower_case}-keycloak-db:/var/lib/postgresql/data
    networks:
      - backend

  ${app.baseName?lower_case}-keycloak:
    image: jboss/keycloak
    volumes:
      - ./keycloak/imports:/opt/jboss/keycloak/imports
      - ./keycloak/local-test-users.json:/opt/jboss/keycloak/standalone/configuration/keycloak-add-user.json
    depends_on:
      ${app.baseName?lower_case}-db-keycloak:
        condition: service_healthy
    restart: on-failure
    environment:
      KEYCLOAK_IMPORT: /opt/jboss/keycloak/imports/realm.json
      DB_VENDOR: postgres
      DB_ADDR: ${app.baseName?lower_case}-db-keycloak
      DB_PORT: 5432
      DB_USER: 'keycloak'
      DB_PASSWORD: 'keycloak'
      PROXY_ADDRESS_FORWARDING: 'true'
      KEYCLOAK_FRONTEND_URL: 'http://localhost:8080/auth'
    ports:
      # <Port exposed> : < MySQL Port running inside container>
      - '8080:8080'
    networks:
      - backend

networks:
  backend:

volumes:
  ${app.baseName?lower_case}-db:
  ${app.baseName?lower_case}-pgadmin:
  ${app.baseName?lower_case}-keycloak-db:

