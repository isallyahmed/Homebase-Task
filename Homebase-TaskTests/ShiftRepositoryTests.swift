//
//  ShiftRepositoryTests.swift
//  Homebase-TaskTests
//
//  Created by Sally Ahmed1 on 12/09/2022.
//

import XCTest
import RxBlocking
@testable import Homebase_Task

class ShiftRepositoryTests: XCTestCase {

    let repo = ShiftRepository(dataSource:StubDataSource())
   
    func testEmployeeData() throws {
        do{
        let employeeCount = try repo.fetchColors().asObservable().toBlocking().first()?.count
            XCTAssertEqual(employeeCount, 3)
        }catch{
            XCTAssertNil(error)
        }
        
    }
    
    func testRolesData() throws {
        do{
        let rolesCount = try repo.fetchRoles().asObservable().toBlocking().first()?.count
            XCTAssertEqual(rolesCount, 4)
        }catch{
            XCTAssertNil(error)
        }
        
    }
    
    func testColorData() throws {
        do{
        let coloCount = try repo.fetchColors().asObservable().toBlocking().first()?.count
            XCTAssertEqual(coloCount, 3)
        }catch{
            XCTAssertNil(error)
        }
        
    }

    
    func testFetchShifts() throws {
        do{
        let shifts = try repo.fetchShifts().asObservable().toBlocking().first()
            XCTAssertNotNil(shifts)
        }catch{
            XCTAssertNil(error)
        }
    }
    
}
