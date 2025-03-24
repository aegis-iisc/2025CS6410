

proctype Statements() {
    //Assignments are atomic (cannot be interrupted by another process).
    byte x = 0;   // Declare and initialize
    x = 5;        // Assign a new value

    //Works like a non-deterministic switch.
    //If multiple guards are true, one is picked randomly.
    if
    :: x == 5 -> printf("x is 5\n")
    :: x != 5 -> printf("x is not 5\n")
    fi;

    //Executes a loop until a break is encountered.
    byte i = 0;
    do
        :: i < 5 -> printf("i = %d\n", i); i++
        :: i >= 5 -> break
    od;

}


active proctype P() {
    byte i = 0;
    do
        :: i < 5 -> printf("Running..P.\n"); i++
        :: i >= 5 -> break
    od;
   
}


init {
    int lastpid;
    int x;
    int y;
    printf("init process, my pid is: %d\n", _pid);
    lastpid = run Statements();
    printf("last pid was: %d\n", lastpid);
    
    //Ensures a block of statements executes without interruption.
    atomic {
        x = 1;
        y = 2;
    }

    // x = 1;
    // y = 2;
    printf("x is %d \n", x);
    printf("y is %d \n", y);


    // //Ensures correctness by checking a condition.
    // //If assert(condition) fails, Spin reports an error.
    assert(x > 10); // Verification fails if x ≥ 10




    
}
