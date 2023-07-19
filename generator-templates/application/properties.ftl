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

# MySQL
spring.datasource.hikari.connection-timeout=10000
spring.datasource.driver-class-name=org.mariadb.jdbc.Driver
spring.datasource.url=jdbc:mariadb://localhost:3306/${app.baseName?lower_case}?useLegacyDatetimeCode=false&serverTimezone=CET
spring.jpa.hibernate.naming.physical-strategy=de.${app.packageName?lower_case}.persistence.config.DatabasePhysicalNamingStrategy
#spring.jpa.hibernate.ddl-auto=create
spring.datasource.username=${app.baseName?lower_case}
spring.datasource.password=${app.baseName?lower_case}
spring.data.rest.detection-strategy=annotated

# Flyway
spring.flyway.user=${r"${spring.datasource.username}"}
spring.flyway.password=${r"${spring.datasource.password}"}
spring.flyway.url=${r"${spring.datasource.url}"}
spring.flyway.baseline-on-migrate=true
spring.flyway.locations=classpath:db/migration
spring.flyway.encoding=UTF-8
spring.flyway.placeholder-replacement=false

#logging.level.org.springframework.security=DEBUG

spring.security.oauth2.client.provider.keycloak.issuer-uri=http://localhost:8080/auth/realms/${app.baseName?lower_case}
spring.security.oauth2.client.registration.keycloak.client-id=${app.baseName?lower_case}
spring.security.oauth2.client.registration.keycloak.client-secret=${app.baseName?lower_case}
spring.security.oauth2.client.registration.keycloak.scope=openid
