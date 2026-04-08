//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Hakim Bohra on 4/8/26.
//

import XCTest

class RemoteFeedLoader {
    
}

class HTTPClient {
    var requetedURL: URL?
}



final class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let _ = RemoteFeedLoader()
        let client = HTTPClient()
        XCTAssertNil(client.requetedURL)
    }
}
