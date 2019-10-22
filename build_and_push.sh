#!/bin/bash

docker login

docker build -t jsantoso/php-7.3-apache:latest .

docker push jsantoso/php-7.3-apache:latest