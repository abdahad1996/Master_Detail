//
//  MainDecorator.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 16/05/2023.
//

import Foundation
 final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
//    func dispatch(completion: @escaping () -> Void) {
//        if Thread.isMainThread {
//            completion()
//        } else {
//            DispatchQueue.main.async {
//                completion()
//            }
//        }
//    }
}

extension MainQueueDispatchDecorator: UserLoader where T == UserLoader {
   
    @MainActor
    func load() async throws -> (UserLoader.Result) {
        
          
               return try await   decoratee.load()
            // UI work
          

    
         
    }
    
    
//    func load(completion: @escaping (UserLoader.Result) -> Void) {
//        decoratee.load { [weak self] result in
//            self?.dispatch {
//                completion(result)
//            }
//        }
//    }
}
