# Configure Directus to use Keycloak as Authentication Provider

POC, run locally using Docker-compose.
Builds a new Directus Docker image, overwriting the Okta Oauth config to work with Keycloak.

Users still need to be pre-created in Directus before they can log in via Keycloak.
Password etc can be left NULL though.

## Services

* Keycloak (admin, secret-admin): <http://localhost:8080/auth/>
* Adminer (autologin): <http://localhost:8083/>
* Directus (admin@example.org, secret-admin): <http://localhost:8081/admin/#/login>

## Local setup

In /etc/hosts, add `127.0.0.1 keycloak`.

Run:

```bash
docker-compose up --build
docker-compose run --rm directus install --email admin@example.org --password secret-admin
```

## Config

Config Keycloak:
* Add Realm
  * "directus"
* Users -> Add
  * "test", "test@example.org"
  * Credentials -> Set Password "secret-test", temporary = Off
* Create client
  * "directus"
  * Access Type: "confidential"
  * Redirect URI: `http://localhost:8081/*`
  * Save
  * Go to "Credentials" and copy to docker-compose.yml
* Restart docker-compose

Config Directus:
* Create new Role "Users"
  * Add Collections
* Create user at <http://localhost:8081/admin/#/_/users/+>
  * test@example.org
  * Status: "Active"
  * Role: "Users"

You can now login as test@example.org through Okta.

http://localhost:8082/auth/realms/directus/.well-known/openid-configuration

Example user entry:

```sql
INSERT INTO `directus_users` (
    `id`,
    `status`,
    `role`,
    `first_name`,
    `last_name`,
    `email`,
    `password`,
    `token`,
    `timezone`,
    `locale`,
    `locale_options`,
    `avatar`,
    `company`,
    `title`,
    `email_notifications`,
    `last_access_on`,
    `last_page`,
    `external_id`,
    `theme`,
    `2fa_secret`,
    `password_reset_token`
)
VALUES
(
    2
    'active'
    3
    'test'
    'test'
    'test@example.org'
    NULL
    '1LfDSHUWkA6WLvR7QscmtYvH'
    'UTC'
    NULL
    NULL
    NULL
    NULL
    NULL
    1
    '2020-09-07 21:05:20'
    '/_/collections/anlage'
    '6948fd8a-cfe7-44f8-9861-6ee195823fbc'
    'auto'
    NULL
    NULL
);
```
