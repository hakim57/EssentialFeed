//
//  HttpClient.swift
//  EssentialFeed
//
//  Created by Hakim Bohra on 4/9/26.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL,  completion: @escaping (HTTPClientResult) -> Void)
}
