//
//  URLSessionHttpClientTest.swift
//  EssentialFeedTests
//
//  Created by Hakim Bohra on 4/24/26.
//

import XCTest


class URLSessionHttpClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL) {
        session.dataTask(with: url) {_,_,_ in }
    }
}

final class URLSessionHttpClientTest: XCTestCase {

    func test_getFromURL_createsDataTaskWithURL() {
        let url = URL(string: "http://some-url.com")!
        let urlSession = URLSessionSpy()
        let sut = URLSessionHttpClient(session: urlSession)
        
        sut.get(from: url)
        
        XCTAssertEqual(urlSession.receivedURLs, [url])
    }
    
    // MARK: - Helpers
    
    private class URLSessionSpy: URLSession {
        var receivedURLs: [URL] = []
        
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
            receivedURLs.append(url)
            return FakeURLSessionDataTask()
        }
    }
    
    private class FakeURLSessionDataTask: URLSessionDataTask {}

}
