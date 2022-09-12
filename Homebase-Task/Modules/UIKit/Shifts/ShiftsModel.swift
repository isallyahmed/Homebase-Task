//
//  ShiftsModel.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 10/09/2022.
//

import Foundation
import UIKit

// MARK: - ShiftsModel
struct ShiftsModel: Codable {
    var shifts: [Shift]
}

// MARK: - Shift
struct Shift: Codable {
    let role, name :String
    let startDate, endDate: Date
    let color: Color

    enum CodingKeys: String, CodingKey {
        case role, name
        case startDate = "start_date"
        case endDate = "end_date"
        case color
    }
    
    enum Color: String ,Codable{
      case red
      case blue
      case green

        var create: UIColor {
             switch self {
                case .red:
                  return UIColor.red
              case .blue:
                  return UIColor.blue
              case .green:
                  return UIColor.green
             }
          }
     }
}

