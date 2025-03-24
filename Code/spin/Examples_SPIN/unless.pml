
active proctype P() {
    do
    :: printf("Running...\n")
    od;
}

active proctype Stopper() {
    unless
        :: printf("Process stopped!\n"); 
    fi;
}
