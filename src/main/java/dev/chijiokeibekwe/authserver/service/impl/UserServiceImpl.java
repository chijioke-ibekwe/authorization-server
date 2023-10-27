package dev.chijiokeibekwe.authserver.service.impl;

import dev.chijiokeibekwe.authserver.dto.UserRegistrationRequest;
import dev.chijiokeibekwe.authserver.dto.UserResponse;
import dev.chijiokeibekwe.authserver.entity.Role;
import dev.chijiokeibekwe.authserver.entity.User;
import dev.chijiokeibekwe.authserver.mapper.Mapper;
import dev.chijiokeibekwe.authserver.repository.UserRepository;
import dev.chijiokeibekwe.authserver.service.RoleService;
import dev.chijiokeibekwe.authserver.service.UserService;
import jakarta.persistence.EntityExistsException;
import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    private final RoleService roleService;

    private final PasswordEncoder passwordEncoder;

    @Override
    public UserResponse registerUser(UserRegistrationRequest userRegistrationRequest){

        if(userRepository.existsByUsername(userRegistrationRequest.email()))
            throw new EntityExistsException(String.format("Email %s already exists", userRegistrationRequest.email()));

        Role role = roleService.getRoleByUserType(userRegistrationRequest.type());

        User user = User.builder()
                .firstName(userRegistrationRequest.firstName())
                .lastName(userRegistrationRequest.lastName())
                .username(userRegistrationRequest.email())
                .password(passwordEncoder.encode(userRegistrationRequest.password()))
                .phoneNumber(userRegistrationRequest.phoneNumber())
                .roles(Collections.singleton(role))
                .accountNonExpired(true)
                .accountNonLocked(true)
                .credentialsNonExpired(true)
                .enabled(true)
                .build();

        User savedUser = userRepository.save(user);

        return Mapper.toUserResponse(savedUser);
    }

    @Override
    public Page<UserResponse> getAllUsers(Pageable pageable){

        return userRepository.findAll(pageable).map(Mapper::toUserResponse);
    }
}
