//
//  ThemeAbstractFactoryView.swift
//  DesignPatterns
//
//  Created by Ronak Malick on 30/12/25.
//

import SwiftUI

protocol CustomButton {
    func render()
}

protocol CustomLabel {
    func render()
}

class LightButton: CustomButton {
    func render() {
        print("Light Button")
    }
}

class LightLabel: CustomLabel {
    func render() {
        print("Light Label")
    }
}

class DarkButton: CustomButton {
    func render() {
        print("Dark Buttons")
    }
}

class DarkLabel: CustomLabel {
    func render() {
        print("Dark Label")
    }
}

protocol ThemeFactory {
    func makeButton() -> CustomButton
    func makeLabel() -> CustomLabel
}

class LightThemeFactory: ThemeFactory {
    func makeButton() -> any CustomButton {
        LightButton()
    }
    
    func makeLabel() -> any CustomLabel {
        LightLabel()
    }
}

class DarkThemeFactory: ThemeFactory {
    func makeButton() -> any CustomButton {
        DarkButton()
    }
    
    func makeLabel() -> any CustomLabel {
        DarkLabel()
    }
}

struct ThemeAbstractFactoryView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                let factory: ThemeFactory = LightThemeFactory()
                factory.makeButton().render()
                factory.makeLabel().render()
            }
    }
}

#Preview {
    ThemeAbstractFactoryView()
}
