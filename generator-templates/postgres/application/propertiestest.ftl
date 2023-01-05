# is only required for direct test executing.
rest.base-path=/api

# actuator
management.endpoints.web.base-path=/monitoring
management.endpoint.health.show-details=always
management.endpoints.web.exposure.include=*

# show full git properties
management.info.git.mode=full

# h2
spring.datasource.url=jdbc:h2:mem:${app.baseName?lower_case};DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE;MODE=MYSQL
spring.datasource.driverClassName=org.h2.Driver
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
spring.jpa.show-sql=true
spring.datasource.username=${app.baseName?lower_case}
spring.datasource.password=${app.baseName?lower_case}

# Flyway
spring.flyway.user=${r"${spring.datasource.username}"}
spring.flyway.password=${r"${spring.datasource.password}"}
spring.flyway.url=${r"${spring.datasource.url}"}
spring.flyway.baseline-on-migrate=true
spring.flyway.locations=classpath:db/migration
spring.flyway.encoding=UTF-8
spring.flyway.placeholder-replacement=false
