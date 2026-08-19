# Security Policy Override

This file defines the preferred security architecture for the modular skill pack.

It does not delete the upstream `SECURITY.md`; that file remains useful for broader Spring Security examples. When recommendations conflict, this policy wins.

## Preferred order

### 1. External identity provider

For Keycloak or another OIDC/OAuth2 provider, prefer Spring Security OAuth2 Resource Server.

Typical backend responsibility:

- validate bearer tokens;
- validate issuer/signature/expiry;
- map scopes/roles/claims to Spring authorities;
- authorize endpoints/methods.

Avoid a custom JWT parsing filter when Spring Security already models the protocol.

### 2. OAuth2/OIDC login

For browser/social login, explicitly decide:

- server session;
- BFF;
- SPA token architecture.

Do not disable CSRF merely because "JWT exists"; CSRF posture depends on credential transport and browser behavior.

### 3. First-party JWT

If this service must issue its own tokens, prefer Spring Security-native JWT primitives where practical.

Define:

- access-token lifetime;
- refresh strategy;
- signing key rotation;
- revocation/session semantics;
- audience/issuer;
- clock skew;
- logout behavior.

### 4. Custom filter/JJWT

Use a custom `OncePerRequestFilter` + third-party JWT library only when requirements make the native path insufficient or the project already intentionally uses that architecture.

## Authorization

Prefer explicit authorities/scopes/roles.

Use method security for business operations when URL rules alone are too coarse.

Ownership checks belong close to business authorization logic, not only in frontend code.

## Secrets

Never commit:

- signing private keys;
- JWT HMAC secrets;
- OAuth client secrets;
- passwords;
- refresh tokens;
- `.env`.

## Minimum security tests

For a protected feature, cover:

- public path works anonymously;
- protected path rejects anonymous access;
- authenticated allowed role succeeds;
- wrong role/scope is forbidden;
- invalid/expired token behavior where practical.
