//
// Created by Nguyen Dinh Luong on 25/9/20.
//

#ifndef ASSIGNMENTSECOND_SCHEDULE_H
#define ASSIGNMENTSECOND_SCHEDULE_H
#include <vector>
#include "Order.h"
#include "Product.h"
#include "Component.h"
#include <fstream>
#include <math.h>
#include "Constant.h"
using namespace std;
class Schedule {
public:
    int computerProduct[16];
    int componentDemand[10];
    int productionCycles;
    long orderDiscount;
    long totalDiscount;
    int count;
    void writeFile(ofstream&,int , int, int, int, long) const;
    void writeFileWithDiscount(ofstream&,int , int, int, int, long,long,long) const;
    void writeFileWithoutDiscount(ofstream&,int , int, int, int, long,long,long) const;
    vector<Order> orders;
    vector<Order> procedureOrders;
    vector<Order> cancelOrders;

    Schedule() {
        for(int i=0;i<16;i++) {
            computerProduct[i] = 0;
        }

        for(int j=0;j<10;j++) {
            componentDemand[j] = 0;
        }
        productionCycles = 0;
        orderDiscount = 0;
        totalDiscount = 0;
        count = 0;
    }

    void readOrderBundle();
    void calculating();
    void setUpOrders();
    void writeScheduleOrders();
    void writeProductionPlan();
    void writeComponentDemand();
};

void Schedule:: readOrderBundle() {
    ifstream infile;
    infile.open("orderbundle.txt");

    if(infile.fail()) {
        cout<<"File doesn't not exist "<<endl;
    } else {
        char c;
        int k = 0;
        srand(time(0));
        while (!infile.eof()) {
            Order order;
            infile.get(c);
            if (c == '[') {
                infile >> order.orderID;
                infile.get(c);
                infile >> order.pcID;
                infile.get(c);
                infile >> order.orderQuantity;
                infile.get(c);
                infile >> order.profitRate;
                infile.get(c);
                if (c != ']') {
                    break;
                }
                orders.push_back(order);
                k++;
            }
        }
        infile.close();
    }
}

void Schedule:: setUpOrders() {
    for(int i=0;i<orders.size();i++)
    {
        if(count <= CYCLES) {
            count = count + Product(orders[i].pcID).getCycle()*orders[i].orderQuantity;
            if(count > CYCLES) {
                count = count - Product(orders[i].pcID).getCycle()*orders[i].orderQuantity;
                cancelOrders.push_back(orders[i]);
            } else {
                procedureOrders.push_back(orders[i]);
            }
        }
    }
}

void Schedule :: writeFile(ofstream& fout, int orderID , int pcID, int quantity, int profitRate, long unitProfit) const {
    fout<<setw(15)<<orderID<<setw(15)<<pcID<<setw(15)<<quantity<<setw(15)<<profitRate<<"%"<<setw(15)<<unitProfit<<endl;
}

void Schedule :: writeFileWithDiscount(ofstream& fout, int orderID , int pcID, int quantity, int profitRate, long unitProfit, long totalProfit,long discount) const {
    fout<<setw(15)<<orderID<<setw(15)<<pcID<<setw(15)<<quantity<<setw(15)<<profitRate<<"%"<<setw(15)<<unitProfit<<setw(15)<<totalProfit<<setw(15)<<discount<<endl;
}

void Schedule :: writeFileWithoutDiscount(ofstream& fout, int orderID , int pcID, int quantity, int profitRate, long unitProfit, long totalProfit,long discount = 0) const {
    fout<<setw(15)<<orderID<<setw(15)<<pcID<<setw(15)<<quantity<<setw(15)<<profitRate<<"%"<<setw(15)<<unitProfit<<setw(15)<<totalProfit<<setw(15)<<discount<<endl;
}

void Schedule:: calculating() {

    for(int i=0;i<procedureOrders.size();i++)
    {
        int pcId = procedureOrders[i].pcID;
        int quantity = procedureOrders[i].orderQuantity;
        Product product(pcId);
        computerProduct[pcId] =  computerProduct[pcId] + quantity;

        Component* compo = product.getComponents();
        for(int m = 0;m<4;m++) {
            int componentID = compo[m].getId();
            componentDemand[componentID] =  componentDemand[componentID] + quantity;
        }
    }
}

void Schedule :: writeScheduleOrders() {
    ofstream fout;
    fout.open("schedule.txt");
    fout<<"Total orders received: "<<orders.size()<<endl;
    fout<<setw(15)<<"OrderID"<<setw(15)<<"pcID"<<setw(15)<<"qty"<<setw(15)<<"profitRate"<<" "<<setw(15)<<"unitProfit"<<endl;

    for(int i=0;i<orders.size();i++) {
        int orderID = orders[i].orderID;
        int pcID = orders[i].pcID;
        int quantity = orders[i].orderQuantity;
        int profitRate = orders[i].profitRate;
        long unitProfit = orders[i].unitProfit();
        writeFile(fout,orderID,pcID,quantity,profitRate,unitProfit);
    }
    fout<<"--------------------------------------------------------------------------------------"<<endl;

    fout<<"4 CPUs demand: ";
    for(int i=0;i<4;i++) {
        fout<<componentDemand[i]<<" ";
    }
    fout<<endl;
    fout<<"--------------------------------------------------------------------------------------"<<endl;

    fout<<"The orders to be produced: "<<procedureOrders.size()<<endl;
    fout<<setw(15)<<"OrderID"<<setw(15)<<"pcID"<<setw(15)<<"qty"<<setw(15)<<"profitRate"<<" "<<setw(15)<<"unitProfit"<<setw(15)<<"totalProfit"<<setw(15)<<"discount"<<endl;
    for(int i=0;i<procedureOrders.size();i++) {
        int orderID = procedureOrders[i].orderID;
        int pcID = procedureOrders[i].pcID;
        int quantity = procedureOrders[i].orderQuantity;
        int profitRate = procedureOrders[i].profitRate;
        long unitProfit = procedureOrders[i].unitProfit();
        long totalProfit = procedureOrders[i].totalProfit();
        orderDiscount = 0;
        for(int i=0;i<4;i++) {
            if(Product(pcID).getidCPU() == i && componentDemand[i] > 500)
            {
               orderDiscount = Product(pcID).getCostCPU()*CPUDISCOUNT*quantity;
               totalDiscount = totalDiscount + orderDiscount;
            }
        }
        writeFileWithDiscount(fout,orderID,pcID,quantity,profitRate,unitProfit,totalProfit,orderDiscount);
    }

    fout<<"--------------------------------------------------------------------------------------"<<endl;
    fout<<"The orders to be canceled: "<<cancelOrders.size()<<endl;
    fout<<setw(15)<<"OrderID"<<setw(15)<<"pcID"<<setw(15)<<"qty"<<setw(15)<<"profitRate"<<" "<<setw(15)<<"penalty"<<endl;
    for(int i=0;i<cancelOrders.size();i++) {
        int orderID = cancelOrders[i].orderID;
        int pcID = cancelOrders[i].pcID;
        int quantity = cancelOrders[i].orderQuantity;
        int profitRate = cancelOrders[i].profitRate;
        long penalty = cancelOrders[i].penalty();
        writeFile(fout,orderID,pcID,quantity,profitRate,penalty);
    }
    fout<<"--------------------------------------------------------------------------------------"<<endl;

    int totalProfit = 0;
    for(int i=0;i<procedureOrders.size();i++) {
        totalProfit = totalProfit + procedureOrders[i].totalProfit();
    }
    int penalty = 0;
    for(int i=0;i<cancelOrders.size();i++) {
        penalty = penalty + cancelOrders[i].penalty();
    }
    fout<<"Total profit: "<<totalProfit<<" (total penalty = "<<penalty<<", total discount: "<<totalDiscount<<")"<<endl;

    for(int i = 0;i<16;i++) {
        productionCycles = productionCycles + computerProduct[i]*cycleMap[i];
    }
    fout<<"Total cycles required: "<<productionCycles;
    fout.close();
}

void Schedule :: writeComponentDemand() {

    ofstream fout;
    fout.open("componentDemand.txt");
    fout<<"Component demand:"<<endl;
    int w = 20;
    fout<<setw(w)<<"compId"<<setw(w)<<"Component name"<<setw(w)<<"demand"<<endl;
    for(int i=0;i<10;i++) {
        fout<<setw(w)<<i<<":"<<setw(w)<<nameMap[i]<<setw(w)<<componentDemand[i]<<endl;
    }
    fout.close();
}

void Schedule :: writeProductionPlan() {
    ofstream fout;
    fout.open("productionPlan.txt");
    int w = 10;
    int totalProduct = 0;
    fout<<setw(w)<<"pcID"<<setw(w)<<"amount"<<endl;
    for(int i = 0;i<16;i++) {
        fout<<setw(w)<<i<<":"<<setw(w)<<computerProduct[i]<<endl;
        totalProduct =  totalProduct + computerProduct[i];
    }
    fout<<"Total product to be produced: "<<totalProduct<<endl;
    fout<<"Total production cycles required: "<<productionCycles;
    fout.close();
}
#endif //ASSIGNMENTSECOND_SCHEDULE_H
