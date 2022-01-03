//
//  AppError.swift
//  NetFun-ios-app
//
//  Created by Minhaz on 29/12/21.
//

import Foundation

class AppError: Error {
    
    // MARK: - Properties
    var messageKey: String
    var message: String {
        return messageKey.localized()
    }
    
    init(_ messageKey: String) {
        self.messageKey = messageKey
    }
}

// MARK: - Public Functions
extension AppError {
    
    class func generalError() -> AppError {
        return AppError(ErrorType.general.rawValue)
    }
}
