module intcode;

import std.algorithm;
import std.conv;
import std.range;
import std.stdio;

int run(int a, int b, int[] prog)
{
    int[] mem = prog.dup;
    mem[1] = a;
    mem[2] = b;
    
    foreach (pos; iota(0, mem.length, 4))
        if (mem[pos] == 1) {
            int arg1 = mem[pos + 1];
            int arg2 = mem[pos + 2];
            int arg3 = mem[pos + 3];
            mem[arg3] = mem[arg1] + mem[arg2];
        }
        else if (mem[pos] == 2) {
            int arg1 = mem[pos + 1];
            int arg2 = mem[pos + 2];
            int arg3 = mem[pos + 3];
            mem[arg3] = mem[arg1] * mem[arg2];
        }
        else
            break;
    
    return mem[0];
}

void main()
{
    string line = readln;
    int[] prog;
    
    foreach (part; line.splitter(','))
        prog ~= parse!int(part);
    
    writeln(run(12, 2, prog));
    
    foreach (i; iota(100))
        foreach (j; iota(100))
            if (run(i, j, prog) == 19690720)
                writeln(100 * i + j);
}
