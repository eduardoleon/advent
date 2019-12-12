module amplifiers;

import std.algorithm;
import std.conv;
import std.range;
import std.stdio;

int run(int pos, ref int[] mem, ref int[] input, ref int[] output)
{
    while (pos < mem.length) {
        int code = mem[pos] % 100;
        
        switch (code) {
            case 1:
                int mode1 = mem[pos] / 100 % 10;
                int mode2 = mem[pos] / 1000 % 10;
                int mode3 = mem[pos] / 10000 % 10;
                int arg1 = mode1 ? (pos + 1) : mem[pos + 1];
                int arg2 = mode2 ? (pos + 2) : mem[pos + 2];
                int arg3 = mode3 ? (pos + 3) : mem[pos + 3];
                mem[arg3] = mem[arg1] + mem[arg2];
                pos += 4;
                break;
                
            case 2:
                int mode1 = mem[pos] / 100 % 10;
                int mode2 = mem[pos] / 1000 % 10;
                int mode3 = mem[pos] / 10000 % 10;
                int arg1 = mode1 ? (pos + 1) : mem[pos + 1];
                int arg2 = mode2 ? (pos + 2) : mem[pos + 2];
                int arg3 = mode3 ? (pos + 3) : mem[pos + 3];
                mem[arg3] = mem[arg1] * mem[arg2];
                pos += 4;
                break;
                
            case 3:
                if (!input.length)
                    return pos;
                
                int mode = mem[pos] / 100 % 10;
                int arg = mode ? (pos + 1) : mem[pos + 1];
                mem[arg] = input[0];
                input.popFront();
                pos += 2;
                break;
                
            case 4:
                int mode = mem[pos] / 100 % 10;
                int arg = mode ? (pos + 1) : mem[pos + 1];
                output ~= mem[arg];
                pos += 2;
                break;
                
            case 5:
                int mode1 = mem[pos] / 100 % 10;
                int mode2 = mem[pos] / 1000 % 10;
                int arg1 = mode1 ? (pos + 1) : mem[pos + 1];
                int arg2 = mode2 ? (pos + 2) : mem[pos + 2];
                pos = mem[arg1] ? mem[arg2] : (pos + 3);
                break;
                
            case 6:
                int mode1 = mem[pos] / 100 % 10;
                int mode2 = mem[pos] / 1000 % 10;
                int arg1 = mode1 ? (pos + 1) : mem[pos + 1];
                int arg2 = mode2 ? (pos + 2) : mem[pos + 2];
                pos = mem[arg1] ? (pos + 3) : mem[arg2];
                break;
                
            case 7:
                int mode1 = mem[pos] / 100 % 10;
                int mode2 = mem[pos] / 1000 % 10;
                int mode3 = mem[pos] / 10000 % 10;
                int arg1 = mode1 ? (pos + 1) : mem[pos + 1];
                int arg2 = mode2 ? (pos + 2) : mem[pos + 2];
                int arg3 = mode3 ? (pos + 3) : mem[pos + 3];
                mem[arg3] = mem[arg1] < mem[arg2];
                pos += 4;
                break;
                
            case 8:
                int mode1 = mem[pos] / 100 % 10;
                int mode2 = mem[pos] / 1000 % 10;
                int mode3 = mem[pos] / 10000 % 10;
                int arg1 = mode1 ? (pos + 1) : mem[pos + 1];
                int arg2 = mode2 ? (pos + 2) : mem[pos + 2];
                int arg3 = mode3 ? (pos + 3) : mem[pos + 3];
                mem[arg3] = mem[arg1] == mem[arg2];
                pos += 4;
                break;
                
            default:
                pos = cast(int)mem.length;
                break;
        }
    }
    
    return -1;
}

int sequential(int[] prog)
{
    int best;
    foreach (phases; iota(5).permutations) {
        
        int[][] mem, buf;
        foreach (i, phase; iota(5).zip(phases)) {
            mem ~= prog.dup;
            buf ~= [phase];
        }
        
        buf[0] ~= 0;
        foreach (i, phase; iota(5).zip(phases))
            run(0, mem[i], buf[i], buf[ (i+1) % 5 ]);
        best = max(best, buf[0][0]);
    }
    
    return best;
}

int feedback(int[] prog)
{
    int best;
    foreach (phases; iota(5, 10).permutations) {
        
        int[] pos;
        int[][] mem, buf;
        foreach (i, phase; iota(5).zip(phases)) {
            pos ~= 0;
            mem ~= prog.dup;
            buf ~= [phase];
        }
        
        buf[0] ~= 0;
        while (pos[0] != -1) {
            foreach (i, phase; iota(5).zip(phases))
                pos[i] = run(pos[i], mem[i], buf[i], buf[ (i+1) % 5 ]);
        }
        
        best = max(best, buf[0][0]);
    }
    
    return best;
}

void main()
{
    string line = readln;
    int[] prog;
    
    foreach (part; line.splitter(','))
        prog ~= parse!int(part);
    
    int first = sequential(prog);
    int second = feedback(prog);
    writeln(first, ' ', second);
}
