CREATE TABLE groups (
    id              BIGSERIAL NOT NULL,
    description     VARCHAR(255),
    name            VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE permissions (
    id                      BIGSERIAL NOT NULL,
    description             VARCHAR(255),
    name                    VARCHAR(255),
    requires_verification   BOOLEAN DEFAULT false,
    group_id                INT8,
    PRIMARY KEY (id)
);

CREATE TABLE permission_role (
    role_id         INT8 NOT NULL,
    permission_id   INT8 NOT NULL,
    PRIMARY KEY (role_id, permission_id)
);

CREATE TABLE roles (
    id              BIGSERIAL NOT NULL,
    description     VARCHAR(255),
    name            VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE users (
    id                                  BIGSERIAL NOT NULL,
    first_name                          VARCHAR(255),
    last_name                           VARCHAR(255),
    username                            VARCHAR(255),
    password                            VARCHAR(255),
    phone_number                        VARCHAR(255),
    account_non_expired                 BOOLEAN DEFAULT true,
    account_non_locked                  BOOLEAN DEFAULT true,
    credentials_non_expired             BOOLEAN DEFAULT true,
    enabled                             BOOLEAN DEFAULT true,
    verified                            BOOLEAN DEFAULT false,
    PRIMARY KEY (id)
);

CREATE TABLE user_role (
    user_id         INT8 NOT NULL,
    role_id         INT8 NOT NULL,
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE IF NOT EXISTS oauth2_registered_client (
    id                              VARCHAR(100) NOT NULL,
    client_id                       VARCHAR(100) NOT NULL,
    client_id_issued_at             TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    client_secret                   VARCHAR(200) DEFAULT NULL,
    client_secret_expires_at        TIMESTAMP DEFAULT NULL,
    client_name                     VARCHAR(200) NOT NULL,
    client_authentication_methods   VARCHAR(1000) NOT NULL,
    authorization_grant_types       VARCHAR(1000) NOT NULL,
    redirect_uris                   VARCHAR(1000) DEFAULT NULL,
    post_logout_redirect_uris       VARCHAR(1000) DEFAULT NULL,
    scopes                          VARCHAR(1000) NOT NULL,
    client_settings                 VARCHAR(2000) NOT NULL,
    token_settings                  VARCHAR(2000) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS oauth2_authorization (
    id                                  VARCHAR(100) NOT NULL,
    registered_client_id                VARCHAR(100) NOT NULL,
    principal_name                      VARCHAR(200) NOT NULL,
    authorization_grant_type            VARCHAR(100) NOT NULL,
    authorized_scopes                   VARCHAR(1000) DEFAULT NULL,
    attributes                          TEXT DEFAULT NULL,
    state                               VARCHAR(500) DEFAULT NULL,
    authorization_code_value            TEXT DEFAULT NULL,
    authorization_code_issued_at        TIMESTAMP DEFAULT NULL,
    authorization_code_expires_at       TIMESTAMP DEFAULT NULL,
    authorization_code_metadata         TEXT DEFAULT NULL,
    access_token_value                  TEXT DEFAULT NULL,
    access_token_issued_at              TIMESTAMP DEFAULT NULL,
    access_token_expires_at             TIMESTAMP DEFAULT NULL,
    access_token_metadata               TEXT DEFAULT NULL,
    access_token_type                   VARCHAR(100) DEFAULT NULL,
    access_token_scopes                 VARCHAR(1000) DEFAULT NULL,
    oidc_id_token_value                 TEXT DEFAULT NULL,
    oidc_id_token_issued_at             TIMESTAMP DEFAULT NULL,
    oidc_id_token_expires_at            TIMESTAMP DEFAULT NULL,
    oidc_id_token_metadata              TEXT DEFAULT NULL,
    refresh_token_value                 TEXT DEFAULT NULL,
    refresh_token_issued_at             TIMESTAMP DEFAULT NULL,
    refresh_token_expires_at            TIMESTAMP DEFAULT NULL,
    refresh_token_metadata              TEXT DEFAULT NULL,
    user_code_value                     TEXT DEFAULT NULL,
    user_code_issued_at                 TIMESTAMP DEFAULT NULL,
    user_code_expires_at                TIMESTAMP DEFAULT NULL,
    user_code_metadata                  TEXT DEFAULT NULL,
    device_code_value                   TEXT DEFAULT NULL,
    device_code_issued_at               TIMESTAMP DEFAULT NULL,
    device_code_expires_at              TIMESTAMP DEFAULT NULL,
    device_code_metadata                TEXT DEFAULT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS oauth2_authorization_consent (
    registered_client_id    VARCHAR(100) NOT NULL,
    principal_name          VARCHAR(200) NOT NULL,
    authorities             VARCHAR(1000) NOT NULL,
    PRIMARY KEY (registered_client_id, principal_name)
);

ALTER TABLE users ADD CONSTRAINT uk_username UNIQUE (username);

ALTER TABLE permissions ADD CONSTRAINT fk_permissions_groups FOREIGN KEY (group_id) REFERENCES groups;

ALTER TABLE permission_role ADD CONSTRAINT fk_permission_role_permissions FOREIGN KEY (permission_id) REFERENCES permissions;

ALTER TABLE permission_role ADD CONSTRAINT fk_permission_role_roles FOREIGN KEY (role_id) REFERENCES roles;

ALTER TABLE user_role ADD CONSTRAINT fk_user_role_roles FOREIGN KEY (role_id) REFERENCES roles;

ALTER TABLE user_role ADD CONSTRAINT fk_user_role_users FOREIGN KEY (user_id) REFERENCES users;