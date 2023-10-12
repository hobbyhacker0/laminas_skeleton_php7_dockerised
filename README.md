
# Prerequisites:
docker
git
composer

# Run these commands in order to get going:

# 1. Create skeleton app using composer (or clone app skeleton code)
composer create-project -s dev laminas/laminas-mvc-skeleton
mv laminas-mvc-skeleton app
# or clone directly, eg for older versions:
git clone https://github.com/laminas/laminas-mvc-skeleton.git app
# php-7.4.3 compatible version
git checkout 622c9899e0e9d2d 

# 2. Use docker compose definition to run composer install inside container
docker-compose run app composer install
# or: start a composer container & install, preserving the vendor output folder in app
cd app && docker run --rm -v $(pwd):/app composer install

# 3. Create new .env file from example
cp .env.example .env

# 4. Change ownership for non-root user
cd .. && sudo chown -R www-data:www-data ./app

