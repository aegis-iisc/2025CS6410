
//#define MAX_INT 2147483647
int x = 1;            // Shared variable
int mutex = 1;        //  1 = available, 0 = locked
int in_critical = 0;  // Tracks number of processes in the critical section

active proctype P1() {
    do
    :: atomic { (mutex == 1) -> mutex = 0; in_critical = in_critical + 1; }
       
       assert(in_critical == 1);  // Mutual exclusion check

       x = x + 1;  
       printf("P1: x = %d\n", x);
       assert(x > 0);  // Ensure x never becomes non-positive

       atomic { in_critical = in_critical - 1; mutex = 1; }  // Release mutex safely
    od;
}

active proctype P2() {
    do
    :: atomic { (mutex == 1) -> mutex = 0; in_critical = in_critical + 1; }

       assert(in_critical == 1);  // Mutual exclusion check

       x = 2 * x;  
       printf("P2: x = %d\n", x);
       assert(x > 0);  // Ensure x never becomes non-positive

       atomic { in_critical = in_critical - 1; mutex = 1; }  // Release mutex safely
    od;
}


