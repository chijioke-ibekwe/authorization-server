package dev.chijiokeibekwe.authserver.service;

import dev.chijiokeibekwe.authserver.dto.UserRegistrationRequest;
import dev.chijiokeibekwe.authserver.dto.UserResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface UserService {

    UserResponse registerUser(UserRegistrationRequest request);

    Page<UserResponse> getAllUsers(Pageable pageable);
}
