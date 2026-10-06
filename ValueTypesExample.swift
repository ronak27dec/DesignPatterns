//
//  ValueTypesExample.swift
//  DesignPatterns
//
//  Created by Ronak Malick on 30/12/25.
//

import SwiftUI

fileprivate class Address {
    var info: String
    
    init(info: String) {
        self.info = info
    }
    
    func copy() -> Address {
        Address(info: self.info)
    }
}

fileprivate struct Person {
    var name: String
    var address: Address
    
    init(name: String, address: Address) {
        self.name = name
        self.address = address
    }
    
    init(copying address: Address, name: String) {
        self.address = address.copy()
        self.name = name
        
    }
}


struct ValueTypesExample: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                let p1 = Person(name: "Ronak", address: Address(info: "Bangalore"))
                var p2 = p1 // deep copy
                
                var p3 = Person(copying: p1.address, name: p1.name) // deep copy
                
                p2.address.info = "Delhi" // shallow copy
                p2.name = "Rahul"
                
                p3.name = "Aman"
                p3.address.info = "Mumbai"
                
                // name is deep copied.
                print("P1 name: \(p1.name)") // ronak
                print("P2 name: \(p2.name)") // rahul
                print("P3 name: \(p3.name)") // Aman
                
                // address is shallow copied. shared reference
                print("P1 address: \(p1.address.info)") // Delhi
                print("P2 address: \(p2.address.info)") // Delhi
                print("P3 address: \(p3.address.info)") // mumbai
            }
    }
}

#Preview {
    ValueTypesExample()
}
