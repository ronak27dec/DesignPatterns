//
//  BuilderExample.swift
//  DesignPatterns
//
//  Created by Ronak Malick on 30/12/25.
//

import SwiftUI

enum HTTPMethod: String {
    case get, post, put, delete
}

struct Request {
    let url: URL
    let method: HTTPMethod?
    let body: Data?
    let headers: [String: String]
    let timeout: TimeInterval?
}

class RequestBuilder {
    private let url: URL
    private var method: HTTPMethod = .get
    private var body: Data? = nil
    private var headers: [String: String] = [:]
    private var timeout: TimeInterval = 30.0
    
    init(url: URL) {
        self.url = url
    }
    
    func setMethod(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    func setHeaders(_ headers: [String: String]) -> Self {
        self.headers = headers
        return self
    }
    
    func setbody(_ body: Data?) -> Self {
        self.body = body
        return self
    }
    
    func setTimeout(_ timeout: TimeInterval) -> Self {
        self.timeout = timeout
        return self
    }
    
    func build() throws -> Request {
        
        // enforce validation
        // GET - must not contain a body
        // POST should contain a body
        // Your custom API - for which you are building this builder should not contains timeout
        
        guard self.method == .get, body != nil else {
            fatalError("Invalid request. GET should not contains a body")
            throw NSError(domain: "InvalidRequest", code: 0, userInfo: nil)
        }
        
        guard self.method == .post && body == nil else {
            fatalError("Invalid request. POST should contains a body")
            throw NSError(domain: "InvalidRequest", code: 0, userInfo: nil)
        }
        
        return Request(url: url,
                       method: method,
                       body: body,
                       headers: headers,
                       timeout: timeout)
    }
}

struct BuilderExample: View {
    
    
    
    
    // no timeout
    //    let newReq = RequestBuilder(url: URL(string: "https://httpbin.org/get")!)
    //        .setMethod(.post)
    //        .setHeaders(["Accept": "application/json"])
    //        .build()
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                do {
                    let req = try RequestBuilder(url: URL(string: "https://httpbin.org/")!)
                        .setMethod(.post)
                        .setHeaders(["Accept": "application/json"])
                        .setTimeout(10)
                        .build()
                } catch {
                    
                }
            }
    }
}

#Preview {
    BuilderExample()
}
