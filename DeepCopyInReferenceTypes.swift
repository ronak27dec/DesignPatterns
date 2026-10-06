//
//  DeepCopyInReferenceTypes.swift
//  DesignPatterns
//
//  Created by Ronak Malick on 30/12/25.
//

import SwiftUI

fileprivate class Engine {
    var power: Int
    
    init(power: Int) {
        self.power = power
    }
    
    func copy() -> Engine {
        Engine(power: power)
    }
}

fileprivate struct Car {
    var engine: Engine
    
    init(engine: Engine) {
        self.engine = engine
    }
    
    init(copying car: Car) {
        self.engine = car.engine.copy()
    }
}

fileprivate class Address {
    var address: String
    
    init(address: String) {
        self.address = address
    }
}

fileprivate class Person {
    var name: String
    var address: Address
    
    init(name: String, address: Address) {
        self.name = name
        self.address = address
    }
    
    func copy() -> Person {
        Person(name: name, address: address)
    }
}

struct DeepCopyInReferenceTypes: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                let p1 = Person(name: "Ronak", address: Address(address: "Delhi"))
                let p2 = p1.copy()
                p2.address = Address(address: "Bangalore")
                
                print("P1 Name: \(p1.address.address)")
                print("P2 Name: \(p2.address.address)")
                
                let car1 = Car(engine: Engine(power: 100))
                let car2 = Car(copying: car1) // deep copy - creates separate copies for car1 and car2
                car2.engine.power = 200 // this is shallow copy
                
                print("Car1 Engine Power: \(car1.engine.power)")
                print("Car2 Engine Power: \(car2.engine.power)")
            }
    }
}

#Preview {
    DeepCopyInReferenceTypes()
}
