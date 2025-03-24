int x;  // Symbolic variable

active proctype symbolic_execution() {
    if
    :: x = 0;
    :: x = 1;
    :: x = -1;
    :: x = 10;
    :: x = -10;
    fi;

    int result = 2 * x + 3;
    printf("For x=%d, f(x)=%d\n", x, result);
    
    // Symbolic assertion: Ensure result is always greater than 0
    assert(result > 0);
}
