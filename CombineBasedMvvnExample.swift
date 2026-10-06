//
//  CombineBasedMvvnExample.swift
//  DesignPatterns
//
//  Created by Ronak Malick on 31/12/25.
//

import SwiftUI
import Combine

fileprivate struct User {
    var id: Int
    var name: String
    var email: String
}

fileprivate class UserApiClient {
    func fetchUser(onCompletion: @escaping (User) -> (Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let user = User(id: 120, name: "Ronak", email: "ronak@gmail.com")
            onCompletion(user)
        }
    }
}

@MainActor
fileprivate class UserViewModel {
    let publisher = PassthroughSubject<User, Never>()
    
    
    let subject = PassthroughSubject<User, Never>()
    
    let client = UserApiClient()
    
    func fetchUser() {
        client.fetchUser {[weak self] user in
            self?.publisher.send(user)
        }
    }
    
    func fetchNewUser() -> AnyPublisher<User, Never> {
        Future {[weak self] promise in
            self?.client.fetchUser { user in
                promise(.success(user))
            }
        }
        .eraseToAnyPublisher()
    }
}


struct CombineBasedMvvnExample: View {
    fileprivate var vm = UserViewModel()
    @State private var cancellable: AnyCancellable?
    @State private var user: User?
    
    @Binding private var newUser: User?
    
    @State private var cancellable2 = Set<AnyCancellable>()
    
    var body: some View {
        Text(user?.name ?? "NA")
            .onAppear {
                subscribe3()
            }
            .onDisappear {
                cancellable?.cancel()
                cancellable = nil
            }
    }
    
    // better way for single subscription
    func subscribe() {
        cancellable = vm.publisher
            .first()
            .receive(on: DispatchQueue.main)
            .sink { user in
                self.user = user
            }
    }
    
    func subscribe2() {
        guard cancellable2.isEmpty else { return }
        vm.publisher
            .first()
            .receive(on: DispatchQueue.main)
            .sink { user in
                self.user = user
            }
            .store(in: &cancellable2) // allows you to keep a strong ref
    }
    
    func subscribe3() {
        vm.fetchNewUser()
            .receive(on: DispatchQueue.main)
            .sink { user in
                self.user = user
            }
            .store(in: &cancellable2)
    }
}
