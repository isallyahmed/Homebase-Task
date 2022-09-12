//
//  DataSourceTests.swift
//  Homebase-TaskTests
//
//  Created by Sally Ahmed1 on 12/09/2022.
//

import XCTest
@testable import Homebase_Task

class DataSourceTests: XCTestCase {

   
    func testStubsFetchShifts() throws {
        let fileDataSource = StubDataSource()
         do{
         let shiftModel:ShiftsModel = try fileDataSource.fetch("shifts.json")
         XCTAssertNotNil(shiftModel)
         XCTAssertEqual(shiftModel.shifts.count, 1)
         }catch{
             throw error
         }
    }

    func testFailedFetchShifts() throws {
        let fileDataSource = StubDataSource()
         do{
         let shiftModel:ShiftsModel? = try fileDataSource.fetch("notFound.json")
         XCTAssertNil(shiftModel)
         }catch{
             XCTAssertEqual(error.localizedDescription, FileError.filePath.localizedDescription)
         }

    }

}
