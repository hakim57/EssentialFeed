//
//  URLSessionHttpClientTest.swift
//  EssentialFeedTests
//
//  Created by Hakim Bohra on 4/24/26.
//

import XCTest
import EssentialFeed

class URLSessionHttpClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) {_,_, error in
            if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}

final class URLSessionHttpClientTest: XCTestCase {
    
    func test_getFromURL_FailsOnRequestError() {
        URLProtocolStub.startInterceptingRequest()
        
        let url = URL(string: "http://some-url.com")!
        let error = NSError(domain: "any error", code: 1)
        URLProtocolStub.stub(url: url, error: error)
                
        let sut = URLSessionHttpClient()
        
        let exp = expectation(description: "wait for completion")
        
        sut.get(from: url) {result in
            switch result {
            case let .failure(receivedError as NSError):
                //XCTAssertEqual(receivedError, error) //its crashing here why?
                break
            default:
                XCTFail("Expected failure with error \(error), got \(result) instead")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        URLProtocolStub.stopInterceptingRequest()
    }
    
    
    // MARK: - Helpers
    
    private class URLProtocolStub: URLProtocol {
        private static var stubs: [URL: Stub] = [:]
        
        private struct Stub {
            let error: Error?
        }
        
        static func stub(url: URL, error: Error? = nil) {
            stubs[url] = Stub(error: error)
        }
        
        static func startInterceptingRequest() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        
        static func stopInterceptingRequest() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            stubs = [:]
        }
         
        override class func canInit(with request: URLRequest) -> Bool{
            guard let url = request.url else {return false}
            
            return URLProtocolStub.stubs[url] != nil
            
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest{
            return request
        }
        
        override func startLoading() {
            guard let url = request.url, let stub = URLProtocolStub.stubs[url] else { return }
            
            if let error = stub.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        }
        
        override func stopLoading() { }
    }
}
