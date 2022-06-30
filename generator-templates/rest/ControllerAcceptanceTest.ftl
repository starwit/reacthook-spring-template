package de.${app.packageName?lower_case}.rest.acceptance;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.json.JacksonTester;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;

import de.${app.packageName?lower_case}.persistence.entity.${entity.name}Entity;

@SpringBootTest
@EnableAutoConfiguration
@AutoConfigureMockMvc(addFilters = false)
public class ${entity.name}ControllerAcceptanceTest extends AbstractControllerAcceptanceTest<${entity.name}Entity> {


    final static Logger LOG = LoggerFactory.getLogger(${entity.name}ControllerAcceptanceTest.class);
    private static final String data = "testdata/${entity.name?lower_case}/";
    private static final String restpath = "/api/${entity.name?lower_case}s/";

    private JacksonTester<${entity.name}Entity> jsonTester;

    @Override
    public Class<${entity.name}Entity> getEntityClass() {
        return ${entity.name}Entity.class;
    }

    @Override
    public String getRestPath() {
        return restpath;
    }

    @Override
    public JacksonTester<${entity.name}Entity> getJsonTester() {
        return jsonTester;
    }

    @Test
    public void canCreate() throws Exception {
        // given
//        ${entity.name}Entity entity = readFromFile(data + "${entity.name}.json");
  
        // when
//        MockHttpServletResponse response = create(entity);

        // then
//        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
//        ${entity.name}Entity entityresult = mapper.readValue(response.getContentAsString(), ${entity.name}Entity.class);
//        assertThat(entityresult.getBranch()).isEqualTo("v2");
    }

    @Test
    public void isValidated() throws Exception {
        // given
//        ${entity.name}Entity entity = readFromFile(data + "${entity.name}-wrong.json");
  
        // when
//        MockHttpServletResponse response = create(entity);

        // then
//        assertThat(response.getStatus()).isEqualTo(HttpStatus.BAD_REQUEST.value());
    }

    @Test
    public void canNotFindById() throws Exception {
        // when
        MockHttpServletResponse response = mvc
                .perform(get(getRestPath() + "/4242").contentType(MediaType.APPLICATION_JSON)).andReturn()
                .getResponse();

        // then
        assertThat(response.getStatus()).isEqualTo(HttpStatus.NOT_FOUND.value());
    }

    @Test
    public void canRetrieveById() throws Exception {
        // given
//        ${entity.name}Entity entity = readFromFile(data + "${entity.name}.json");
//        MockHttpServletResponse response = create(entity);
//        ${entity.name}Entity entity2 = mapper.readValue(response.getContentAsString(), ${entity.name}Entity.class);

        // when
//        response = retrieveById(entity2.getId());

        // then
//        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
//        ${entity.name}Entity entityresult = mapper.readValue(response.getContentAsString(), ${entity.name}Entity.class);
//        assertThat(dtoresult.getBranch()).isEqualTo("v2");
    }

    @Test
    public void canUpdate() throws Exception {

        // given
//        ${entity.name}Entity entity = readFromFile(data + "${entity.name}.json");
//        MockHttpServletResponse response = create(entity);
//        ${entity.name}Entity entity2 = mapper.readValue(response.getContentAsString(), ${entity.name}Entity.class);

        // when
//        response = update(entity2);

        // then
//        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
//        ${entity.name}Entity entityresult = mapper.readValue(response.getContentAsString(), ${entity.name}Entity.class);
//        assertThat(dtoresult.getBranch()).isEqualTo("v2");
    }

    @Override
    @Test
    public void canDelete() throws Exception {
        // given
//        ${entity.name}Entity entity = readFromFile(data + "${entity.name}.json");
//        MockHttpServletResponse response = create(entity);
//        ${entity.name}Entity entity2 = mapper.readValue(response.getContentAsString(), ${entity.name}Entity.class);
//        response = retrieveById(entity2.getId());
//        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());

        // when
//        delete(entity2.getId());

        // then
//        assertThat(response.getStatus()).isEqualTo(HttpStatus.OK.value());
//        response = retrieveById(entity2.getId());
//        assertThat(response.getStatus()).isEqualTo(HttpStatus.NOT_FOUND.value());
    }

}
