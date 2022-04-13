spring.profiles.active=@spring.profiles.active@
spring.banner.location=classpath:banner.txt
server.servlet.context-path=/${app.title?lower_case}
rest.base-path=/api

# actuator
management.endpoints.web.base-path=/monitoring
management.endpoint.health.show-details=always

# show full git properties
management.info.git.mode=full

# MySQL
spring.datasource.hikari.connection-timeout=10000
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/${app.title?lower_case}?useLegacyDatetimeCode=false&serverTimezone=CET
spring.jpa.hibernate.naming.physical-strategy=de.${app.packagePrefix?lower_case}.persistence.config.UpperSnakeCasePhysicalNamingStrategy
#spring.jpa.hibernate.ddl-auto=create
spring.datasource.username=${app.title?lower_case}
spring.datasource.password=${app.title?lower_case}

# Flyway
spring.flyway.user=${r"${spring.datasource.username}"}
spring.flyway.password=${r"${spring.datasource.password}"}
spring.flyway.url=${r"${spring.datasource.url}"}
spring.flyway.baseline-on-migrate=true
