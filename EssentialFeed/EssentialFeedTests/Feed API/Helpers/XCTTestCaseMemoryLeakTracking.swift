//
//  XCTTestCaseMemoryLeakTracking.swift
//  EssentialFeedTests
//
//  Created by Hakim Bohra on 4/27/26.
//

import XCTest

extension XCTestCase {
    
    func trackForMemoryLeaks(instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated, potential memory leak", file: file, line: line)
        }
    }
    
}
