INSERT INTO groups (name, description) VALUES ('user', 'Permissions pertaining to the user service');

INSERT INTO permissions (name, description, group_id) VALUES (
'users:verify',
'Permission to verify a user',
(SELECT id FROM groups WHERE name = 'user')
), (
'users:read',
'Permission to fetch all users',
(SELECT id FROM groups WHERE name = 'user')
);

INSERT INTO roles (name, description) VALUES ('role_admin', 'Role for users that carry out administrative functions on the application');
INSERT INTO roles (name, description) VALUES ('role_customer', 'Role for users that are customers on the application');

INSERT INTO permission_role (role_id, permission_id) VALUES (
(SELECT id FROM roles WHERE name = 'role_admin'),
(SELECT id FROM permissions WHERE name = 'users:verify')
), (
(SELECT id FROM roles WHERE name = 'role_admin'),
(SELECT id FROM permissions WHERE name = 'users:read')
);

INSERT INTO "users" (first_name, last_name, username, password, phone_number, verified)
VALUES ('Chijioke', 'Ibekwe', 'admin@auth.com', '{bcrypt}$2a$12$3TlKrpiLq9bRYgdPzbwjvONNlTIFb8WxIIE7ysRoZkIfHFbD/hnim',
'+2348033334444', TRUE);

INSERT INTO user_role (user_id, role_id) VALUES (
(SELECT id FROM "users" WHERE username = 'admin@auth.com'),
(SELECT id FROM roles WHERE name = 'role_admin')
);

INSERT INTO oauth2_registered_client (id, client_id, client_id_issued_at, client_name, client_authentication_methods,
authorization_grant_types, redirect_uris, post_logout_redirect_uris, scopes, client_settings, token_settings)
VALUES ('ba275910-3db0-4bec-b3d6-c7eb2fac90c7', 'user-web-client', CURRENT_TIMESTAMP, 'ba275910-3db0-4bec-b3d6-c7eb2fac90c7',
'none', 'authorization_code', 'http://127.0.0.1:8080/login/oauth2/code/user-web-client-oidc', 'http://127.0.0.1:8080',
'openid,user',
'{"@class":"java.util.Collections$UnmodifiableMap","settings.client.require-proof-key":true,"settings.client.require-authorization-consent":false}',
'{"@class":"java.util.Collections$UnmodifiableMap","settings.token.reuse-refresh-tokens":false,"settings.token.id-token-signature-algorithm":["org.springframework.security.oauth2.jose.jws.SignatureAlgorithm","RS256"],"settings.token.access-token-time-to-live":["java.time.Duration",900.000000000],"settings.token.access-token-format":{"@class":"org.springframework.security.oauth2.server.authorization.settings.OAuth2TokenFormat","value":"self-contained"},"settings.token.refresh-token-time-to-live":["java.time.Duration",3600.000000000],"settings.token.authorization-code-time-to-live":["java.time.Duration",300.000000000]}');