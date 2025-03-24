int x = 1;            //
int mutex = 1;        // Semaphore: 1 = available, 0 = locked

active proctype P1() {
    do
    :: (mutex == 1) -> // Wait until mutex is available
       mutex = 0;      // Lock semaphore 

       x = x + 1;  
       printf("P1: x = %d mutex = %d\n", x, mutex);
       assert(x > 0);  // 

       mutex = 1;      // Release semaphore
    od;
}

active proctype P2() {
    do
    :: (mutex == 1) -> // Wait until mutex is available
       mutex = 0;      // Lock semaphore (P operation)

       x = 2 * x;  
       printf("P2: x = %d mutex = %d\n", x, mutex);
       assert(x > 0);  // 
       mutex = 1;      // Release semaphore 
    od;
}
