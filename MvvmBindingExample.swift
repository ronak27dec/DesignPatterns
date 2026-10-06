//
//  MvvmBindingExample.swift
//  DesignPatterns
//
//  Created by Ronak Malick on 31/12/25.
//

import SwiftUI

/*
* CLOSURE BASED MVVM
*/

fileprivate class UserApiClient {
        
    func fetchUser(onCompletion: @escaping (User) -> (Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let user = User(id: 120, name: "Ronak", email: "ronak@gmail.com")
            onCompletion(user)
        }
    }
}

fileprivate struct User {
    var id: Int
    var name: String
    var email: String
}

fileprivate class MvvmBindingExampleViewModel {
    
    var onUserChange: ((User?) -> (Void))?
    let api = UserApiClient()
    
    private var user: User? {
        didSet {
            onUserChange?(user ?? nil)
        }
    }
    
    func fetchUser() {
        api.fetchUser {[weak self] user in
            self?.user = user
        }
    }
}


struct MvvmBindingExample: View {
    
    fileprivate let vm = MvvmBindingExampleViewModel()
    
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                vm.fetchUser()
                
                vm.onUserChange = { user in
                    print(user?.name ?? "NA")
                    print(user?.id ?? 00)
                }
            }
    }
}

#Preview {
    MvvmBindingExample()
}
