//
//  ShiftsViewController.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 10/09/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ShiftsViewController: UIViewController {

    private var viewModel: ShiftsViewModelLogic
    private var router: ShiftsRouterLogic
    
    @IBOutlet private weak var tableView: UITableView!
 
    private let disposeBag =  DisposeBag()
    
    init(viewModel: ShiftsViewModelLogic , router: ShiftsRouterLogic){
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: String(describing: ShiftsViewController.self), bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableSetup()
        viewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchShifts.onNext(())

    }
    
    private func viewSetup(){
        let addShiftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Add Shift", comment: ""), style: .done, target: self, action: #selector(addShift))
        self.navigationItem.rightBarButtonItem  = addShiftBarButtonItem
        
        self.title = NSLocalizedString("Shifts", comment: "")
        
    }

    private func tableSetup(){
        tableView.register(UINib(nibName: String(describing: ShiftTableViewCell.self), bundle: nil), forCellReuseIdentifier: "shiftCell")

        self.viewModel.shiftsDriver.drive(tableView.rx.items(cellIdentifier: "shiftCell", cellType: ShiftTableViewCell.self )){ index, element, cell in
            cell.viewModel = element
             
        }.disposed(by: disposeBag)
        
        self.viewModel.fetchShifts.onNext(())
    }
 
    @objc private func addShift(){
        self.router.navigateToAddShift()
    }

}
