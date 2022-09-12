//
//  ShiftsViewModel.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 10/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol ShiftsViewModelLogic{
    // input
    var fetchShifts: AnyObserver<Void> {get}

    // output
    var shiftsDriver: Driver<[ShiftViewModel]> {get}
    var errorDriver: Driver<Error?> {get}

}
final class ShiftsViewModel: ShiftsViewModelLogic{
    private let disposeBag = DisposeBag()
    private var repo:Repository
    var fetchShifts: AnyObserver<Void>
    var shiftsDriver: Driver<[ShiftViewModel]>
    var errorDriver: Driver<Error?>
    private let fetchShiftsSubject = PublishSubject<Void>()


    private let shiftsSubject = PublishSubject<[ShiftViewModel]>()
    private let errorSubject = PublishSubject<Error?>()
    
    init( repo:Repository){
        self.repo = repo
        self.fetchShifts = fetchShiftsSubject.asObserver()
        self.shiftsDriver = shiftsSubject.asDriver(onErrorJustReturn: [])
        self.errorDriver = errorSubject.asDriver(onErrorJustReturn: nil)
        fetchShiftsHandle()
    }
    
   private func fetchShiftsHandle(){
        fetchShiftsSubject.subscribe { [weak self] _ in
            self?.getShiftsData()
        }.disposed(by: disposeBag)

    }
    
    private func getShiftsData(){
        repo.fetchShifts()
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe { [weak self] shiftsModel in
                self?.shiftsSubject.onNext(shiftsModel.shifts
                    .map({ShiftViewModel(shift: $0)}
                        ))
        } onError: { [weak self] error in
            self?.errorSubject.onNext(error)
        }.disposed(by: disposeBag)

    }
}
