//
//  RequestModel.swift
//  NetFun-ios-app
//
//  Created by Minhaz on 29/12/21.
//

import Foundation

enum RequestHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol RequestModel {
    var path: String { get set }
    var parameters: [String: String]? { get set }
    var headers: [String: String] { get set }
    var method: RequestHTTPMethod { get set }
    var body: [String: Any]? { get set }
}

extension RequestModel {
    func urlRequest() -> URLRequest {
        var endpoint: String = ServiceManager.shared.baseURL.appending(path)
        
        if let parameters = parameters {
            for parameter in parameters {
                endpoint.append("?\(parameter.key)=\(parameter.value)")
            }
        }
        
        var request: URLRequest = URLRequest(url: URL(string: endpoint)!)
        
        request.httpMethod = method.rawValue
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if method == RequestHTTPMethod.post, let body = body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch let error {
                print("Request body parse error: \(error.localizedDescription)")
            }
        }
        
        return request
    }
}
