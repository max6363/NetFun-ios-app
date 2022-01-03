//
//  ProfilesViewModel.swift
//  NetFun-ios-app
//
//  Created by Minhaz on 29/12/21.
//

import Foundation
import Combine
import NetFunCore
import SwiftUI

public class ProfilesViewModel: ObservableObject {
    
    /// A public variable as an Array to store `UserAPIModel`,
    /// initialized with empty array.
    ///
    /// The @Published variable can be subscribed and get notified when the array is updated
    @Published var profiles = [UserAPIModel]()
    
    @Published var errorReceived: AppError? = nil
    
    var profileSubscription = CurrentValueSubject<[UserAPIModel], AppError>([UserAPIModel]())
    
    var selectedProfile: UserAPIModel? = UserAPIModel(id: 700, name: "", username: "") // TODO: temp - dev
    
    @Published var homeContent = HomeContentAPIModel.init(collection: [CollectionItemData]())
    
    var homeDataSubscription = PassthroughSubject<HomeContentAPIModel, AppError>()
    
    /// A `Set` of subscriptions which are cancellable
    public var subscriptions = Set<AnyCancellable>()
    
    init() {
        subscribeToProfiles()
        subscribeToHomeData()
    }
    
    private func subscribeToProfiles() {
        profileSubscription
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] completion in
                
                switch completion {
                case .finished:
                    self.errorReceived = nil
                case .failure(let error):
                    self.errorReceived = error
                }
                
            } receiveValue: { [unowned self] profilesResponse in
                self.profiles = profilesResponse
            }
            .store(in: &subscriptions)
    }
    
    private func subscribeToHomeData() {
        homeDataSubscription
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
                switch completion {
                case .finished:
                    self.errorReceived = nil
                case .failure(let error):
                    self.errorReceived = error
                }
                
            } receiveValue: { homeData in
                self.homeContent = homeData
            }
            .store(in: &subscriptions)
    }
    
    func fetchProfiles() {
        Services.fetchProfiles { [unowned self] result in
            switch result {
            case .success(let response):
                print("profiles: ", response)
                self.profileSubscription.send(response)
                break
                
            case .failure(let error):
                self.profileSubscription.send(completion: .failure(error))
                break
            }
        }
    }
    
    func fetchHomeContent() {
        if let p = selectedProfile {
            Services.fetchHomeContent(for: p) { [unowned self] result in
                switch result {
                case .success(let response):
                    print("Home Response: ", response)
                    self.homeDataSubscription.send(response)
                    break
                    
                case .failure(let error):
                    print("Home content fetching error: ", error.localizedDescription)
                    self.homeDataSubscription.send(completion: .failure(error))
                    break
                }
            }
        }
    }
    
    deinit {
        
    }
}
