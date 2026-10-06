//
//  LoggerFactoryExample.swift
//  DesignPatterns
//
//  Created by Ronak Malick on 29/12/25.
//

import SwiftUI

protocol Logger {
    func log(_ message: String)
}

enum LoggerType {
    case console
    case file
}

class ConsoleLogger: Logger {
    func log(_ message: String) {
        print("[CONSOLE] \(message)")
    }
}

class FileLogger: Logger {
    func log(_ message: String) {
        print("[FILE] \(message)")
    }
}

class RemoteLogger: Logger {
    func log(_ message: String) {
        print("[REMOTE] \(message)")
    }
}

enum LoggerFactory {
    static func makeLogger(type: LoggerType) -> Logger {
        switch type {
            case .console:
                ConsoleLogger()
                
            case .file:
                FileLogger()
        }
    }
}

struct LoggerFactoryExample: View {
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                let factory = LoggerFactory.makeLogger(type: .console)
                factory.log("Hello Factory!")
            }
    }
}
