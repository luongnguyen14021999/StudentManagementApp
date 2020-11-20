//
// Created by Nguyen Dinh Luong on 25/9/20.
//

#ifndef ASSIGNMENTSECOND_UNIT_H
#define ASSIGNMENTSECOND_UNIT_H
#include<iostream>
using namespace std;
class Unit {
protected:
    int id;
    int cost;
public:
    Unit() {
        id = -1;
        cost = 0;
    }  // the id for an empty item is -1

    Unit(int i) {
        id = i;
        cost = 0;
    }

    Unit(int i, int c) {
        id = i;
        cost = c;
    }

    int getId() {
        return id;
    }

    int getCost() const {
        return cost;
    }
};
#endif //ASSIGNMENTSECOND_UNIT_H
