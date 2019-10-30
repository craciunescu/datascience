# Proceso que he seguido y cosas que he hecho para proyecto.
- Registrarse para obtener una cuenta de twitter developer.
- Seguir tutorial en 
    https://developer.twitter.com/en/docs/basics/getting-started
- En sección de "Keys and Tokens" dentro de app, obtener clave y secreto.
    - Ejecutar siguiente comando para obtener token de autenticación
      
      curl -u 'API key:API secret key' \
      --data 'grant_type=client_credentials' \
      'https://api.twitter.com/oauth2/token'

    - Yo he obtenido el siguiente token
    AAAAAAAAAAAAAAAAAAAAAORQAgEAAAAANJyBdogpICtQG5NfoPhrA7OZ3tg%3DSicwwARPAIvRiN5sFLgt8azrVugSTpA6lUvc94b0BEicY6BnCq
