//
//  AddShiftRouter.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 12/09/2022.
//

import Foundation
import UIKit

protocol AddShiftRouterLogic {
    func backToShifts()
}

final class AddShiftRouter: AddShiftRouterLogic {
    weak var viewController: UIViewController?
    func backToShifts()
    {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
