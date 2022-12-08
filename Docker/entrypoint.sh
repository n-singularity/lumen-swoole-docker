#!/bin/bash
cp -i .env.example .env

echo "===============[START] Installing php Vendor via Composer==============="
composer install
echo "===============[DONE] Installing php Vendor via Composer==============="

php artisan migrate
php artisan cache:clear

php artisan swoole:http start
exec docker-php-entrypoint "$@"



