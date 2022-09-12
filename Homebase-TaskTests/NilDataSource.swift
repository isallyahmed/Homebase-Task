//
//  NilDataSource.swift
//  Homebase-TaskTests
//
//  Created by Sally Ahmed1 on 12/09/2022.
//

import Foundation
@testable import Homebase_Task

final class NilDataSource: DataSourceLogic{
    func fetch<T>(_ filename: String) throws -> T where T : Decodable {
        throw FileError.noData
    }
}
