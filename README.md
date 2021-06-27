## Dockerfile - Keycloak - M1 Compatible

[Keycloak](https://www.keycloak.org/)

To build
```
docker build -t torgge/keycloak:1.0
```

Tu use
````
docker run -p 8080:8080 torgge/keycloak:1.0
````
---
### After this...
> access de console
[http://localhost:8080/auth](http://localhost:8080/auth)

>using the credential below

| User    | Password |
| --------|----------|
| admin   | admin    |
