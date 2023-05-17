//
//  UserLoaderWithFallBackComposite.swift
//  GeoMobileTask
//
//  Created by macbook abdul on 17/05/2023.
//

import Foundation

final class UserLoaderWithFallbackComposite: UserLoader {
    private let primary: UserLoader
    private let fallback: UserLoader
    
    init(primary: UserLoader, fallback: UserLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func load(completion: @escaping (UserLoader.Result) -> Void) {
        primary.load { [weak self] result in
            switch result {
            case .success:
                completion(result)
                
            case .failure:
                self?.fallback.load(completion: completion)
            }
        }
    }
}
