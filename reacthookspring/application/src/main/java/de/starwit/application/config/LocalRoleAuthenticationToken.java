package de.city.application.config;

import de.city.application.dto.PrincipalDto;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class LocalRoleAuthenticationToken extends AbstractAuthenticationToken {

    final private PrincipalDto user;

    public LocalRoleAuthenticationToken(PrincipalDto user, Collection<GrantedAuthority> authorities) {
        super(authorities);
        this.user = user;
        super.setAuthenticated(true);
    }

    @Override
    public Object getCredentials() {
        return null;
    }

    @Override
    public Object getPrincipal() {
        return this.user;
    }


}
