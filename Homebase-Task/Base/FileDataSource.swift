//
//  DataSource.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 10/09/2022.
//

import Foundation
let defaultDateFormate = "yyyy-MM-dd HH:mm:ssZ"

protocol DataSourceLogic{
    func fetch<T: Decodable>(_ filename: String) throws -> T
}
class FileDataSource : DataSourceLogic{

    func fetch<T: Decodable>(_ filename: String) throws -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
        throw FileError.filePath
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        throw FileError.noData
    }

    do {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = defaultDateFormate
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try decoder.decode(T.self, from: data)
    } catch {
        throw FileError.parsingError
    }
}
}
