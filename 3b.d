module wires;

import std.algorithm;
import std.conv;
import std.math;
import std.range;
import std.stdio;

void discover(ref int[] xs, ref int[] ys, ref int[] ds)
{
    string line = readln;
    int x, y, d;
    
    do {
        char arrow = parse!char(line);
        int length = parse!int(line);
        xs ~= x;
        ys ~= y;
        ds ~= d;
        
        int dx = (arrow == 'L') ? -1 : (arrow == 'R') ? 1 : 0;
        int dy = (arrow == 'D') ? -1 : (arrow == 'U') ? 1 : 0;
        x += length * dx;
        y += length * dy;
        d += length;
    } while (parse!char(line) == ',');
    
    xs ~= x;
    ys ~= y;
}

bool between(int[] vs, int[] fs, ref int c, ref int d)
{
    if (vs[0] < fs[0] && fs[0] == fs[1] && fs[1] <= vs[1]) {
        c = fs[0];
        d = fs[0] - vs[0];
        return true;
    }
    
    if (vs[0] > fs[0] && fs[0] == fs[1] && fs[1] >= vs[1]) {
        c = fs[0];
        d = vs[0] - fs[0];
        return true;
    }
    
    return false;
}

bool cross(int[] xsA, int[] ysA, int[] xsB, int[] ysB, ref int x, ref int y, ref int d)
{
    int dx, dy;
    
    if (between(xsA, xsB, x, dx) && between(ysB, ysA, y, dy)) {
        d = dx + dy;
        return true;
    }
    
    if (between(xsB, xsA, x, dx) && between(ysA, ysB, y, dy)) {
        d = dx + dy;
        return true;
    }
    
    return false;
}

void main()
{
    int[] xsA, ysA, dsA, xsB, ysB, dsB;
    discover(xsA, ysA, dsA);
    discover(xsB, ysB, dsB);
    
    int xsize = chain(xsA, xsB).reduce!(max) - chain(xsA, xsB).reduce!(min);
    int ysize = chain(ysA, ysB).reduce!(max) - chain(ysA, ysB).reduce!(min);
    int dist = xsize + ysize;
    int steps = xsize * ysize;
    
    foreach (i; iota(dsA.length))
        foreach (j; iota(dsB.length)) {
            int x, y, d;
            if (cross(xsA[i..$], ysA[i..$], xsB[j..$], ysB[j..$], x, y, d)) {
                dist = min(dist, abs(x) + abs(y));
                steps = min(steps, dsA[i] + dsB[j] + d);
            }
        }
    
    writeln(dist, ' ', steps);
}
