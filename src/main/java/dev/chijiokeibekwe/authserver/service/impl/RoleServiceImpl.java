package dev.chijiokeibekwe.authserver.service.impl;

import dev.chijiokeibekwe.authserver.entity.Role;
import dev.chijiokeibekwe.authserver.enums.RoleName;
import dev.chijiokeibekwe.authserver.enums.UserType;
import dev.chijiokeibekwe.authserver.repository.RoleRepository;
import dev.chijiokeibekwe.authserver.service.RoleService;
import jakarta.persistence.EntityNotFoundException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class RoleServiceImpl implements RoleService {

    private final RoleRepository roleRepository;

    @Override
    public Role getRoleByUserType(UserType userType) {
        RoleName roleName = switch (userType) {
            case CUSTOMER -> RoleName.ROLE_CUSTOMER;
            case VENDOR -> RoleName.ROLE_VENDOR;
        };

        return roleRepository.findByName(roleName).orElseThrow(() -> new
                EntityNotFoundException("Role not found"));
    }
}
