#!/bin/bash

mysql -h127.0.0.1 -uroot '123456' -N -s -e "set names utf8;
    LOAD DATA LOCAL INFILE \"${1}\"
    INTO TABLE databasesName.tableName
    FIELDS TERMINATED BY '\t' ENCLOSED BY '' ESCAPED BY ''
    LINES TERMINATED BY '\n'
    (id, mark_id, is_valid, exec_location, exec_money, identification, name, time);"
