//
//  Services.swift
//  NetFun-ios-app
//
//  Created by Minhaz on 29/12/21.
//

import Foundation
import NetFunCore

struct ProfilesFetchRequestModel: RequestModel {
    var path: String = "/profiles"
    
    var parameters: [String : String]? = nil
    
    var headers: [String : String] = [:]
    
    var method: RequestHTTPMethod = .get
    
    var body: [String : Any]? = nil
    
}

struct HomeContentFetchRequestModel: RequestModel {
    
    var profileID: Int
    
    var path: String {
        get { return "/profilehome/" + String(format: "%ld", profileID) }
        set { }
    }
    
    var parameters: [String : String]? = nil
    
    var headers: [String : String] = [:]
    
    var method: RequestHTTPMethod = .get
    
    var body: [String : Any]? = nil
}

class Services {
    class func fetchProfiles(completion: @escaping(Result<[UserAPIModel], AppError>) -> Void) {
        ServiceManager
            .shared
            .sendRequest(request: ProfilesFetchRequestModel()) { result in
                completion(result)
            }
    }
    
    class func fetchHomeContent(for profile: UserAPIModel,
                                completion: @escaping(Result<HomeContentAPIModel, AppError>) -> Void) {
        ServiceManager
            .shared
            .sendRequest(request: HomeContentFetchRequestModel(profileID: profile.id)) { result in
                completion(result)
            }
    }
}
