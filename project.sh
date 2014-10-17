#!/bin/bash
	sqlite3 project.db ".dump"
	rm project.db
	sqlite3 project.db < customersScript
	sqlite3 project.db < itemsScript
	sqlite3 project.db < ordersScript
	sqlite3 project.db "insert into customers (id,name,address,age,accnum) values (1,'Anderson','12 Arapahoe st',23,4576)"
	filename='us-500.csv'
	#filelines=`cat $filename`
	#echo $filelines
	
	#while IFS=, read col1 col2 col3 col4 col5 col6 col7 col8
	#do
    #echo "I got:$col1|$col2"
	#done < us-500.csv
	
	
	awk -F "," '
{
    fname = $1
	lname = $2
    address = $3
	city = $4
	accnum= $6
	id= $9
	print "insert into customers (id,name,address,city,age,accnum) values ("id",'\''" fname,lname "'\'','\''" address"'\'','\''"city"'\'',23,"accnum");"
}' us-500.csv > tmp.txt
	sqlite3 project.db < tmp.txt
	#rm tmp.txt
	#for line in $filelines ; do
	#	echo `$line`
	#done

