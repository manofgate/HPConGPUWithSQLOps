
all:
	./project.sh

main:
	gcc -c sqlite3.c -lpthread -ldl
	g++ Main.cpp -I. sqlite3.o  -lpthread -lrt -ldl -o sqlstat.exe
	./sqlstat.exe
main2: 
	nvcc -arch sm_20 -dc sqlite3b.cu -lpthread -ldl
	nvcc -arch sm_20  Main2.cu -I. -lrt -lpthread -ldl -o sqlstat2.exe
	chmod u+x sqlstat2.exe
	./sqlstat2.exe
main3: 
	nvcc -arch sm_20 -dc sqlite3c.cu -lpthread -ldl
	nvcc -arch sm_20 Main3.cu -I. -lrt -lpthread -ldl -o sqlstat3.exe
	chmod u+x sqlstat3.exe
	./sqlstat3.exe	
