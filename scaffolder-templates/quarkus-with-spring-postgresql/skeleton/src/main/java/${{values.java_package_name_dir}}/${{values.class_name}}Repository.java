package ${{ values.java_package_name }};

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ${{ values.class_name}}Repository extends JpaRepository<${{ values.class_name}}, Long> {

}
