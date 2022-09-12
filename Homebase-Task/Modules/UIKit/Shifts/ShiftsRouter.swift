//
//  ShiftsRouter.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 10/09/2022.
//

import Foundation
import UIKit

protocol ShiftsRouterLogic {
    func navigateToAddShift()
}

final class ShiftsRouter: ShiftsRouterLogic {
    weak var viewController: UIViewController?
    func navigateToAddShift()
    {
        viewController?.navigationController?.pushViewController(AddShiftBuilder.build(), animated: true)
    }
}
