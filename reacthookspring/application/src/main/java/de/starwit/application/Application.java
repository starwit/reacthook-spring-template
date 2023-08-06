package de.starwit.application;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ser.impl.SimpleBeanPropertyFilter;
import com.fasterxml.jackson.databind.ser.impl.SimpleFilterProvider;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

/**
 * Main SpringApplication to start the whole project
 */
@SpringBootApplication(
        scanBasePackages = {
                "de.starwit.rest",
                "de.starwit.service",
                "de.starwit.persistence",
                "de.starwit.application.config"
        },
        exclude = {
                org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class,
                org.springframework.boot.actuate.autoconfigure.security.servlet.ManagementWebSecurityAutoConfiguration.class})
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(new Class[]{Application.class}, args);
    }

    @Bean
    public ObjectMapper mapper() {
        ObjectMapper mapper = new ObjectMapper();

        SimpleFilterProvider filterProvider = new SimpleFilterProvider();
        filterProvider.addFilter("filterId", SimpleBeanPropertyFilter.filterOutAllExcept("id"));
        filterProvider.addFilter("filterIdName", SimpleBeanPropertyFilter.filterOutAllExcept("id", "name", "title"));
        mapper.setFilterProvider(filterProvider);
        return mapper;
    }
}
