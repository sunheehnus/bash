#!/bin/bash

exec 3> test3
exec 4> test4
exec 5< test5

lsof -a -p $$ -d 0,1,2,3,4,5
