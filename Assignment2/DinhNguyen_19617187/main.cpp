#include <iostream>
#include "SmartSchedule.h"
#include "BundleGenerator.h";
using namespace std;

int main() {

    /* BundleGenerator generator;
     generator.generateOrderBundle();
     generator.writeBundle(); */

    SmartSchedule smartSchedule;
    smartSchedule.readOrderBundle();
    smartSchedule.sortOrders();
    smartSchedule.setUpOrders();
    //smartSchedule.setUpSmartOrder();
    smartSchedule.calculating();
    smartSchedule.writeScheduleOrders();
    smartSchedule.writeComponentDemand();
    smartSchedule.writeProductionPlan();

    /*Schedule schedule;
    schedule.readOrderBundle();
    schedule.setUpOrders();
    schedule.calculating();
    schedule.writeScheduleOrders();
    schedule.writeComponentDemand();
    schedule.writeProductionPlan(); */

    return 0;
}
