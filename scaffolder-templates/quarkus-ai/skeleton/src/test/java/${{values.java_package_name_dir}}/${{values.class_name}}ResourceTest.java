package ${{ values.java_package_name }};

import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;

@QuarkusTest
class ${{ values.class_name }}ResourceTest {
    @Test
    void testHelloEndpoint() {
        given()
          .when().get("/api/${{ values.component_id }}")
          .then()
             .statusCode(200)
             .body(is("Hello from Quarkus REST"));
    }

}