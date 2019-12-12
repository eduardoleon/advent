module boost;

import std.algorithm;
import std.conv;
import std.stdio;

void run(long input, long[] prog)
{
    long base, pos;
    long[] mem = prog.dup;
    mem.length = 100000;
    
    while (pos < mem.length) {
        long code = mem[pos] % 100;
        
        switch (code) {
            case 1:
                long mode1 = mem[pos] / 100 % 10;
                long mode2 = mem[pos] / 1000 % 10;
                long mode3 = mem[pos] / 10000 % 10;
                long arg1 = (mode1 == 0) ? mem[pos + 1] : (mode1 == 1) ? (pos + 1) : (mem[pos + 1] + base);
                long arg2 = (mode2 == 0) ? mem[pos + 2] : (mode2 == 1) ? (pos + 2) : (mem[pos + 2] + base);
                long arg3 = (mode3 == 0) ? mem[pos + 3] : (mode3 == 1) ? (pos + 3) : (mem[pos + 3] + base);
                mem[arg3] = mem[arg1] + mem[arg2];
                pos += 4;
                break;
                
            case 2:
                long mode1 = mem[pos] / 100 % 10;
                long mode2 = mem[pos] / 1000 % 10;
                long mode3 = mem[pos] / 10000 % 10;
                long arg1 = (mode1 == 0) ? mem[pos + 1] : (mode1 == 1) ? (pos + 1) : (mem[pos + 1] + base);
                long arg2 = (mode2 == 0) ? mem[pos + 2] : (mode2 == 1) ? (pos + 2) : (mem[pos + 2] + base);
                long arg3 = (mode3 == 0) ? mem[pos + 3] : (mode3 == 1) ? (pos + 3) : (mem[pos + 3] + base);
                mem[arg3] = mem[arg1] * mem[arg2];
                pos += 4;
                break;
                
            case 3:
                long mode = mem[pos] / 100 % 10;
                long arg = (mode == 0) ? mem[pos + 1] : (mode == 1) ? (pos + 1) : (mem[pos + 1] + base);
                mem[arg] = input;
                pos += 2;
                break;
                
            case 4:
                long mode = mem[pos] / 100 % 10;
                long arg = (mode == 0) ? mem[pos + 1] : (mode == 1) ? (pos + 1) : (mem[pos + 1] + base);
                writeln(mem[arg]);
                pos += 2;
                break;
                
            case 5:
                long mode1 = mem[pos] / 100 % 10;
                long mode2 = mem[pos] / 1000 % 10;
                long arg1 = (mode1 == 0) ? mem[pos + 1] : (mode1 == 1) ? (pos + 1) : (mem[pos + 1] + base);
                long arg2 = (mode2 == 0) ? mem[pos + 2] : (mode2 == 1) ? (pos + 2) : (mem[pos + 2] + base);
                pos = mem[arg1] ? mem[arg2] : (pos + 3);
                break;
                
            case 6:
                long mode1 = mem[pos] / 100 % 10;
                long mode2 = mem[pos] / 1000 % 10;
                long arg1 = (mode1 == 0) ? mem[pos + 1] : (mode1 == 1) ? (pos + 1) : (mem[pos + 1] + base);
                long arg2 = (mode2 == 0) ? mem[pos + 2] : (mode2 == 1) ? (pos + 2) : (mem[pos + 2] + base);
                pos = mem[arg1] ? (pos + 3) : mem[arg2];
                break;
                
            case 7:
                long mode1 = mem[pos] / 100 % 10;
                long mode2 = mem[pos] / 1000 % 10;
                long mode3 = mem[pos] / 10000 % 10;
                long arg1 = (mode1 == 0) ? mem[pos + 1] : (mode1 == 1) ? (pos + 1) : (mem[pos + 1] + base);
                long arg2 = (mode2 == 0) ? mem[pos + 2] : (mode2 == 1) ? (pos + 2) : (mem[pos + 2] + base);
                long arg3 = (mode3 == 0) ? mem[pos + 3] : (mode3 == 1) ? (pos + 3) : (mem[pos + 3] + base);
                mem[arg3] = mem[arg1] < mem[arg2];
                pos += 4;
                break;
                
            case 8:
                long mode1 = mem[pos] / 100 % 10;
                long mode2 = mem[pos] / 1000 % 10;
                long mode3 = mem[pos] / 10000 % 10;
                long arg1 = (mode1 == 0) ? mem[pos + 1] : (mode1 == 1) ? (pos + 1) : (mem[pos + 1] + base);
                long arg2 = (mode2 == 0) ? mem[pos + 2] : (mode2 == 1) ? (pos + 2) : (mem[pos + 2] + base);
                long arg3 = (mode3 == 0) ? mem[pos + 3] : (mode3 == 1) ? (pos + 3) : (mem[pos + 3] + base);
                mem[arg3] = mem[arg1] == mem[arg2];
                pos += 4;
                break;
                
            case 9:
                long mode = mem[pos] / 100 % 10;
                long arg = (mode == 0) ? mem[pos + 1] : (mode == 1) ? (pos + 1) : (mem[pos + 1] + base);
                base += mem[arg];
                pos += 2;
                break;
                
            default:
                pos = cast(long)mem.length;
                break;
        }
    }
}

void main()
{
    string line = readln;
    long[] prog;
    
    foreach (part; line.splitter(','))
        prog ~= parse!long(part);
    
    run(1, prog);
    run(2, prog);
}
