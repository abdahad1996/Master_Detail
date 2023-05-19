//
//  XCTestCase+TrackMemoryLeak.swift
//  GeoMobileTaskTests
//
//  Created by macbook abdul on 18/05/2023.
//

import Foundation
import XCTest

extension XCTestCase {
    func trackForMemoryLeacks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
