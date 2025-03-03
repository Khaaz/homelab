Replace "thisismypassword" to your password

`node -e "const argon2 = require('argon2'); argon2.hash('thisismypassword').then(hash => console.log(hash))"`

This will output something like 

`$argon2id$v=19$m=65536,t=3,p=4$IL0YwjYlI20moDRfXqq8Jg$m4f6K8BXd92SnQ9C7/Ecqgq0qXkzXrMxViA07kpJrg0`

You need to put that inside the _setup/templates/config.yaml
