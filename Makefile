
all:
	./project.sh

main:
	gcc -c sqlite3.c -lpthread -ldl
	g++ Main.cpp -I. sqlite3.o  -lpthread -ldl -o sqlstat.exe
	./sqlstat.exe
main2: 
	nvcc -arch sm_20 -dc sqlite3b.cu -lpthread -ldl
	nvcc -arch sm_20  Main2.cu -I. -lpthread -ldl -o sqlstat2.exe
	chmod u+x sqlstat2.exe
	./sqlstat2.exe
	
