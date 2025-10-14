package ${{ values.java_package_name }};

import io.quarkus.hibernate.orm.panache.PanacheEntity;
import jakarta.persistence.Entity;


@Entity
public class ${{ values.class_name}} extends PanacheEntity {
    public String field;
}
