
#include <cstdlib>
#include <sqlite3.h> 
#include <stdio.h>
#include <string>

using namespace std;

static int callback(void *NotUsed, int argc, char **argv, char **azColName){
   int i;
   for(i=0; i<argc; i++){
      printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
   }
   printf("\n");
   return 0;
}

int main(int argc, char* argv[]) {
	sqlite3 *db;
	char *zErrMsg = 0;

	int result = sqlite3_open("project.db", &db);
	if(result){
		fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
}else{
	fprintf(stderr, "Opened database successfully\n");
   }
	const char* data = "Callback function called";
	string sql = "select * from customers;"; 
	//sql = ".tables;";
	zErrMsg = 0;
	/* Execute SQL statement */
	//result = sqlite3_exec(db, ".tables", 0, 0, &zErrMsg);
   result = sqlite3_exec(db, sql.c_str(), callback, (void*)data, &zErrMsg);
    if( result != SQLITE_OK ){
      fprintf(stderr, "SQL error: %s\n", zErrMsg);
      sqlite3_free(zErrMsg);
   }else{
      fprintf(stdout, "Operation done successfully\n");
   }


   sqlite3_close(db);
   system("pause");
}