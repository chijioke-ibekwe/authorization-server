package dev.chijiokeibekwe.authserver.repository;

import dev.chijiokeibekwe.authserver.entity.Role;
import dev.chijiokeibekwe.authserver.enums.RoleName;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoleRepository extends JpaRepository<Role, Long> {

    Optional<Role> findByName(RoleName name);
}