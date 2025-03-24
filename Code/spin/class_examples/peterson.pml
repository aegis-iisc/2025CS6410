int flag[2] = {0, 0};  // Flags indicating if P0 or P1 wants to enter CS
int turn = 0;          // Indicates whose turn it is
int x = 1;             // Shared variable for demonstration

active proctype P0() {
    do
    :: flag[0] = 1;       // Indicate interest in CS
       turn = 1;          // Give turn to P1
       
       // Wait until P1 is NOT interested or it's P0's turn
       do 
       :: (flag[1] == 0 || turn == 0) -> break;  // Exit waiting loop
       od;

       /* --- Critical Section --- */
       x = x + 1;
       printf("P0 in CS: x = %d\n", x);
       assert(x > 0);  // Ensure x is always positive
       /* --- End of Critical Section --- */

       flag[0] = 0;     // Exit CS
    od;
}

active proctype P1() {
    do
    :: flag[1] = 1;       // Indicate interest in CS
       turn = 0;          // Give turn to P0
       
       // Wait until P0 is NOT interested or it's P1's turn
       do
       :: (flag[0] == 0 || turn == 1) -> break;  // Exit waiting loop
       od;

       /* --- Critical Section --- */
       x = 2 * x;
       printf("P1 in CS: x = %d\n", x);
       assert(x > 0);  // Ensure x is always positive
       /* --- End of Critical Section --- */

       flag[1] = 0;     // Exit CS
    od;
}
