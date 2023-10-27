package dev.chijiokeibekwe.authserver.mapper;

import dev.chijiokeibekwe.authserver.dto.CustomUserDetails;
import dev.chijiokeibekwe.authserver.dto.GroupGrantedAuthority;
import dev.chijiokeibekwe.authserver.dto.RoleResponse;
import dev.chijiokeibekwe.authserver.dto.UserResponse;
import dev.chijiokeibekwe.authserver.entity.User;
import org.springframework.beans.BeanUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.*;

public class Mapper {

    public static CustomUserDetails toCustomUserDetails(User user){

        CustomUserDetails customUserDetails = new CustomUserDetails();
        BeanUtils.copyProperties(user, customUserDetails);

        List<GroupGrantedAuthority> authorities = new ArrayList<>();

        user.getRoles().forEach(r -> {
            authorities.add(new GroupGrantedAuthority(r.getName().getValue(), r.getName().getValue()));

            r.getPermissions().forEach(p ->  {
                if(user.isVerified() || !p.isRequiresVerification())
                    authorities.add(new GroupGrantedAuthority(p.getGroup().getName(), p.getName()));
            });
        });

        customUserDetails.setAuthorities(authorities);
        return customUserDetails;
    }

    public static UserResponse toUserResponse(User user) {
        UserResponse userResponse = new UserResponse();
        BeanUtils.copyProperties(user, userResponse, "roles");

        List<RoleResponse> roles = new ArrayList<>();

        user.getRoles().forEach(role -> {
            RoleResponse roleResponse = new RoleResponse();
            BeanUtils.copyProperties(role, roleResponse, "permissions");

            List<String> permissions = new ArrayList<>();
            role.getPermissions().forEach(p -> permissions.add(p.getName()));
            roleResponse.setPermissions(permissions);
            roles.add(roleResponse);
        });

        userResponse.setRoles(roles);
        return userResponse;
    }
}
