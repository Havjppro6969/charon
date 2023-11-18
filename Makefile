setup:
	

composer-install:
	docker run --rm \
    -u "$(id -u):$(id -g)" \
    -v "$(pwd):/var/www/html" \
    -w /var/www/html \
    laravelsail/php82-composer:latest \
    composer install --ignore-platform-reqs

docker-setup:
	@make docker-up

docker-up:
	./vendor/bin/sail up -d

docker-stop:
	./vendor/bin/sail stop

docker-migrate:
	docker exec charon-Charon-1 bash -c "php artisan migrate"

docker-seed:
	docker exec charon-Charon-1 bash -c "php artisan db:seed"

docker-data:
	@make docker-migrate
	@make docker-seed

data:
	php artisan migrate
	php artisan db:seed

up:
	php artisan serve

generate-key:
	php artisan key:generate