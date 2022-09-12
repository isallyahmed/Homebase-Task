//
//  StubDataSource.swift
//  Homebase-TaskTests
//
//  Created by Sally Ahmed1 on 12/09/2022.
//

import Foundation
@testable import Homebase_Task

final class StubDataSource: DataSourceLogic{
    func fetch<T>(_ filename: String) throws -> T where T : Decodable {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: filename, ofType:"")
        {
          
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = defaultDateFormate
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                return try decoder.decode(T.self, from: data)
            } catch {
                throw FileError.parsingError
            }
        }
        throw FileError.filePath
    }
}
