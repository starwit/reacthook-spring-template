package de.${app.packagePrefix?lower_case}.rest.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import de.${app.packagePrefix?lower_case}.persistence.entity.${domain.name}Entity;
import de.${app.packagePrefix?lower_case}.service.impl.${domain.name}Service;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.Matchers.is;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Tests for ${domain.name}Controller
 *
 * <pre>
 * @WebMvcTest also auto-configures MockMvc which offers a powerful way of
 * easy testing MVC controllers without starting a full HTTP server.
 * </pre>
 */
@RunWith(SpringRunner.class)
@WebMvcTest(${domain.name}Controller.class)
public class ${domain.name}ControllerTest {

    @Autowired
    private MockMvc mvc;

    @MockBean
    private ${domain.name}Service ${domain.name?lower_case}Service;

    //implement tests here
    @Test
    public void someTest() {
        
    }

    /**
     * Helper function to turn obj -> JSON
     */
    private static String asJsonString(final Object obj) {
        try {
            final ObjectMapper mapper = new ObjectMapper();
            final String jsonContent = mapper.writeValueAsString(obj);
            return jsonContent;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
