module thermal;

import std.algorithm;
import std.conv;
import std.stdio;

void run(int input, int[] prog)
{
    int[] mem = prog.dup;
    int pos;
    
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
                int mode = mem[pos] / 100 % 10;
                int arg = mode ? (pos + 1) : mem[pos + 1];
                mem[arg] = input;
                pos += 2;
                break;
                
            case 4:
                int mode = mem[pos] / 100 % 10;
                int arg = mode ? (pos + 1) : mem[pos + 1];
                writeln(mem[arg]);
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
}

void main()
{
    string line = readln;
    int[] prog;
    
    foreach (part; line.splitter(','))
        prog ~= parse!int(part);
    
    run(1, prog);
    run(5, prog);
}
