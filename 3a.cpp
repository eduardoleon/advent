#include <algorithm>
#include <cmath>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

struct Step {
    int length;
    int dx;
    int dy;
};

struct Cell {
    int mark;
    int steps;
};

struct Solution {
    int dist;
    int steps;
};

using Coord = std::vector<int>;
using Path = std::vector<Step>;
using Grid = std::vector<Cell>;

void discover(Path &path, Coord &xs, Coord &ys)
{
    std::string line;
    std::getline(std::cin, line);
    
    std::istringstream iss(line);
    int x = 0, y = 0;
    
    do {
        char arrow;
        Step step;
        iss >> arrow >> step.length;
        step.dx = (arrow == 'L') ? -1 : (arrow == 'R') ? 1 : 0;
        step.dy = (arrow == 'D') ? -1 : (arrow == 'U') ? 1 : 0;
        path.push_back(step);
        
        x += step.dx * step.length;
        y += step.dy * step.length;
        xs.push_back(x);
        ys.push_back(y);
    } while (iss.get(), iss);
}

void traverse(Path &path, Grid &grid, int p, int q, Solution *sol)
{
    int x = 0, y = 0, s = 0;
    for (auto step : path) {
        
        int dp = step.dx * q + step.dy;
        for (int i = 0; i < step.length; i++) {
            x += step.dx;
            y += step.dy;
            p += dp;
            s++;
            
            if (!sol) {
                grid[p].mark = 1;
                grid[p].steps = s;
            }
            else if (grid[p].mark) {
                int a = std::abs(x) + std::abs(y);
                int b = grid[p].steps + s;
                sol->dist = std::min(a, sol->dist);
                sol->steps = std::min(b, sol->steps);
            }
        }
    }
}

int main()
{
    Path first, second;
    Coord xs = { 0 }, ys = { 0 };
    discover(first, xs, ys);
    discover(second, xs, ys);
    
    int xmin = -*std::min_element(xs.begin(), xs.end());
    int ymin = -*std::min_element(ys.begin(), ys.end());
    int xmax = *std::max_element(xs.begin(), xs.end());
    int ymax = *std::max_element(ys.begin(), ys.end());
    
    int xsize = xmin + xmax + 1;
    int ysize = ymin + ymax + 1;
    int pos = xmin * ysize + ymin;
    
    Solution sol;
    sol.dist = xsize + ysize;
    sol.steps = xsize * ysize;
    
    Grid grid(xsize * ysize);
    traverse(first, grid, pos, ysize, NULL);
    traverse(second, grid, pos, ysize, &sol);
    
    std::cout << sol.dist << ' ' << sol.steps << std::endl;
}
