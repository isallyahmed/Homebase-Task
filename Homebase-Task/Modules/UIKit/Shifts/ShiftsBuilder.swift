//
//  ShiftsBuilder.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 10/09/2022.
//

import Foundation
import UIKit

enum ShiftsBuilder{
    static func build() -> UIViewController{
           let shiftRepo = ShiftRepository(dataSource: FileDataSource())
           let viewModel = ShiftsViewModel(repo: shiftRepo)
           let router = ShiftsRouter()
           let viewController: ShiftsViewController = ShiftsViewController(viewModel: viewModel , router:router)
           router.viewController = viewController
           return viewController
       }
       
}
