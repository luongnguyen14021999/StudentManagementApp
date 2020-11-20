//
// Created by Nguyen Dinh Luong on 27/9/20.
//

#ifndef ASSIGNMENTSECOND_SMARTSCHEDULE_H
#define ASSIGNMENTSECOND_SMARTSCHEDULE_H
#include "Schedule.h"
#include <vector>
class SmartSchedule: public Schedule {
public:
    SmartSchedule() {

    }
    void sortOrders();
    void setUpSmartOrder();
};

void SmartSchedule:: sortOrders() {
    Order order;
    for(int i=0;i<orders.size()-1;i++) {
        for(int j=i+1;j<orders.size();j++) {
            if(orders.at(i) < orders.at(j)) {
                order = orders.at(i);
                orders.at(i) = orders.at(j);
                orders[j] =  order;
            }
        }
    }
}
void SmartSchedule:: setUpSmartOrder() {

    Order order;
    for(int i=0;i<procedureOrders.size();i++)
    {
            for(int k=0;k<4;k++) {
                if(procedureOrders[i].pcID == k) {
                    for(int j=0;j<cancelOrders.size();j++) {
                        if(cancelOrders[j].pcID == k+4) {
                            if(count <= CYCLES) {
                                count = count - Product(procedureOrders[i].pcID).getCycle()*procedureOrders[i].orderQuantity;
                                count = count + Product(cancelOrders[j].pcID).getCycle()*cancelOrders[j].orderQuantity;
                                if(count <= CYCLES) {
                                    order = cancelOrders[j];
                                    cancelOrders[j] = procedureOrders[i];
                                    procedureOrders[i] = order;
                                    break;
                                }
                                if(count > CYCLES) {
                                    count = count + Product(procedureOrders[i].pcID).getCycle()*procedureOrders[i].orderQuantity;
                                    count = count - Product(cancelOrders[j].pcID).getCycle()*cancelOrders[j].orderQuantity;
                                }
                            }
                        }
                    }
                }
            }
    }
}
#endif //ASSIGNMENTSECOND_SMARTSCHEDULE_H
