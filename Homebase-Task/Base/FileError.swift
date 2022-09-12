//
//  FileError.swift
//  Homebase-Task
//
//  Created by Sally Ahmed1 on 10/09/2022.
//

import Foundation
enum FileError: Error{
    case noData
    case filePath
    case parsingError
}

extension FileError: LocalizedError {
    public var errorDescription: String? {
            switch self {
            case .noData:
                return NSLocalizedString("Couldn't load file", comment: "file error")
            case .filePath:
                return NSLocalizedString("Couldn't find file in main bundle", comment: "file error")
            case .parsingError:
                return NSLocalizedString("Couldn't parse file", comment: "file error")

            }
        }
}
