package dev.chijiokeibekwe.authserver.dto;

import dev.chijiokeibekwe.authserver.enums.UserType;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;

public record UserRegistrationRequest (
        @NotNull(message = "First name is required")
        String firstName,

        @NotNull(message = "Last name is required")
        String lastName,

        @NotNull(message = "Email is required")
        @Email(message = "Email is not a valid email address")
        String email,

        @NotNull(message = "Password is required")
        String password,

        @NotNull(message = "Phone number is required")
        String phoneNumber,

        @NotNull(message = "User type is required")
        @Enumerated(EnumType.STRING)
        UserType type
){}
