//
//  ImageCacheManager.swift
//  Mowee
//
//  Created by Mojisola Adebiyi on 25/05/2021.
//

import Foundation

/// Responsible for caching fetching and caching images by their URL strings
class ImageCacheManager {
    static let cache = NSCache<NSString, NSData>()

    static func fetchImageData(from url: String, completion: @escaping (NSData) -> (Void)){
        let key = NSString(string: url)
        if let cachedVersion = cache.object(forKey: key) {
            DispatchQueue.global(qos: .background).async {
                completion(cachedVersion)
            }
        } else {
            DispatchQueue.global(qos: .background).async {
                guard let url = URL(string: url) else {return}
                guard let ddata = try? Data(contentsOf: url) else {return}
                let ns = NSData(data: ddata)
                cache.setObject(ns, forKey: key)
                completion(ns)
            }
        }
    }
    
}
