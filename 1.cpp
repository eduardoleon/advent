#include <iostream>
#include <string>

int main()
{
    std::string line;
    int partial = 0, total = 0;
    
    while (std::getline(std::cin, line)) {
        int fuel = std::stoi(line) / 3 - 2;
        partial += fuel;
        
        while (fuel > 0) {
            total += fuel;
            fuel = fuel / 3 - 2;
        }
    }
    
    std::cout << partial << ' ' << total << std::endl;
}
