//
//  AddShiftBuilder.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 11/09/2022.
//

import Foundation
import UIKit

enum AddShiftBuilder{
    static func build() -> UIViewController{
        let shiftRepo = ShiftRepository(dataSource: FileDataSource())
        let viewModel = AddShiftViewModel(repo: shiftRepo)
        let router = AddShiftRouter()
        let viewController: AddShiftViewController = AddShiftViewController(viewModel: viewModel , router: router)
        router.viewController = viewController
        return viewController
    }
    
}
