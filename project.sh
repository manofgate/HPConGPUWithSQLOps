#!/bin/bash
	sqlite3 project.db ".dump"
	rm project.db
	sqlite3 project.db < customersScript
	sqlite3 project.db < itemsScript
	sqlite3 project.db < ordersScript
	sqlite3 project.db "insert into customers (id,name,address,age,accnum) values (1,'Anderson','12 Arapahoe st',23,4576)"

