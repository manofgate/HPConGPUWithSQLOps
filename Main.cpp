
#include <cstdlib>
#include <sqlite3.h> 
#include <stdio.h>
#include <string>
#include <sys/time.h>
#include <time.h>

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

	struct timeval sTime;
	struct timezone tzz;
	
    struct timeval startTimeS;
    struct timeval timeD;
    
	struct timeval stopTimeS;
	struct timeval stopTimeO;
	struct timeval stopTimeO2;
	struct timeval stopTimeU;
	struct timeval startTimeO;
	struct timeval startTimeO2;
	struct timeval startTimeU;
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
	zErrMsg = 0;
	/* Execute select basic  statement */
	gettimeofday(&startTimeS, &tzz);
   result = sqlite3_exec(db, sql.c_str(), callback, (void*)data, &zErrMsg);
   gettimeofday(&stopTimeS, &tzz);
    if( result != SQLITE_OK ){
      fprintf(stderr, "SQL error: %s\n", zErrMsg);
      sqlite3_free(zErrMsg);
   }else{
      fprintf(stdout, "Operation 1 done successfully\n");
   }
	
	gettimeofday(&startTimeO, &tzz);
	sql = "select * from customers ORDER BY address;"; 
	zErrMsg = 0;
	/* Execute select order by statement */
   result = sqlite3_exec(db, sql.c_str(), callback, (void*)data, &zErrMsg);
   gettimeofday(&stopTimeO, &tzz);
    if( result != SQLITE_OK ){
      fprintf(stderr, "SQL error: %s\n", zErrMsg);
      sqlite3_free(zErrMsg);
   }else{
      fprintf(stdout, "Operation 2 done successfully\n");
   }
	gettimeofday(&startTimeO2, &tzz);
	sql = "select * from customers ORDER BY accnum;"; 
	zErrMsg = 0;
	/* Execute select group by statement */
   result = sqlite3_exec(db, sql.c_str(), callback, (void*)data, &zErrMsg);
   gettimeofday(&stopTimeO2, &tzz);
    if( result != SQLITE_OK ){
      fprintf(stderr, "SQL error: %s\n", zErrMsg);
      sqlite3_free(zErrMsg);
   }else{
      fprintf(stdout, "Operation  3 done successfully\n");
   }
	gettimeofday(&startTimeU, &tzz);
	//sql = "UPDATE customers SET age=26 WHERE age=23;"; 
	sql = "UPDATE customers SET age=23 WHERE age=26;"; 
	zErrMsg = 0;
	/* Execute update  statement */
   result = sqlite3_exec(db, sql.c_str(), callback, (void*)data, &zErrMsg);
   gettimeofday(&stopTimeU, &tzz);
    if( result != SQLITE_OK ){
      fprintf(stderr, "SQL error: %s\n", zErrMsg);
      sqlite3_free(zErrMsg);
   }else{
      fprintf(stdout, "Operation 4 done successfully\n");
   }


   sqlite3_close(db);
   
   timersub(&stopTimeS, &startTimeS, &timeD);
  double timeElasp = timeD.tv_sec*1000000.0+(timeD.tv_usec);
  printf("time elasped for select all is: %f.%f \n", timeD.tv_sec,timeD.tv_usec);
  
  timersub(&stopTimeO, &startTimeO, &timeD);
  timeElasp = timeD.tv_sec*1000000.0+(timeD.tv_usec);
  printf("time elasped for select order by: %f.%f \n", timeD.tv_sec,timeD.tv_usec);
  
  timersub(&stopTimeO2, &startTimeO2, &timeD);
  timeElasp = timeD.tv_sec*1000000.0+(timeD.tv_usec);
  printf("time elasped for 2nd select order by: %f.%f \n", timeD.tv_sec,timeD.tv_usec);
  
  timersub(&stopTimeU, &startTimeU, &timeD);
  timeElasp = timeD.tv_sec*1000000.0+(timeD.tv_usec);
  printf("time elasped for updating is: %f.%f \n", timeD.tv_sec,timeD.tv_usec);
   system("pause");
}
