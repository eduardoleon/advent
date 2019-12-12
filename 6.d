module orbits;

import std.algorithm;
import std.array;
import std.stdio;
import std.string;

struct Planet {
    bool visited;
    int exact;
    int under;
    Planet* parent;
    Planet*[] children;
}

void path(Planet* planet, ref Planet*[] path)
{
    while (planet) {
        planet = planet.parent;
        path ~= planet;
    }
}

void main()
{
    Planet*[string] planets;
    foreach (string line; stdin.lines) {
        string[] parts = line.chomp.splitter(')').array;
        Planet* parent = planets.require(parts[0], new Planet);
        Planet* child = planets.require(parts[1], new Planet);
        parent.children ~= child;
        child.parent = parent;
    }
    
    Planet* center = planets["COM"];
    Planet*[] schedule = [center];
    while (schedule.length) {
        
        Planet* planet = schedule.back();
        if (planet.visited) {
            schedule.popBack();
            foreach (child; planet.children) {
                planet.exact += child.exact + 1;
                planet.under += child.under + child.exact + 1;
            }
        }
        else {
            planet.visited = true;
            foreach (child; planet.children)
                schedule ~= child;
        }
    }
    
    Planet*[] santa, you;
    path(planets["SAN"], santa);
    path(planets["YOU"], you);
    
    while (santa.back() == you.back()) {
        santa.popBack();
        you.popBack();
    }
    
    writeln(center.under, ' ', santa.length + you.length);
}
