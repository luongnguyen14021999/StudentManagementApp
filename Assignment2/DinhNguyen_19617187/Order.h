//
// Created by Nguyen Dinh Luong on 25/9/20.
//

#ifndef ASSIGNMENTSECOND_ORDER_H
#define ASSIGNMENTSECOND_ORDER_H
#include "Product.h"
#include "Unit.h"
#include "Constant.h"
class Order {
public:
    int orderID;
    int pcID;
    int orderQuantity;
    int profitRate;

    long unitProfit() {
        return (long) (Product(pcID).getCost()*profitRate/100);
    }

    long totalProfit() {
        return (long) ((Product(pcID).getCost()*profitRate/100)*orderQuantity);
    }

    long unitPCPrice() {
        return (long) (Product(pcID).getCost() + Product(pcID).getCost()*profitRate/100);
    }

    long penalty() {
        return (long) ((Product(pcID).getCost() + Product(pcID).getCost()*profitRate/100)*orderQuantity*CANCELLATIONPENALTY);
    }

    int numOfCycles() {
        return cycleMap[pcID]*orderQuantity;
    }

    bool operator < (Order order) {
        return unitProfit() < order.unitProfit();
    }

    void operator = (Order& order) {
        orderID = order.orderID;
        pcID = order.pcID;
        orderQuantity = order.orderQuantity;
        profitRate = order.profitRate;
    }

    bool operator == (Order& order) {
        bool result = false;
        if(orderID == order.orderID && pcID == order.pcID && orderQuantity == order.orderQuantity && profitRate == order.profitRate) {
            result = true;
        }
        return result;
    }
};
#endif //ASSIGNMENTSECOND_ORDER_H
