package ${{ values.java_package_name }};

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/${{ values.component_id }}")
public class ${{ values.class_name}}Controller {

    @GetMapping
    public String hello() {
        return "Hello Quarkus Spring";
    }
}
