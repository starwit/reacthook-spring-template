spring.profiles.active=@spring.profiles.active@
spring.banner.location=classpath:banner.txt
server.servlet.context-path=/${app.baseName?lower_case}
rest.base-path=/api
server.port=8081

# actuator
management.endpoints.web.base-path=/monitoring
management.endpoint.health.show-details=always
management.endpoints.web.exposure.include=*

# show full git properties
management.info.git.mode=full

# Postgres
spring.datasource.hikari.connection-timeout=10000
spring.datasource.driver-class-name=org.postgresql.Driver
spring.datasource.url=jdbc:postgresql://localhost:5433/${app.baseName?lower_case}?useLegacyDatetimeCode=false&serverTimezone=CET
spring.jpa.hibernate.naming.physical-strategy=de.${app.packageName?lower_case}.persistence.config.DatabasePhysicalNamingStrategy
spring.datasource.username=${app.baseName?lower_case}
spring.datasource.password=${app.baseName?lower_case}
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
#spring.jpa.hibernate.ddl-auto=create

# Flyway
spring.flyway.user=${r"${spring.datasource.username}"}
spring.flyway.password=${r"${spring.datasource.password}"}
spring.flyway.url=${r"${spring.datasource.url}"}
spring.flyway.baseline-on-migrate=true
spring.flyway.locations=classpath:db/migration
spring.flyway.encoding=UTF-8
spring.flyway.placeholder-replacement=false

springdoc.swagger-ui.disable-swagger-default-url=true
springdoc.api-docs.path=/api-docs
springdoc.swagger-ui.path=/swagger-ui.html
springdoc.swagger-ui.csrf.enabled=true

#logging.level.org.springframework.security=DEBUG

keycloak.auth-server-url=http://localhost:8080/auth
keycloak.realm=${app.baseName?lower_case}
keycloak.resource=${app.baseName?lower_case}
keycloak.principal-attribute=preferred_username
keycloak.public-client=true
keycloak.enabled=true
