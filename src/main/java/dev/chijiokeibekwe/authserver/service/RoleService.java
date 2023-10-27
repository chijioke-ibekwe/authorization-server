package dev.chijiokeibekwe.authserver.service;

import dev.chijiokeibekwe.authserver.entity.Role;
import dev.chijiokeibekwe.authserver.enums.UserType;

public interface RoleService {

    Role getRoleByUserType(UserType userType);
}
