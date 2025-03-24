int x = 1;            // Shared variable
int mutex = 1;        // Semaphore: 1 = available, 0 = locked
int in_critical = 0;  // Tracks number of processes in the critical section

active proctype P1() {
    do
    :: (mutex == 1) -> // Wait until mutex is available
       mutex = 0;      // Lock semaphore (P operation)
       
       in_critical = in_critical + 1;
       assert(in_critical == 1);  // Mutual exclusion check

       x = x + 1;  
       printf("P1: x = %d\n", x);
       assert(x > 0);  // Ensure x never becomes non-positive

       in_critical = in_critical - 1;
       mutex = 1;      // Release semaphore (V operation)
    od;
}

active proctype P2() {
    do
    :: (mutex == 1) -> // Wait until mutex is available
       mutex = 0;      // Lock semaphore (P operation)

       in_critical = in_critical + 1;
       assert(in_critical == 1);  // Mutual exclusion check

       x = 2 * x;  
       printf("P2: x = %d\n", x);
       assert(x > 0);  // Ensure x never becomes non-positive

       in_critical = in_critical - 1;
       mutex = 1;      // Release semaphore (V operation)
    od;
}
