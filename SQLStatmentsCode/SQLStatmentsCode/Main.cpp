
#include <cstdlib>
#include <sqlite3.h> 
#include <stdio.h>

using namespace std;

int main(int argc, char* argv[]) {
	sqlite3 *db;
	int result = sqlite3_open("project.db", &db);
	if(result){
		fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
}else{
	fprintf(stderr, "Opened database successfully\n");
   }
   sqlite3_close(db);
}