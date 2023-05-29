//
//  URLSessionHTTPClient.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation
class URLSessionHTTPClient : HTTPClient {
    
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    enum NetworkError: Error {
        case non200
        case nonHTTPURLResponse
        case failedAuthRetry
    }
    
    func get(from url: URL) async throws -> HTTPClient.Result {
        let (data,urlResponse) = try await session.data(from: url)
        do {
            guard let response = urlResponse as? HTTPURLResponse else{
                throw NetworkError.nonHTTPURLResponse
            }
            guard response.statusCode == 200 else{
                throw NetworkError.non200
            }
            return (data,response)
            
        }catch (let error){
            throw error
        }
        
       
    }
    
//    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
//        let task = session.dataTask(with: url) { data, response, error in
//            completion(Result {
//                if let error = error {
//                    throw error
//                } else if let data = data, let response = response as? HTTPURLResponse {
//                    return (data, response)
//                } else {
//                    throw UnexpectedValuesRepresentation()
//                }
//            })
//        }
//        task.resume()
//        return URLSessionTaskWrapper(wrapped: task)
//    }
    
}
