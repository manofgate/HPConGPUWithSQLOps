
#include <cstdlib>
#include <sqlite3c.cu>
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
     FILE *outfile;
     outfile = fopen("output2.txt", "w");
     if(outfile == NULL){
         printf("Unable to open a file.");
     }
     
     for(int i=0; i<5;i++){

	struct timeval sTime;
	struct timezone tzz;
	
    //struct timeval startTimeS;
    struct timespec startTimeS ;
    struct timeval timeD;
    
	//struct timeval stopTimeS;
	struct timespec stopTimeS;
	struct timespec stopTimeO;
	struct timespec stopTimeO2;
	struct timespec stopTimeU;
	struct timespec startTimeO;
	struct timespec startTimeO2;
	struct timespec startTimeU;
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
   clock_gettime(CLOCK_MONOTONIC, &startTimeS);
	//gettimeofday(&startTimeS, &tzz);
   result = sqlite3_exec(db, sql.c_str(), callback, (void*)data, &zErrMsg);
   clock_gettime(CLOCK_MONOTONIC, &stopTimeS);
	//gettimeofday(&stopTimeS, &tzz);
    if( result != SQLITE_OK ){
      fprintf(stderr, "SQL error: %s\n", zErrMsg);
      sqlite3_free(zErrMsg);
   }else{
      fprintf(stdout, "Operation 1 done successfully\n");
   }
	clock_gettime(CLOCK_MONOTONIC, &startTimeO);
	//gettimeofday(&startTimeO, &tzz);
	sql = "select * from customers ORDER BY address;"; 
	zErrMsg = 0;
	/* Execute select order by statement */
   result = sqlite3_exec(db, sql.c_str(), callback, (void*)data, &zErrMsg);
   clock_gettime(CLOCK_MONOTONIC, &stopTimeO);
   //gettimeofday(&stopTimeO, &tzz);
    if( result != SQLITE_OK ){
      fprintf(stderr, "SQL error: %s\n", zErrMsg);
      sqlite3_free(zErrMsg);
   }else{
      fprintf(stdout, "Operation 2 done successfully\n");
   }
        clock_gettime(CLOCK_MONOTONIC, &startTimeO2);
	//gettimeofday(&startTimeO2, &tzz);
	sql = "select * from customers ORDER BY accnum;"; 
	zErrMsg = 0;
	/* Execute select group by statement */
   result = sqlite3_exec(db, sql.c_str(), callback, (void*)data, &zErrMsg);
   clock_gettime(CLOCK_MONOTONIC, &stopTimeO2);
   //gettimeofday(&stopTimeO2, &tzz);
    if( result != SQLITE_OK ){
      fprintf(stderr, "SQL error: %s\n", zErrMsg);
      sqlite3_free(zErrMsg);
   }else{
      fprintf(stdout, "Operation  3 done successfully\n");
   }
        clock_gettime(CLOCK_MONOTONIC, &startTimeU);
	//gettimeofday(&startTimeU, &tzz);
	//sql = "UPDATE customers SET age=26 WHERE age=23;"; 
	sql = "UPDATE customers SET age=23 WHERE age=26;"; 
	zErrMsg = 0;
	/* Execute update  statement */
   result = sqlite3_exec(db, sql.c_str(), callback, (void*)data, &zErrMsg);
   clock_gettime(CLOCK_MONOTONIC, &stopTimeU);
  // gettimeofday(&stopTimeU, &tzz);
    if( result != SQLITE_OK ){
      fprintf(stderr, "SQL error: %s\n", zErrMsg);
      sqlite3_free(zErrMsg);
   }else{
      fprintf(stdout, "Operation 4 done successfully\n");
   }


   sqlite3_close(db);
  
   //timersub(&stopTimeS, &startTimeS, &timeD);
  //double timeElasp = timeD.tv_sec*1000000.0+(timeD.tv_usec);
   double timeElasp = (stopTimeS.tv_sec - startTimeS.tv_sec) + 1e-9*(stopTimeS.tv_nsec - startTimeS.tv_nsec);  
fprintf(outfile, "time elasped for select all is:             %f \n", timeElasp);
 
  //timersub(&stopTimeO, &startTimeO, &timeD);
 // timeElasp = timeD.tv_sec*1000000.0+(timeD.tv_usec);
 double timeElasp = (stopTimeO.tv_sec - startTimeO.tv_sec) + 1e-9*(stopTimeO.tv_nsec - startTimeO.tv_nsec);
  fprintf(outfile, "time elasped for select order by:           %d.%d \n", timeD.tv_sec,timeD.tv_usec);
  
  //timersub(&stopTimeO2, &startTimeO2, &timeD);
 // timeElasp = timeD.tv_sec*1000000.0+(timeD.tv_usec);
 double timeElasp = (stopTimeO2.tv_sec - startTimeO2.tv_sec) + 1e-9*(stopTimeO2.tv_nsec - startTimeO2.tv_nsec);
  fprintf(outfile, "time elasped for 2nd select order by:       %d.%d \n", timeD.tv_sec,timeD.tv_usec);
  
 // timersub(&stopTimeU, &startTimeU, &timeD);
 // timeElasp = timeD.tv_sec*1000000.0+(timeD.tv_usec);
 double timeElasp = (stopTimeU.tv_sec - startTimeU.tv_sec) + 1e-9*(stopTimeU.tv_nsec - startTimeU.tv_nsec);
  fprintf(outfile,"time elasped for updating is:                %d.%d \n", timeD.tv_sec,timeD.tv_usec);
}
   fclose(outfile);
   //printf("%d here", TEST);
	system("pause");
}
