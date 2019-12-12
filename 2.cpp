#include <iostream>
#include <sstream>
#include <string>
#include <vector>

int run(int a, int b, const std::vector<int> &prog)
{
    std::vector<int> mem = prog;
    mem[1] = a;
    mem[2] = b;
    
    for (int pos = 0; pos < mem.size(); pos += 4)
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

int main()
{
    std::string str;
    std::getline(std::cin, str);
    
    std::istringstream iss(str);
    std::vector<int> prog;
    
    while (std::getline(iss, str, ','))
        prog.push_back( std::stoi(str) );
    
    std::cout << run(12, 2, prog) << std::endl;
    
    for (int i = 0; i < 100; i++)
        for (int j = 0; j < 100; j++)
            if (run(i, j, prog) == 19690720)
                std::cout << 100 * i + j << std::endl;
}
