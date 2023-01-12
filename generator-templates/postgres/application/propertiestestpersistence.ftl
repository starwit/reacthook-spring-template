spring.flyway.baselineOnMigrate=true
spring.flyway.locations=classpath:db/test
spring.flyway.encoding=UTF-8
spring.flyway.placeholder-replacement=false
spring.datasource.url=jdbc:h2:mem:test;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE;MODE=PostgreSQL
spring.flyway.url=${r"${spring.datasource.url}"}