//
//  ShiftStore.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 12/09/2022.
//

import Foundation
protocol ShiftStoreType{
    func saveShitsModel(_ model: ShiftsModel)
    func addShift(_ shift: Shift)
    func removeAllShifts()
    func getShift()-> ShiftsModel?
    
}
final class ShiftStore:ShiftStoreType{
    private static var data: ShiftsModel?
    
    private init(){
        
    }
   static var shared = ShiftStore()
    func saveShitsModel(_ model: ShiftsModel){
        ShiftStore.data = model
    }
    func addShift(_ shift: Shift){
        ShiftStore.data?.shifts.append(shift)
    }
    
    func removeAllShifts(){
        ShiftStore.data = nil
    }
    
    func getShift()-> ShiftsModel?{
        return ShiftStore.data
    }
}
