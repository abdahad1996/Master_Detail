//
//  Helpers.swift
//  GeoMobileTaskTests
//
//  Created by macbook abdul on 19/05/2023.
//

import Foundation
@testable import GeoMobileTask

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    URL(string: "https://any-url.com")!
}

func anyData() -> Data {
    Data("any data".utf8)
}

func anyHTTPURLResponse() -> HTTPURLResponse {
    HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
}

func nonHTTPURLResponse() -> URLResponse {
    URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
}

func uniqueUserModel() -> [User] {
    let users = [User(id: 0, email: "a@live.com", firstName: "abdul", lastName: "ahad", avatar: "adad")]
    return users
}
func makeItemsJSON(_ items: [[String: Any]]) -> Data {
    return try! JSONSerialization.data(withJSONObject: items)
}
