package de.city.application.dto;

import org.springframework.security.core.GrantedAuthority;

import java.util.ArrayList;
import java.util.List;

public class PrincipalDto {

    private Boolean emailVerified;

    private String email;
    private String familyName;
    private String givenName;
    private String userName;
    private String userId;
    private List<GrantedAuthority> roles = new ArrayList<>();

    private List<GrantedAuthority> scopes = new ArrayList<>();

    public Boolean getEmailVerified() {
        return emailVerified;
    }

    public void setEmailVerified(Boolean emailVerified) {
        this.emailVerified = emailVerified;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFamilyName() {
        return familyName;
    }

    public void setFamilyName(String familyName) {
        this.familyName = familyName;
    }

    public String getGivenName() {
        return givenName;
    }

    public void setGivenName(String givenName) {
        this.givenName = givenName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public List<GrantedAuthority> getRoles() {
        return roles;
    }

    public void setRoles(List<GrantedAuthority> roles) {
        this.roles = roles;
    }

    public List<GrantedAuthority> getScopes() {
        return scopes;
    }

    public void setScopes(List<GrantedAuthority> scopes) {
        this.scopes = scopes;
    }
}
