# Authentication
spring.security.oauth2.client.provider.keycloak.issuer-uri=http://localhost:8080/auth/realms/${app.baseName?lower_case}
spring.security.oauth2.client.registration.keycloak.client-id=${app.baseName?lower_case}
spring.security.oauth2.client.registration.keycloak.client-secret=${app.baseName?lower_case}
spring.security.oauth2.client.registration.keycloak.scope=openid