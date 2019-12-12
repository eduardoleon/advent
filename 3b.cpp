#include <algorithm>
#include <iostream>
#include <sstream>
#include <vector>

using Vec = std::vector<int>;

void discover(Vec &xs, Vec &ys, Vec &ds)
{
    std::string line;
    std::getline(std::cin, line);
    
    std::istringstream iss(line);
    int x = 0, y = 0, d = 0;
    
    do {
        char arrow;
        int length;
        iss >> arrow >> length;
        xs.push_back(x);
        ys.push_back(y);
        ds.push_back(d);
        
        int dx = (arrow == 'L') ? -1 : (arrow == 'R') ? 1 : 0;
        int dy = (arrow == 'D') ? -1 : (arrow == 'U') ? 1 : 0;
        x += length * dx;
        y += length * dy;
        d += length;
    } while (iss.get(), iss);
    
    xs.push_back(x);
    ys.push_back(x);
}

bool between(int *vs, int *fs, int &c, int &d)
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

bool cross(int *xsA, int *ysA, int *xsB, int *ysB, int &x, int &y, int &d)
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

int main()
{
    Vec xsA, ysA, dsA, xsB, ysB, dsB;
    discover(xsA, ysA, dsA);
    discover(xsB, ysB, dsB);
    
    int xsize =
        std::max( *std::max_element( xsA.begin(), xsA.end() ),
                  *std::max_element( xsB.begin(), xsB.end() ) ) -
        std::min( *std::min_element( xsA.begin(), xsA.end() ),
                  *std::min_element( xsB.begin(), xsB.end() ) );
    
    int ysize =
        std::max( *std::max_element( ysA.begin(), ysA.end() ),
                  *std::max_element( ysB.begin(), ysB.end() ) ) -
        std::min( *std::min_element( ysA.begin(), ysA.end() ),
                  *std::min_element( ysB.begin(), ysB.end() ) );
    
    int dist = xsize + ysize;
    int steps = xsize * ysize;
    
    for (int i = 0; i < dsA.size(); i++)
        for (int j = 0; j < dsB.size(); j++) {
            int x, y, d;
            if (cross(&xsA[i], &ysA[i], &xsB[j], &ysB[j], x, y, d)) {
                dist = std::min(dist, std::abs(x) + std::abs(y));
                steps = std::min(steps, dsA[i] + dsB[j] + d);
            }
        }
    
    std::cout << dist << ' ' << steps << std::endl;
}
