import com.example.ug_javamidterm.Vacancy;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Test;

import javax.persistence.*;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class SimpleTest {

    @Test
    void test_db_writing() {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        EntityTransaction entityTransaction = entityManager.getTransaction();

        try {
            entityTransaction.begin();

            Vacancy vacancy  = new Vacancy();
            vacancy.setTitle("Test Vacancy");
            vacancy.setDescription("TV Description");
            vacancy.setType("TV Type");
            vacancy.setSalary(4096);

            entityManager.persist(vacancy);

            entityTransaction.commit();

            TypedQuery<Vacancy> test_query = entityManager.createQuery(
                    "SELECT v FROM Vacancy v WHERE v.title = :title", Vacancy.class
            );
            Vacancy result = test_query.setParameter("title", "Test Vacancy")
                    .getSingleResult();

            assertNotNull(result);

        } finally {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            entityManager.close();
            entityManagerFactory.close();
        }
    }


    @Test
    void test_db_update() {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        EntityTransaction entityTransaction = entityManager.getTransaction();

        try {
            entityTransaction.begin();

            TypedQuery<Vacancy> test_query = entityManager.createQuery(
                    "SELECT v FROM Vacancy v WHERE v.title = :title", Vacancy.class
            );
            Vacancy result = test_query.setParameter("title", "Test Vacancy")
                    .setMaxResults(1)
                    .getSingleResult();

            result.setSalary(50000);

            entityManager.persist(result);

            entityTransaction.commit();


            entityTransaction.begin();

            TypedQuery<Vacancy> test_query_afterupd = entityManager.createQuery(
                    "SELECT v FROM Vacancy v WHERE v.title = :title", Vacancy.class
            );
            Vacancy result_afterupd = test_query_afterupd.setParameter("title", "Test Vacancy")
                    .setMaxResults(1)
                    .getSingleResult();

            assertEquals(50000, result_afterupd.getSalary());

        } finally {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            entityManager.close();
            entityManagerFactory.close();
        }
    }

    @AfterAll
    static void clean_db() {

        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        EntityTransaction entityTransaction = entityManager.getTransaction();

        try {
            entityTransaction.begin();

            Query delete_query = entityManager.createQuery(
                    "DELETE FROM Vacancy v WHERE v.title = :title");

            delete_query.setParameter("title", "Test Vacancy").executeUpdate();

        } finally {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            entityManager.close();
            entityManagerFactory.close();
        }

    }
}
