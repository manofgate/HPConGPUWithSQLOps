
all:
	./project.sh

main:
	gcc -c sqlite3.c -lpthread -ldl
	g++ Main.cpp -I. sqlite3.o  -lpthread -lrt -ldl -o sqlstat.exe
	./sqlstat.exe
main2: 
	nvcc -arch sm_20 -dc sqlite3b.cu -lpthread -ldl
	nvcc -arch sm_20  Main2.cu -I. -lpthread -ldl -o sqlstat2.exe
	chmod u+x sqlstat2.exe
	#./sqlstat2.exe
main3: 
	#nvcc -lcudadevrt -rdc=true -arch=sm_35 -dc sqlite3c.cu Main3.cu -lpthread -ldl
	nvcc -arch=sm_35 -dc Main3.cu  -I.
	nvcc -arch=sm_35 -dlink  Main3.o -o link.o
	nvcc Main3.o link.o  -o sqlstat3.exe
	#nvcc  -arch=sm_30 Main3.cu -I.  -lpthread -ldl -o sqlstat3.exe
	#nvcc -lcudadevrt  --ptxas-options=-v -rdc=true -lcudart -arch=sm_35 Main3.cu -I. -lpthread -ldl -o sqlstat3.exe
	chmod u+x sqlstat3.exe
	#./sqlstat3.exe	
