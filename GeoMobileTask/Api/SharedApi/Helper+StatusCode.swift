//
//  Helper.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation

extension HTTPURLResponse {
    private static var SUCCESS_200: Int { 200 }
    
    var isSuccessful: Bool { statusCode == HTTPURLResponse.SUCCESS_200 }
}
