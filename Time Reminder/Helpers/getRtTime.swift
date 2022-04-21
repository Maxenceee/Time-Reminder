//
//  getRtTime.swift
//  Time ReminderV2
//
//  Created by Maxence Gama on 30/01/2021.
//

import Foundation

struct getRtTime {
    var TimeList: TimeList
    
    func toGetRtTime() -> Int {
        let currentDateTime = Date()
        let calendar = Calendar.current
//        print(currentDateTime)
        
        let diffHrs = calendar.component(.hour, from: currentDateTime)
        let diffMins = calendar.component(.minute, from: currentDateTime)
//        var diffSecs = 0
        
        /*
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .short
        
        let dateTimeString = formatter.string(from: currentDateTime)*/
        
//        (diffHrs, diffMins, diffSecs) = getTimeDifference(startDate: currentDateTime)
        
        return refresh(hours: diffHrs, mins: diffMins)
    }
    
    func getTimeDifference(startDate: Date) -> (Int, Int, Int) {
       let calendar = Calendar.current
       let components = calendar.dateComponents([.hour, .minute, .second], from: startDate, to: Date())
       print(components.hour!, components.minute!, components.second!)
       return(components.hour!, components.minute!, components.second!)
    }
    
    
    
    
    func refresh (hours: Int, mins: Int) -> Int{
        let timeInMin = hours*60 + mins
//        print("actual time in mins : ", timeInMin)
        return timeInMin
    }
    
    func getDiffenceToList() -> Int {
        let currentDateTime = Date()
        let calendar = Calendar.current
        print(currentDateTime)
        
        let diffHrs = calendar.component(.hour, from: currentDateTime)
        let diffMins = calendar.component(.minute, from: currentDateTime)
        
        let timeInMin = refresh(hours: diffHrs, mins: diffMins)
//        print("timeInMin : ", timeInMin)
        var differenceIndex = 0
        
        for i in 0...TimeList.list.count-1 {
            if abs(timeInMin-(TimeList.list[i])) <= abs(timeInMin-(TimeList.list[differenceIndex])) {
                if abs(timeInMin-(TimeList.list[i])) == 0 || abs(timeInMin-(TimeList.list[i])) == TimeList.list.count-1 {
                    differenceIndex = 1
                    break
                } else if (TimeList.list[i]) > timeInMin {
                    differenceIndex = i
//                    print("diff index : ", ModelData().TimeR[differenceIndex].timeInMin)
                }
            }
        }
        
        print(abs(timeInMin-(TimeList.list[differenceIndex])))
        return abs(timeInMin-(TimeList.list[differenceIndex]))
    }
}
