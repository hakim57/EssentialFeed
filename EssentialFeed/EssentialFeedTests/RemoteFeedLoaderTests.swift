//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Hakim Bohra on 4/8/26.
//

import XCTest

class RemoteFeedLoader {
    
    func load() {
        HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
    }
    
}

class HTTPClient {
    static let shared = HTTPClient()
    private init() {}
    var requestedURL: URL?
}



final class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let _ = RemoteFeedLoader()
        let client = HTTPClient.shared
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let sut = RemoteFeedLoader()
        let client = HTTPClient.shared
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
        
    }
}
