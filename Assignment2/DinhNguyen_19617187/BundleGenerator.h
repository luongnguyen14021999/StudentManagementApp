//
// Created by Nguyen Dinh Luong on 25/9/20.
//

#ifndef ASSIGNMENTSECOND_BUNDLEGENERATOR_H
#define ASSIGNMENTSECOND_BUNDLEGENERATOR_H
#include "Order.h"
#include<vector>
#include <fstream>

class BundleGenerator {
private:
    vector<Order> bundle;
public:
    BundleGenerator() {
        bundle.clear();
    }
    void generateOrderBundle();
    void writeBundle();
    int getBundleSize() {
        return bundle.size();
    }
};
void BundleGenerator:: generateOrderBundle() {
    srand(time(0));
    int bundleSize = MINORDERBUNDLE + rand()%(MAXORDERBUNDLE-MINORDERBUNDLE);
    for(int i=0;i<bundleSize;i++) {
        Order order;
        order.orderID = 100+i;
        order.pcID = rand()%16;
        order.orderQuantity = 1 + rand()%MAXORDERQUANTITY;
        Product p(order.pcID);
        order.profitRate = MINPROFITRATE + rand()%(MAXPROFITRATE-MINPROFITRATE);
        bundle.push_back(order);
    }
}

void BundleGenerator::writeBundle() {
    ofstream output("orderbundle.txt",ios::out);
    for(int i=0;i<bundle.size();i++) {
        output<<"[";
        output<<bundle[i].orderID;
        output<<",";
        output<<bundle[i].pcID;
        output<<",";
        output<<bundle[i].orderQuantity;
        output<<",";
        output<<bundle[i].profitRate;
        output<<"]"<<endl;
    }
}
#endif //ASSIGNMENTSECOND_BUNDLEGENERATOR_H
