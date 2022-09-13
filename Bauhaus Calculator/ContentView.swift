//
//  ContentView.swift
//  Bauhaus Calculator
//
//  Created by Chelsea Hannah on 9/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CalculatorUI()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension Color {
    static let darkStart = Color(red: 55 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topTrailing, endPoint: .bottomTrailing)
    }
}

//DarkBackgrounsButton
