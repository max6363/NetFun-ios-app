//
//  String+Extension.swift
//  NetFun-ios-app
//
//  Created by Minhaz on 29/12/21.
//

import Foundation

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
