package de.starwit.application.config;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.authority.mapping.GrantedAuthoritiesMapper;
import org.springframework.security.oauth2.core.oidc.user.OidcUserAuthority;
import org.springframework.security.oauth2.core.user.OAuth2UserAuthority;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.stereotype.Component;

import java.util.*;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    static final Logger LOG = LoggerFactory.getLogger(SecurityConfig.class);

    private static final String[] AUTH_WHITELIST = {
            // -- Swagger UI v2
            "/v2/api-docs",
            "/swagger-resources",
            "/swagger-resources/**",
            "/configuration/ui",
            "/configuration/security",
            "/swagger-ui.html",
            "/webjars/**",
            // -- Swagger UI v3 (OpenAPI)
            "/v3/api-docs/**",
            "/swagger-ui/**"
            // other public endpoints of your API may be appended to this array
    };

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                // TODO Not great, has to be fixed
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers(AUTH_WHITELIST).permitAll()
                        .requestMatchers("/**").hasAnyRole("admin", "user", "reader")
                        .requestMatchers("/", "/login/**", "/oauth2/**").permitAll()
                        .anyRequest().authenticated()
                )
                // Maybe https://stackoverflow.com/questions/74939220/classnotfoundexception-org-springframework-security-oauth2-server-resource-web
                .oauth2Login(Customizer.withDefaults());
        return http.build();
    }


    // Taken from https://stackoverflow.com/questions/74939220/classnotfoundexception-org-springframework-security-oauth2-server-resource-web
    @Component
    @RequiredArgsConstructor
    static class GrantedAuthoritiesMapperImpl implements GrantedAuthoritiesMapper {

        @Override
        public Collection<? extends GrantedAuthority> mapAuthorities(Collection<? extends GrantedAuthority> authorities) {
            Set<GrantedAuthority> mappedAuthorities = new HashSet<>();

            authorities.forEach(authority -> {
                if (authority instanceof SimpleGrantedAuthority) {
                    mappedAuthorities.add(authority);
                }
                if (authority instanceof OidcUserAuthority) {
                    try {
                        final var oidcUserAuthority = (OidcUserAuthority) authority;
                        final List<String> roles = oidcUserAuthority.getUserInfo().getClaimAsStringList("roles");

                        mappedAuthorities.addAll(roles.stream().map(SimpleGrantedAuthority::new).toList());
                    } catch (NullPointerException e) {
                        LOG.error("Could not read the roles from claims.realm_access.roles -- Is the Mapper set up correctly?");
                    }
                } else if (authority instanceof OAuth2UserAuthority oauth2UserAuthority) {
                    final var userAttributes = oauth2UserAuthority.getAttributes();
                    final Map<String, List<String>> realmAccess = (Map<String, List<String>>) userAttributes.get("realm_access");
                    final List<String> roles = realmAccess.get("roles");

                    mappedAuthorities.addAll(roles.stream().map(SimpleGrantedAuthority::new).toList());
                }
            });

            return mappedAuthorities;
        }

    }


}