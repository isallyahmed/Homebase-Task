//
//  ShiftsViewModelTests.swift
//  Homebase-TaskTests
//
//  Created by Sally Ahmed1 on 12/09/2022.
//

import XCTest
import RxBlocking
@testable import Homebase_Task

class ShiftsViewModelTests: XCTestCase {


    func testFetchShiftSuccess() throws {
        ShiftStore.shared.removeAllShifts()
        let viewModel: ShiftsViewModel = ShiftsViewModel(repo: ShiftRepository(dataSource: StubDataSource()))
        viewModel.fetchShifts.onNext(())
        do{
            let rows:[ShiftViewModel] =  try viewModel.shiftsDriver.asObservable().toBlocking(timeout: 1).first() ?? []
            XCTAssertNotNil(rows)
            XCTAssertEqual(rows.count ,1)
            XCTAssertEqual(rows.first?.title ,"Anna(Waiter)")
            XCTAssertTrue(((rows.first?.timeRange.contains("Apr 20")) != nil))

            
        }catch{
            XCTAssertNotNil(error)
        }
    }

    
    func testFetchShiftFailed() throws {
        ShiftStore.shared.removeAllShifts()
        let viewModel: ShiftsViewModel = ShiftsViewModel(repo: ShiftRepository(dataSource: NilDataSource()))
        viewModel.fetchShifts.onNext(())
        do{
            let rows =  try viewModel.shiftsDriver.asObservable().toBlocking(timeout: 1).first()
            XCTAssertNil(rows)
            
        }catch{
            XCTAssertNotNil(error)
        }
    }

   

}
