//
//  DateEx.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 11/09/2022.
//

import Foundation
extension Date{
    func rangeTimeWith(_ endDate: Date ,_ dateTamplete: String) -> String {
        let formatter = DateIntervalFormatter()
        formatter.dateTemplate = dateTamplete
        let dateRangeStr = formatter.string(from: self, to: endDate)
        return dateRangeStr
    }
    
    
     func stringValue() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        let string = dateFormatter.string(from: self)
        return string
    }
}
