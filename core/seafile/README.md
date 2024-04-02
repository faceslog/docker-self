# Other stuff

> Edit seahub config

```sh
nano ./seafile-data/seafile/conf/seahub_settings.py
```

> To fix CSRF verification failed. Request aborted.

```sh
CSRF_TRUSTED_ORIGINS = ['https://sf.example.com'] 
```

> To enable email add:

```sh
EMAIL_USE_TLS = True
EMAIL_HOST = ''
EMAIL_HOST_USER = ''
EMAIL_HOST_PASSWORD = ''
EMAIL_PORT = 587
DEFAULT_FROM_EMAIL = ""
SERVER_EMAIL = DEFAULT_FROM_EMAIL
```