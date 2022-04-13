package de.${app.packagePrefix?lower_case}.service;

import de.${app.packagePrefix?lower_case}.persistence.entity.${domain.name}Entity;
import de.${app.packagePrefix?lower_case}.persistence.repository.${domain.name}Repository;
import de.${app.packagePrefix?lower_case}.service.impl.${domain.name}Service;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Bean;
import org.springframework.test.context.junit4.SpringRunner;

import javax.persistence.EntityNotFoundException;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

/**
 * Tests for ${domain.name}Service
 */
@RunWith(SpringRunner.class)
public class ${domain.name}ServiceTest {

    /**
     * <pre>
     * To check the Service class, we need to have an instance of Service class created and available as a
     * @Bean so that we can @Autowire it in our test class.
     * This configuration is achieved by using the @TestConfiguration annotation.
     * </pre>
     */
    @TestConfiguration
    static class ${domain.name}ServiceTestConfiguration {

        @Bean
        public ${domain.name}Service create${domain.name}Service() {
            return new ${domain.name}Service();
        }
    }

    @Autowired
    private ${domain.name}Service ${domain.name?lower_case}Service;

    /**
     * Create a mock.
     */
    @MockBean
    private ${domain.name}Repository ${domain.name?lower_case}Repository;

    @Before
    public void setUp() {
        //TODO: setup objects for each test
    }

    //implement tests here
    @Test
    public void someTest() {
        
    }

}
