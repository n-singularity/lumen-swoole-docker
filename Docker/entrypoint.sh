#!/bin/bash

if [! -f "vendor/autoload.php"]; then
    composer install --no-progress --no-iteration
fi

if [! -f ".env"]; then
    echo "creating env file for env $APP_ENV"
    cp .env.example .env
else
    echo "env file exist."
fi

php artisan migrate
php artisan cache:clear

php artisan swoole:http start
exec docker-php-entrypoint "$@"



