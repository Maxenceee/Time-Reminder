//
//  checkTime.swift
//  Time ReminderV2
//
//  Created by Maxence Gama on 30/01/2021.
//

import Foundation

struct checkTime {
    var TimeList: TimeList
    
    func toCheckTime() -> Bool {
        for i in 0...TimeList.list.count-1 {
            if getRtTime(TimeList: TimeList).toGetRtTime() == TimeList.list[i] {
//                print("Actual time : ", getRtTime().toGetRtTime(), " , check time",ModelData().TimeR[i].timeInMin)
                return true
            }
        }
        return false
    }
}
