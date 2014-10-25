
#include <cstdlib>
#include <sqlite3.h> 
#include <stdio.h>
#include <string>
#include <time.h>
#include <iostream>


using namespace std;

static int callback(void *NotUsed, int argc, char **argv, char **azColName){
   int i;
   for(i=0; i<argc; i++){
      printf("%s = %s : ", azColName[i], argv[i] ? argv[i] : "NULL");
   }
   printf("\n");
   return 0;
}

int main(int argc, char* argv[]) {
	sqlite3 *db;
	char *zErrMsg = 0;
	srand (time(NULL));

	time_t startTimeS;
	time_t stopTimeS;

	time_t startTimeO;
	time_t stopTimeO;
	
	time_t startTimeU;
	time_t stopTimeU;
	
	time_t startTimeO2;
	time_t stopTimeO2;

	int result = sqlite3_open("project.db", &db);
	if(result){
		fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
}else{
	fprintf(stderr, "Opened database successfully\n");
   }
	const char* data = "Callback function called";
	startTimeS= time(NULL);
	string sql = "select * from customers;"; 
	zErrMsg = 0;
	/* Execute select basic  statement */
   result = sqlite3_exec(db, sql.c_str(), callback, (void*)data, &zErrMsg);
   stopTimeS= time(NULL);
    if( result != SQLITE_OK ){
      fprintf(stderr, "SQL error: %s\n", zErrMsg);
      sqlite3_free(zErrMsg);
   }else{
      fprintf(stdout, "Operation 1 done successfully\n");
   }
	startTimeO= time(NULL);
	sql = "select * from customers ORDER BY address;"; 
	zErrMsg = 0;
	/* Execute select order by statement */
   result = sqlite3_exec(db, sql.c_str(), callback, (void*)data, &zErrMsg);
   stopTimeO= time(NULL);
    if( result != SQLITE_OK ){
      fprintf(stderr, "SQL error: %s\n", zErrMsg);
      sqlite3_free(zErrMsg);
   }else{
      fprintf(stdout, "Operation 2 done successfully\n");
   }
	startTimeO2= time(NULL);
	sql = "select * from customers ORDER BY accnum;"; 
	zErrMsg = 0;
	/* Execute select group by statement */
   result = sqlite3_exec(db, sql.c_str(), callback, (void*)data, &zErrMsg);
   stopTimeO2= time(NULL);
    if( result != SQLITE_OK ){
      fprintf(stderr, "SQL error: %s\n", zErrMsg);
      sqlite3_free(zErrMsg);
   }else{
      fprintf(stdout, "Operation  3 done successfully\n");
   }
	startTimeU= time(NULL);
	//sql = "UPDATE customers SET age=26 WHERE age=23;"; 
	sql = "UPDATE customers SET age=23 WHERE age=26;"; 
	zErrMsg = 0;
	/* Execute update  statement */
   result = sqlite3_exec(db, sql.c_str(), callback, (void*)data, &zErrMsg);
   stopTimeU= time(NULL);
    if( result != SQLITE_OK ){
      fprintf(stderr, "SQL error: %s\n", zErrMsg);
      sqlite3_free(zErrMsg);
   }else{
      fprintf(stdout, "Operation 4 done successfully\n");
   }
	cout << "execution time for the select all: "  << startTimeS << " : " << stopTimeS << " : " << difftime(stopTimeS, startTimeS)<< endl;
	cout << "execution time for the select order by 1st: "  << startTimeO << " : " << stopTimeO << " : " << difftime(stopTimeO, startTimeO)<< endl;
	cout << "execution time for the select order by 2nd: "  << startTimeO2 << " : " << stopTimeO2 << " : " << difftime(stopTimeO2, startTimeO2)<< endl;
	cout << "execution time for the update:  "  << startTimeU << " : " << stopTimeU << " : " << difftime(stopTimeU, startTimeU)<< endl;
	//printf("execution time for the select all: %s , %s , %s\n", difftime(stopTimeS, startTimeS), startTimeS, stopTimeS);
	//printf( "execution time for the select order by 1st: %s\n", difftime(stopTimeO, startTimeO));
	//printf( "execution time for the select order by 2nd: %s\n", difftime(stopTimeO2, startTimeO2));
	//printf( "execution time for the update: %s\n", difftime(stopTimeU, startTimeU));
   sqlite3_close(db);
   system("pause");
}