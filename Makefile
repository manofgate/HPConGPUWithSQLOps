
all:
	./project.sh

main:
	gcc -c sqlite3.c -lpthread -ldl
	g++ Main.cpp -I. sqlite3.o  -lpthread -ldl -o sqlstat.exe
	./sqlstat.exe

