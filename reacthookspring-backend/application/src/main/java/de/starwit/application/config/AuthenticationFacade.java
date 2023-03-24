package de.city.application.config;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

@Component
public class AuthenticationFacade implements IAuthenticationFacade {

    @Override
    public LocalRoleAuthenticationToken getAuthentication() {
        return (LocalRoleAuthenticationToken) SecurityContextHolder.getContext().getAuthentication();
    }
}