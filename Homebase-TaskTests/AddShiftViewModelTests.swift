//
//  AddShiftViewModelTests.swift
//  Homebase-TaskTests
//
//  Created by Sally Ahmed1 on 12/09/2022.
//

import XCTest
import RxBlocking
import RxSwift
@testable import Homebase_Task
class AddShiftViewModelTests: XCTestCase {
    let addShiftVM = AddShiftViewModel(repo: ShiftRepository(dataSource: StubDataSource()))
    private let disposeBag  = DisposeBag()
    override func setUpWithError() throws {
    }
    func testEmployeeData() throws {
        let expectation = expectation(description: #function)
        var  employees:[String] = []
        
        self.addShiftVM.employesDriver.drive(onNext: { value in
           employees = value
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        self.addShiftVM.fetchFormData.onNext(())
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(employees.count, 4)

    }

    func testRolesData() throws {
        let expectation = expectation(description: #function)
        var  roles:[String] = []
        
        self.addShiftVM.rolesDriver.drive(onNext: { value in
            roles = value
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        self.addShiftVM.fetchFormData.onNext(())
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(roles.count, 4)
    }
    
    func testColorsData() throws {
        let expectation = expectation(description: #function)
        var  colors:[Shift.Color] = []
        
        self.addShiftVM.colorDriver.drive(onNext: { value in
            colors = value
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        self.addShiftVM.fetchFormData.onNext(())
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(colors.count, 3)
        
    }
    
    func testStartEndDateLogic() throws {
        let expectation = expectation(description: #function)
        var  endDate:Date?
        addShiftVM.endDate.onNext(Calendar.current.date(byAdding: .day, value: -1, to: Date()))
        

        self.addShiftVM.endDateDriver.drive(onNext: { value in
            endDate = value
            expectation.fulfill()
        }).disposed(by: self.disposeBag)
        addShiftVM.startDate.onNext(Date())
        wait(for: [expectation], timeout: 2)
        XCTAssertNil(endDate)
        }
        
    func testAddShift() throws {
        let shiftCount = ShiftStore.shared.getShift()?.shifts.count ?? 0

        addShiftVM.startDate.onNext(Date())
        addShiftVM.endDate.onNext(Calendar.current.date(byAdding: .day, value: 1, to: Date()))
        addShiftVM.role.onNext("Waiter")
        addShiftVM.employee.onNext("Sally")
        addShiftVM.color.onNext(Shift.Color.red)
        addShiftVM.saveData.onNext(())
    
        addShiftVM.endDate.onNext(Calendar.current.date(byAdding: .day, value: -1, to: Date()))
        let newShifts =  ShiftStore.shared.getShift()?.shifts.count ?? 0

        XCTAssertEqual(newShifts, shiftCount + 1)
        }

}
