//
// Created by Nguyen Dinh Luong on 25/9/20.
//

#ifndef ASSIGNMENTSECOND_PRODUCT_H
#define ASSIGNMENTSECOND_PRODUCT_H
#include "Unit.h"
#include "Constant.h"
#include "Component.h"
class Product: public Unit {
protected:
    int cycles;
    int costCPU;
    int idCPU;
    Component* components;
public:
    Product() : Unit() {}

    Product(int i)  {
        components = new Component[4];
        for(int k=0;k<4;k++) {
            *(components+k) = Component(compMap[i][k]);
        }
        id = i;
        cycles = cycleMap[i];
        cost = Component(compMap[i][0]).getCost() + Component(compMap[i][1]).getCost() + Component(compMap[i][2]).getCost() + Component(compMap[i][3]).getCost() + cycles*100;
        costCPU = Component(compMap[i][0]).getCost();
        idCPU = Component(compMap[i][0]).getId();
    }

    int getCycle() const {
        return cycles;
    }

    int getCostCPU() const {
        return costCPU;
    }

    int getidCPU() const {
        return idCPU;
    }

    Component* getComponents() {
        return components;
    }
};

#endif //ASSIGNMENTSECOND_PRODUCT_H
