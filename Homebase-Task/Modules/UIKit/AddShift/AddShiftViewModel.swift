//
//  AddShiftViewModel.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 11/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol AddShiftViewModelLogic{
    // input
    var fetchFormData: AnyObserver<Void> {get}
    var saveData: AnyObserver<Void> {get}

    var startDate: AnyObserver<Date?> {get}
    var endDate: AnyObserver<Date?> {get}
    var employee: AnyObserver<String> {get}
    var role: AnyObserver<String> {get}
    var color: AnyObserver<Shift.Color> {get}

    // output
    var startDateDriver: Driver<Date?> {get}
    var endDateDriver: Driver<Date?> {get}
    var employesDriver: Driver<[String]> {get}
    var rolesDriver: Driver<[String]> {get}
    var colorDriver: Driver<[Shift.Color]> {get}
    var saveBtnDriver: Driver<Bool> {get}
    var errorDriver: Driver<Error?> {get}
}
final class AddShiftViewModel: AddShiftViewModelLogic{
    
    private let disposeBag = DisposeBag()
    private var repo:Repository
    private var shift:Shift?
    var saveData: AnyObserver<Void>
    var fetchFormData: AnyObserver<Void>
    var startDate: AnyObserver<Date?>
    var endDate: AnyObserver<Date?>
    var employee: AnyObserver<String>
    var role: AnyObserver<String>
    var color: AnyObserver<Shift.Color>
    
    var employesDriver: Driver<[String]>
    var rolesDriver: Driver<[String]>
    var colorDriver: Driver<[Shift.Color]>
    var errorDriver: Driver<Error?>
    var startDateDriver: Driver<Date?>
    var endDateDriver: Driver<Date?>
    var saveBtnDriver: Driver<Bool>
    
    private let saveSubject = PublishSubject<Void>()
    private let fetchFormDataSubject = PublishSubject<Void>()
    private let startDateSubject = PublishSubject<Date?>()
    private let endDateSubject = PublishSubject<Date?>()
    private let employeeSubject = PublishSubject<String>()
    private let roleSubject = PublishSubject<String>()
    private let colorSubject = PublishSubject<Shift.Color>()
    private let saveBtnSubject = PublishSubject<Bool>()

    
    
    private let employesSubject = PublishSubject<[String]>()
    private let rolesSubject = PublishSubject<[String]>()
    private let colorsSubject = PublishSubject<[Shift.Color]>()
    private let errorSubject = PublishSubject<Error?>()

    
    init( repo:Repository){
        self.repo = repo
        self.saveData = saveSubject.asObserver()
        self.fetchFormData = fetchFormDataSubject.asObserver()
        self.startDate = startDateSubject.asObserver()
        self.endDate = endDateSubject.asObserver()
        self.role = roleSubject.asObserver()
        self.employee = employeeSubject.asObserver()
        self.color = colorSubject.asObserver()

        self.employesDriver = employesSubject.asDriver(onErrorJustReturn: [])
        self.rolesDriver = rolesSubject.asDriver(onErrorJustReturn: [])
        self.colorDriver = colorsSubject.asDriver(onErrorJustReturn: [])
        self.errorDriver = errorSubject.asDriver(onErrorJustReturn: nil)
        self.endDateDriver = endDateSubject.asDriver(onErrorJustReturn: nil)
        self.startDateDriver = startDateSubject.asDriver(onErrorJustReturn: nil)
        self.saveBtnDriver = saveBtnSubject.asDriver(onErrorJustReturn: false)
        handleOutput()
    }
    
    private func handleOutput(){
        saveSubject.subscribe {[weak self] _ in
            if let shift = self?.shift {
                self?.repo.saveShift(shift)

            }
        }.disposed(by: disposeBag)
        
        fetchFormDataSubject.subscribe { [weak self] _ in
            self?.handleData()
        }.disposed(by: disposeBag)
        
        Observable.combineLatest(startDateSubject , endDateSubject)
            .observe(on:MainScheduler.asyncInstance)
            .subscribe { [weak self] start , end in
            if let end = end , let start = start , end < start{
                self?.endDateSubject.onNext(nil)
            }
        }.disposed(by: disposeBag)

        
        Observable.combineLatest(startDateSubject , endDateSubject , employeeSubject , roleSubject , colorSubject)
            .subscribe {[weak self] (startDate, endDate, employee,role, color) in
            if let startDate = startDate , let endDate = endDate , endDate > startDate {
                self?.shift = Shift(role: role, name: employee, startDate: startDate, endDate: endDate, color: color)
                self?.saveBtnSubject.onNext(true)
            }else{
                self?.saveBtnSubject.onNext(false)
            }
        }.disposed(by: disposeBag)
        




    }
    private func handleData(){
    
        repo.fetchColors()
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .bind(to: colorsSubject).disposed(by: disposeBag)
        
        repo.fetchRoles()
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .bind(to: rolesSubject).disposed(by: disposeBag)
        
        repo.fetchEmployes()
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .bind(to: employesSubject).disposed(by: disposeBag)
    }
}
