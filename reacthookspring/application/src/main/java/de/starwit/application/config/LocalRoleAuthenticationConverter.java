package de.city.application.config;

import de.city.application.dto.PrincipalDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.convert.converter.Converter;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class LocalRoleAuthenticationConverter implements Converter<Jwt, AbstractAuthenticationToken> {


    private final Logger logger = LoggerFactory.getLogger(LocalRoleAuthenticationConverter.class);

    public PrincipalDto parseToken(Jwt token) {
        PrincipalDto principalDto = new PrincipalDto();

        List<String> roles = (List<String>) token.getClaimAsMap("realm_access").get("roles");
        List<String> scopes = Arrays.stream(token.getClaimAsString("scope").split(" ")).toList();
        //Warning: Roles must be prefixed with ROLE_ and Scopes with SCOPE_ when created in Keycloak
        principalDto.setRoles(roles.stream().map(SimpleGrantedAuthority::new).collect(Collectors.toList()));
        principalDto.setScopes(scopes.stream().map(SimpleGrantedAuthority::new).collect(Collectors.toList()));

        return principalDto;
    }

    public AbstractAuthenticationToken convert(Jwt jwt) {
        PrincipalDto principalDto = parseToken(jwt);

        this.logger.info("Saving updated known user information");
        List<GrantedAuthority> mergedAuthorities = principalDto.getRoles();
        mergedAuthorities.addAll(principalDto.getScopes());
        return new LocalRoleAuthenticationToken(principalDto, mergedAuthorities);
    }
}
