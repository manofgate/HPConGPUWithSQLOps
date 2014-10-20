
all:
	./project.sh

main:
	gcc -c sqlite3.c
	g++ Main.cpp sqlite3.o -I. -o sqlstat.exe
	./sqlstat.exe
	
	