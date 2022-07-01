package de.${app.packageName?lower_case}.rest.integration;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.json.JacksonTester;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.http.HttpStatus;
import org.springframework.mock.web.MockHttpServletResponse;

import de.${app.packageName?lower_case}.persistence.entity.${entity.name}Entity;
import de.${app.packageName?lower_case}.rest.controller.${entity.name}Controller;
import de.${app.packageName?lower_case}.service.impl.${entity.name}Service;

/**
 * Tests for ${entity.name}Controller
 *
 * <pre>
 * @WebMvcTest also auto-configures MockMvc which offers a powerful way of
 * easy testing MVC controllers without starting a full HTTP server.
 * </pre>
 */
@WebMvcTest(controllers = ${entity.name}Controller.class)
public class ${entity.name}ControllerIntegrationTest extends AbstractControllerIntegrationTest<${entity.name}Entity> {

    @MockBean
    private ${entity.name}Service ${entity.name?lower_case}Service;

    private JacksonTester<${entity.name}Entity> json${entity.name}Entity;
    private static final String data = "testdata/${entity.name?lower_case}/";
    private static final String restpath = "/api/${entity.name?lower_case}s/";

    @Override
    public Class<${entity.name}Entity> getEntityClass() {
        return ${entity.name}Entity.class;
    }

    @Override
    public String getRestPath() {
        return restpath;
    }

    //implement tests here
    @Test
    public void canRetrieveById() throws Exception {

//        ${entity.name}Entity entityToTest = readFromFile(data + "${entity.name?lower_case}.json");
//        when(appService.findById(0L)).thenReturn(entityToTest);

//        MockHttpServletResponse response = retrieveById(0L);

        // then
//        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
//        assertThat(response.getContentAsString())
//                .isEqualTo(jsonAppDto.write(dto).getJson());
    }

}
