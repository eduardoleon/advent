module fuel;

import std.conv;
import std.stdio;

void main()
{
    int partial, total;
    
    foreach (string line; stdin.lines) {
        int fuel = parse!int(line) / 3 - 2;
        partial += fuel;
        
        while (fuel > 0) {
            total += fuel;
            fuel = fuel / 3 - 2;
        }
    }
    
    writeln(partial, ' ', total);
}
