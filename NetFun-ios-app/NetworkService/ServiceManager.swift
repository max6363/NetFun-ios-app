//
//  ServiceManager.swift
//  NetFun-ios-app
//
//  Created by Minhaz on 29/12/21.
//

import Foundation

class ServiceManager {
    static let shared: ServiceManager = ServiceManager()
    var baseURL: String = "http://127.0.0.1:8080/api"
}

extension ServiceManager {
    
    func sendRequest<T: Codable>(request: RequestModel, completion: @escaping(Result<T, AppError>) -> Void) {
        URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
            
            guard let data = data, let parsedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                
                let error: AppError = AppError(ErrorType.parsing.rawValue)
                completion(.failure(error))
                return
            }
            
            var responseModel: ResponseModel<T> = .init()
            responseModel.isSuccess = true
            responseModel.data = parsedResponse
            responseModel.rawData = data
            responseModel.request = request

            if responseModel.isSuccess, let data = responseModel.data {
                completion(Result.success(data))
            } else {
                completion(Result.failure(AppError.generalError()))
            }
            
        }.resume()
    }
}
