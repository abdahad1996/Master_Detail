//
//  HttpClient.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation

protocol HTTPClientTask {
    func cancel()
}

typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

protocol HTTPClient {
    @discardableResult
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) -> HTTPClientTask
}
