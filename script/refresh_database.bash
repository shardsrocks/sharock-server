#!/bin/bash

set -xe

echo 'DROP DATABASE IF EXISTS `sharock`' | mysql -uroot
echo 'CREATE DATABASE `sharock`'         | mysql -uroot

mysql -uroot sharock < sql/table.sql
