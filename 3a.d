module wires;

import std.algorithm;
import std.conv;
import std.math;
import std.range;
import std.stdio;

struct Step {
    int length;
    int dx;
    int dy;
}

struct Cell {
    int mark;
    int steps;
}

struct Solution {
    int dist;
    int steps;
}

void discover(ref Step[] path, ref int[] xs, ref int[] ys)
{
    string line = readln;
    int x, y;
    
    do {
        Step step;
        char arrow = parse!char(line);
        step.length = parse!int(line);
        step.dx = (arrow == 'L') ? -1 : (arrow == 'R') ? 1 : 0;
        step.dy = (arrow == 'D') ? -1 : (arrow == 'U') ? 1 : 0;
        path ~= step;
        
        x += step.dx * step.length;
        y += step.dy * step.length;
        xs ~= x;
        ys ~= y;
    } while (parse!char(line) == ',');
}

void traverse(Step[] path, Cell[] grid, int p, int q, Solution* sol)
{
    int x, y, s;
    foreach (step; path) {
        
        int dp = step.dx * q + step.dy;
        foreach (i; iota(step.length)) {
            x += step.dx;
            y += step.dy;
            p += dp;
            s++;
            
            if (!sol) {
                grid[p].mark = 1;
                grid[p].steps = s;
            }
            else if (grid[p].mark) {
                int a = abs(x) + abs(y);
                int b = grid[p].steps + s;
                sol.dist = min(a, sol.dist);
                sol.steps = min(b, sol.steps);
            }
        }
    }
}

void main()
{
    Step[] first, second;
    int[] xs = [0], ys = [0];
    discover(first, xs, ys);
    discover(second, xs, ys);
    
    int xmin = -xs.reduce!(min);
    int ymin = -ys.reduce!(min);
    int xmax = xs.reduce!(max);
    int ymax = ys.reduce!(max);
    
    int xsize = xmin + xmax + 1;
    int ysize = ymin + ymax + 1;
    int pos = xmin * ysize + ymin;
    
    Solution sol;
    sol.dist = xsize + ysize;
    sol.steps = xsize * ysize;
    
    Cell[] grid = new Cell[xsize * ysize];
    traverse(first, grid, pos, ysize, null);
    traverse(second, grid, pos, ysize, &sol);
    writeln(sol.dist, ' ', sol.steps);
}
