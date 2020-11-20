//
// Created by Nguyen Dinh Luong on 25/9/20.
//

#ifndef ASSIGNMENTSECOND_COMPONENT_H
#define ASSIGNMENTSECOND_COMPONENT_H
#include "Unit.h"
#include "Constant.h"
class Component: public Unit {
private:
    int compID;
public:
    Component() : Unit() {}

    Component(int i)  {
        id = i;
        cost = compCost[i];
    }
};
#endif //ASSIGNMENTSECOND_COMPONENT_H
