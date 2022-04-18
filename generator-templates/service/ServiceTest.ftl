package de.${app.packageName?lower_case}.service;

import de.${app.packageName?lower_case}.persistence.repository.${entity.name}Repository;
import de.${app.packageName?lower_case}.service.impl.${entity.name}Service;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Bean;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * Tests for ${entity.name}Service
 */
@RunWith(SpringRunner.class)
public class ${entity.name}ServiceTest {

    /**
     * <pre>
     * To check the Service class, we need to have an instance of Service class created and available as a
     * @Bean so that we can @Autowire it in our test class.
     * This configuration is achieved by using the @TestConfiguration annotation.
     * </pre>
     */
    @TestConfiguration
    static class ${entity.name}ServiceTestConfiguration {

        @Bean
        public ${entity.name}Service create${entity.name}Service() {
            return new ${entity.name}Service();
        }
    }

    @Autowired
    private ${entity.name}Service ${entity.name?lower_case}Service;

    /**
     * Create a mock.
     */
    @MockBean
    private ${entity.name}Repository ${entity.name?lower_case}Repository;

    @Before
    public void setUp() {
        //TODO: setup objects for each test
    }

    //implement tests here
    @Test
    public void someTest() {
        
    }

}
