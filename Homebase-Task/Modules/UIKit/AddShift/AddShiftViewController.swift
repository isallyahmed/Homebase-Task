//
//  AddShiftViewController.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 11/09/2022.
//

import UIKit
import RxSwift
import RxCocoa

class AddShiftViewController: UIViewController{

    private var viewModel: AddShiftViewModelLogic
    private var router: AddShiftRouterLogic

    private let disposeBag =  DisposeBag()
    
    @IBOutlet private weak var startDateTxt: UITextField!
    @IBOutlet private weak var endDateTxt: UITextField!
    @IBOutlet private weak var employeePicker: UIPickerView!
    @IBOutlet private weak var rolePicker: UIPickerView!
    @IBOutlet private weak var colorPicker: UIPickerView!
    

    init(viewModel: AddShiftViewModelLogic , router:AddShiftRouterLogic){
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: String(describing: AddShiftViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleBinding()
        datesBinding()
        viewModel.fetchFormData.onNext(())

        let addShiftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Save", comment: ""), style: .done, target: self, action: #selector(saveShift))
        self.navigationItem.rightBarButtonItem  = addShiftBarButtonItem
        addShiftBarButtonItem.isEnabled = false
        
        
        viewModel.saveBtnDriver
            .drive(addShiftBarButtonItem.rx.isEnabled)
            .disposed(by: disposeBag)
        
        self.title = NSLocalizedString("Create Shift", comment: "")
     }
    

    private func handleBinding(){
        
        
        rolePicker.rx.modelSelected(String.self)
            .map({$0.first ?? ""})
            .ifEmpty(default: "")
            .bind(to: viewModel.role).disposed(by: disposeBag)
        
        employeePicker.rx.modelSelected(String.self)
            .map({$0.first ?? ""})
            .ifEmpty(default: "")
            .bind(to: viewModel.employee).disposed(by: disposeBag)
        
        colorPicker.rx.modelSelected(Shift.Color.self)
            .map({$0.first ?? Shift.Color.red})
            .ifEmpty(default:Shift.Color.red)
            .bind(to: viewModel.color).disposed(by: disposeBag)
        viewModel
            .rolesDriver
            .drive(rolePicker.rx.itemTitles) { (row, element) in
            return element
            }.disposed(by: disposeBag)
        
        
        viewModel
            .employesDriver
            .drive(employeePicker.rx.itemTitles) { (row, element) in
            return element
            }.disposed(by: disposeBag)
        
        
        viewModel
            .colorDriver
            .drive(colorPicker.rx.itemTitles) { (row, element) in
                return element.rawValue
            }.disposed(by: disposeBag)
        
        
        Observable.zip(viewModel.rolesDriver.asObservable() , viewModel.employesDriver.asObservable() , viewModel.colorDriver.asObservable()).subscribe {[weak self] _ in
            guard let self = self else {return}
            
            self.rolePicker.selectRow(0, inComponent: 0, animated: false)
            self.rolePicker.delegate?.pickerView?( self.rolePicker, didSelectRow: 0, inComponent: 0)
            
            self.employeePicker.selectRow(0, inComponent: 0, animated: false)
            self.employeePicker.delegate?.pickerView?( self.employeePicker, didSelectRow: 0, inComponent: 0)
            
            
            self.colorPicker.selectRow(0, inComponent: 0, animated: false)
            self.colorPicker.delegate?.pickerView?( self.colorPicker, didSelectRow: 0, inComponent: 0)
        }.disposed(by: disposeBag)

        
    }

    private func datesBinding(){
        self.startDateTxt.datePicker(target: self,
                                          doneAction: #selector(doneDateAction),
                                          cancelAction: #selector(cancelAction),
                                     datePickerMode: .dateAndTime)
        
        self.endDateTxt.datePicker(target: self,
                                          doneAction: #selector(doneDateAction),
                                          cancelAction: #selector(cancelAction),
                                   datePickerMode: .dateAndTime)
      
        (self.startDateTxt.inputView as? UIDatePicker)?.rx.value
            .bind(to: viewModel.startDate)
            .disposed(by: disposeBag)
    
        (self.endDateTxt.inputView as? UIDatePicker)?.rx.value
            .bind(to: viewModel.endDate)
            .disposed(by: disposeBag)
        
        if let endDatePicker = self.endDateTxt.inputView as? UIDatePicker , let startDatePicker = self.startDateTxt.inputView as? UIDatePicker{
            startDatePicker.rx.date
                .bind(to:endDatePicker.rx.minimumDate)
                .disposed(by: disposeBag)
        }
       
        viewModel
            .startDateDriver
            .map({$0?.stringValue()})
            .drive(startDateTxt.rx.text).disposed(by: disposeBag)
        
        viewModel
            .endDateDriver
            .map({$0?.stringValue()})
            .drive(endDateTxt.rx.text).disposed(by: disposeBag)

    }
    
    @objc
    private func cancelAction() {
           self.startDateTxt.resignFirstResponder()
           self.endDateTxt.resignFirstResponder()

       }

    @objc
    private func doneDateAction() {
        self.startDateTxt.resignFirstResponder()
        self.endDateTxt.resignFirstResponder()

    }
    

    @objc private func saveShift(){
        viewModel.saveData.onNext(())
        router.backToShifts()
    }
}


