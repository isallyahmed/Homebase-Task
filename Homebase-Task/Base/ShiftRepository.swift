//
//  ShiftRepository.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 10/09/2022.
//

import Foundation
import RxSwift
protocol Repository{
    func fetchShifts() -> Observable<ShiftsModel>
    func fetchEmployes() -> Observable<[String]>
    func fetchRoles() -> Observable<[String]>
    func fetchColors() -> Observable<[Shift.Color]>
    func saveShift(_ shift:Shift)
}

class ShiftRepository: Repository{
    private var dataSource:DataSourceLogic
    init(dataSource: DataSourceLogic){
        self.dataSource = dataSource
    }
    func fetchShifts() -> Observable<ShiftsModel> {
        return Observable.create { [weak self] observer in
            guard let self = self else {return Disposables.create()}
            if var data = ShiftStore.shared.getShift() {
                data.shifts = data.shifts.sorted(by: {$0.startDate > $1.startDate})
                observer.onNext(data)
            }else{
                do{
                    var shiftModel: ShiftsModel = try self.dataSource.fetch("shifts.json")
                    shiftModel.shifts = shiftModel.shifts.sorted(by: {$0.startDate > $1.startDate})
                    ShiftStore.shared.saveShitsModel(shiftModel)
                    observer.onNext(shiftModel)
                
                }catch{
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    

    func fetchEmployes() -> Observable<[String]>{
        Observable.just(["Anna" , "Antan" , "Eugene" , "Keyvern"])
    }
    func fetchRoles() -> Observable<[String]>{
        Observable.just(["Waiter" , "Prep" , "Cook" , "Front of"])

    }
    func fetchColors() -> Observable<[Shift.Color]>{
        Observable.just([Shift.Color.red , Shift.Color.blue , Shift.Color.green])

    }
    
    func saveShift(_ shift:Shift){

        ShiftStore.shared.addShift(shift)
    }
}


