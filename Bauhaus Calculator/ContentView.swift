//
//  ContentView.swift
//  Bauhaus Calculator
//
//  Created by Chelsea Hannah on 9/12/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       // CalculatorUI()
        let Virgil : String = "Calculator"
        Text(#" "\#(Virgil)" "#)
         //   .font(custom("Adobe Garamond Pro", size, 20))
        //load in font
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
struct DarkBackground<myShape: Shape>: View {
    var isTapped: Bool
    var shape: myShape
    
    var body: some View {
        ZStack {
            if isTapped {
                shape
                    .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                    .overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4))
                
                    .shadow(color: Color.darkStart, radius: 10, x: -5, y: -5)
                    .shadow(color: Color.darkEnd, radius: 5, x: -5, y: -5)
            } else {
                shape.fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4))
                
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct DarkButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .contentShape(RoundedRectangle(cornerRadius: 35))
            .frame(width: 87, height: 85, alignment: .center)
            .background(
                DarkBackground(isTapped: configuration.isPressed, shape: RoundedRectangle(cornerRadius: 35))
                )
        
    }
}

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "A/C"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self
        {
        case .clear :
            return .orange
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .negative, .percent:
            return Color.white
        default:
            return Color.white
        }
    }
    //Button Colors
}

enum Operations {
    case add, subtract, multiply, divide, none
}

struct CalculatorUI: View {
    @State var value = "0"
}
