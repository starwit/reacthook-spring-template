package de.${app.packagePrefix?lower_case}.persistence.repository;

import de.${app.packagePrefix?lower_case}.persistence.entity.${domain.name}Entity;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.context.junit4.SpringRunner;

import static org.junit.Assert.*;

/**
 * Tests for ${domain.name}Repository
 */
@RunWith(SpringRunner.class)
@DataJpaTest
public class ${domain.name}RepositoryTest {

    @Autowired
    private TestEntityManager entityManager;

    @Autowired
    private ${domain.name}Repository ${domain.name?lower_case}Repository;

    //implement tests here
    @Test
    public void someTest() {

    }
}
