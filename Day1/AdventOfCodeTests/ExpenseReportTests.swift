//
//  ExpenseReportTests.swift
//  AdventOfCodeTests
//
//  Created by Allan Shortlidge on 11/29/20.
//

import AdventOfCode
import XCTest

class ExpenseReportTests: XCTestCase {

    func testExpenseReportSolve_Empty() throws {
        let emptyReport = ExpenseReport(items: [])
        
        XCTAssertNil(emptyReport.solve(sum: 0, itemCount: 0))
        XCTAssertNil(emptyReport.solve(sum: 1, itemCount: 0))
        XCTAssertNil(emptyReport.solve(sum: 1, itemCount: 1))
    }

    func testExpenseReportSolve_Single() throws {
        let report = ExpenseReport(items: [1, 2, 3])
        
        XCTAssertEqual(report.solve(sum: 1, itemCount: 1), 1)
        XCTAssertEqual(report.solve(sum: 2, itemCount: 1), 2)
        XCTAssertEqual(report.solve(sum: 3, itemCount: 1), 3)
        XCTAssertNil(report.solve(sum: 4, itemCount: 1))
    }
    
    func testExpenseReportSolve_Double() throws {
        let report = ExpenseReport(items: [1, 2, 3, 4])
        
        XCTAssertNil(report.solve(sum: 1, itemCount: 2))
        XCTAssertNil(report.solve(sum: 2, itemCount: 2))
        XCTAssertEqual(report.solve(sum: 3, itemCount: 2), 2)
        XCTAssertEqual(report.solve(sum: 4, itemCount: 2), 3)
        XCTAssertEqual(report.solve(sum: 5, itemCount: 2), 4)
        XCTAssertEqual(report.solve(sum: 6, itemCount: 2), 8)
        XCTAssertEqual(report.solve(sum: 7, itemCount: 2), 12)
        XCTAssertNil(report.solve(sum: 8, itemCount: 2))
    }

    func testExpenseReportSolve_Examples() throws {
        let report = ExpenseReport(items: [1721, 979, 366, 299, 675, 1456])
        
        XCTAssertEqual(report.solve(sum: 2020, itemCount: 2), 514_579)
        XCTAssertEqual(report.solve(sum: 2020, itemCount: 3), 241_861_950)
    }
    
}
