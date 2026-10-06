//
//  PrototypeExample.swift
//  DesignPatterns
//
//  Created by Ronak Malick on 30/12/25.
//

import SwiftUI


protocol Prototype {
    func clone() -> Self
}

final class Document: Prototype {
    var title: String
    var content: String
    
    required init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    func clone() -> Document {
        Document(title: title, content: content)
    }
}

struct PrototypeExample: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                let baseDoc = Document(title: "Hello", content: "World")
                let newDoc = baseDoc.clone()
                newDoc.title = "Updated"
                print(baseDoc.title)
                print(newDoc.title)
                print(newDoc.content)
            }
    }
}

#Preview {
    PrototypeExample()
}
