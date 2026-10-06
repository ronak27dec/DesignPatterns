//
//  StaticPolymorphismUsingGenerics.swift
//  DesignPatterns
//
//  Created by Ronak Malick on 16/01/26.
//

import Foundation

protocol Drawable {
    func draw()
}

struct Circle: Drawable {
    func draw() {
        print("Drawing a circle")
    }
}

class StaticPolymorphismUsingGenerics<T: Drawable> {
 
    func drawShape(shape: T) {
        shape.draw()
    }
}

let circle = Circle()
let shape = StaticPolymorphismUsingGenerics<Circle>()
shape.drawShape(shape: circle)
