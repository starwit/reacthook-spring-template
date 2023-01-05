version: "3.9"
services:
  postgres:
    container_name: {app.baseName?lower_case}-db
    image: postgres:latest
    environment:
      POSTGRES_DB: {app.baseName?lower_case}
      POSTGRES_USER: {app.baseName?lower_case}
      POSTGRES_PASSWORD: {app.baseName?lower_case}
      PGDATA: /var/lib/postgresql/data
    healthcheck:
      test: ['CMD-SHELL', 'pg_isready -U {app.baseName?lower_case}'] # <<<---
      interval: 5s
      timeout: 60s
      retries: 30
    volumes:
      - {app.baseName?lower_case}-db:/var/lib/postgresql/data
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
       - {app.baseName?lower_case}-pgadmin:/var/lib/pgadmin
    ports:
      - "5050:80"
    networks:
      - backend
    restart: unless-stopped

networks:
  backend:

volumes:
  {app.baseName?lower_case}-db:
  {app.baseName?lower_case}-pgadmin: