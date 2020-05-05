#!/bin/bash
if [ "$#" -lt 3 ]; then
        echo $0 'dbTFfile counterVariable number of database your want'
        echo $0 dbs.tf db_count 5
        exit
fi
dbTF=$1
countVar=$2
n=$3
for((i=`terraform show -no-color | egrep -c '^resource "oci_database_database'`;i<$n;i++));do
	export TF_VAR_$countVar=$(($i+1))
	terraform apply -auto-approve -no-color
done
sed -i "/variable \"$countVar\"/s/default=./default=$i/" $dbTF
