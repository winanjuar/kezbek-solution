#!/bin/bash

for service in authenticator customer loyalty mailer partner promo transaction wallet
do
  echo "running npm install in service ${service}"
  cd $service
  npm install
  cd ..
done