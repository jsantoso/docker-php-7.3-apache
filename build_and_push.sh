#!/bin/bash

docker login

docker build -t jsantoso_php-7.3-apache .

docker tag jsantoso_php-7.3-apache jsantoso/php-7.3-apache:latest

docker push jsantoso/php-7.3-apache:latest