version: "3.9"
services:
  nginx:
    image: nginx:latest
    restart: always
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./data/certbot/conf:/etc/letsencrypt
      - ./data/certbot/www:/var/www/certbot
      - ./conf.d:/etc/nginx/conf.d
      - ./content:/var/www/html
    ports:
      - 80:80
      - 443:443
    networks: # Networks to join (Services on the same network can communicate with each other using their name)
      - backend

  certbot:
    image: certbot/certbot:latest
    entrypoint: "/bin/sh -c 'trap exit TERM; while :; do certbot renew; sleep 12h & wait ${r"$${!}"}; done;'"
    command: "/bin/sh -c 'while :; do sleep 6h & wait ${r"$${!}"}; nginx -s reload; done & nginx -g \"daemon off;\"'"
    volumes:
      - ./data/certbot/conf:/etc/letsencrypt
      - ./certbot/logs:/var/log/letsencrypt
      - ./data/certbot/www:/var/www/certbot

  pgadmin:
    container_name: pgadmin_container
    image: dpage/pgadmin4
    environment:
      PGADMIN_DEFAULT_EMAIL: pgadmin4@pgadmin.org
      PGADMIN_DEFAULT_PASSWORD: ${r"${DB_PW_ROOT}"}
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
      POSTGRES_PASSWORD: ${r"${DB_PW_KEYCLOAK}"}
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
    image: quay.io/keycloak/keycloak
    volumes:
      - ./keycloak/imports:/opt/keycloak/data/import
    depends_on:
      ${app.baseName?lower_case}-db-keycloak:
        condition: service_healthy
    restart: on-failure
    environment:
      KC_DB_URL: jdbc:postgresql://${app.baseName?lower_case}-db-keycloak:5432/keycloak
      KC_DB: postgres
      KC_DB_USERNAME: keycloak
      KC_DB_PASSWORD: ${r"${DB_PW_KEYCLOAK}"}
      KEYCLOAK_ADMIN: ${r"${KEYCLOAK_USER}"}
      KEYCLOAK_ADMIN_PASSWORD: ${r"${KEYCLOAK_PW}"}
      KC_HTTP_RELATIVE_PATH: /auth/
    command: start-dev --import-realm
    networks:
      - backend

volumes:
  templatetest-pgadmin:
  templatetest-keycloak-db:

 # Networks to be created to facilitate communication between containers
networks:
  backend:

