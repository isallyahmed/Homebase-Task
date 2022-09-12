//
//  ShiftViewModel.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 10/09/2022.
//

import Foundation
import UIKit
protocol ShiftViewModelLogic{
    var title:String {get}
    var color: UIColor {get}
    var timeRange:String {get}
}

final class ShiftViewModel:ShiftViewModelLogic{
    let dateTamplete = "EEE, MMM d h a"
    var color: UIColor
    var timeRange: String
    var title: String
    
    private var shift: Shift
    init(shift: Shift){
        self.shift = shift
        self.title = shift.name + "(\(shift.role))" 
        self.timeRange = self.shift.startDate.rangeTimeWith(self.shift.endDate  , dateTamplete)
        self.color = shift.color.create
    }
}
