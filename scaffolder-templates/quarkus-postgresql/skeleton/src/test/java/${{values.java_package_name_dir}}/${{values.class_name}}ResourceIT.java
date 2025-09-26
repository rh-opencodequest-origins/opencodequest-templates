package ${{ values.java_package_name }};

import io.quarkus.test.junit.QuarkusIntegrationTest;

@QuarkusIntegrationTest
class ${{ values.class_name}}ResourceIT extends ${{ values.class_name}}ResourceTest {
    // Execute the same tests but in packaged mode.
}
