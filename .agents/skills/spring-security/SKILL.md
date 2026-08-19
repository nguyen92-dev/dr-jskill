---
name: spring-security
description: Implement Spring Security authentication and authorization: OAuth2/OIDC, Keycloak, JWT resource servers, roles/authorities, method security, CORS/CSRF, session security and auth testing. Prefer native Spring Security over custom JWT filters unless explicitly required.
---

# Spring Security

## Required references

Read:

1. `../../../references/skill-pack/SECURITY-POLICY.md`
2. only the relevant sections of `../../../references/SECURITY.md`

The skill-pack policy overrides older custom-JWT examples when they conflict.

## Choose the authentication model first

Use this preference order when requirements permit:

1. External IdP such as Keycloak/enterprise OIDC:
   - OAuth2 Resource Server;
   - issuer/JWK-based verification;
   - map claims to authorities deliberately.
2. Social login/browser login:
   - OAuth2 Login/OIDC;
   - choose session vs token architecture explicitly.
3. First-party token issuer:
   - prefer Spring Security's JWT encoder/decoder support where suitable.
4. Custom `OncePerRequestFilter` + third-party JWT library:
   - only when requirements cannot be met cleanly by native Spring Security.

Do not silently invent an authentication architecture.

## Workflow

1. Identify client type: SPA, server-rendered web, mobile, service-to-service, mixed.
2. Identify issuer: external IdP, this backend, gateway, none.
3. Decide session vs stateless.
4. Define authentication boundary.
5. Define authorization model:
   - roles;
   - authorities/scopes;
   - ownership checks;
   - method security where useful.
6. Define token/session lifecycle and logout/revocation expectations.
7. Configure CORS and CSRF according to the chosen architecture, not by cargo cult.
8. Add security tests for public/protected/forbidden paths.

## Secret handling

Never commit or print client secrets, signing secrets, passwords, `.env`, private keys, or refresh tokens.

## Validation

Test at least:

- anonymous access to public endpoint;
- unauthenticated access to protected endpoint;
- authenticated happy path;
- forbidden role/scope path;
- token/session invalid/expired behavior where practical.
