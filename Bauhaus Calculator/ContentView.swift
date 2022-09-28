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

//Colors
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

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
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
        case .add, .subtract, .multiply:
            return Color(UIColor(red: 235/255.0, green: 155/255.0, blue: 42/255.0, alpha: 1))
        case .clear, .negative, .percent, .divide:
            return Color(UIColor(red: 18/255.0, green: 103/255.0, blue: 193/255.0, alpha: 1))
        case  .equal:
            return Color(UIColor(red: 248/255.0, green: 44/255.0, blue: 56/255.0, alpha: 1))
        default:
            return Color(UIColor(red: 235/255.0, green: 155/255.0, blue: 42/255.0, alpha: 1))
            
        }
    }
    //Button Text Colors
}

enum Operations {
    case add, subtract, multiply, divide, none
}

struct CalculatorUI: View {
    
    @State var value = "0"
    @State var operationname = ""
    @State var runningNumber = 0
    @State var currentOperation: Operations = .none
    
    let button: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack {
            //Background
            Image("Background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    Divider()
                        .frame(width: 330,
                               height: 3,
                               alignment: .trailing)
                        .overlay(.black)
                        .padding(.leading, 24.0)
                        .padding(.top, 160.0)
            
                    HStack {
                        Spacer()
                        Text(value)
                        //needs custom font
                            .font(.title)
                            
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.top, 130.0)
                            .padding(.trailing, 10)
                            .frame( height: 200)
                    } //Final Value Section
                    
                    .offset(x: -10, y: -10)
                    .padding()
                    
                }
               
                Spacer()
                    .frame(height: 2.0)
                //Buttons
                ForEach(button, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                ZStack {
                                    Text(item.rawValue)
                                        .font(.system(size: 32))
                                        .fontWeight(.bold)
                                }
                                .frame(
                                        //width: 80,
                                       // height: 80
                                    width: self.buttonWidth(item: item),
                                    height: self.buttonHeight(item: item)
                                    
                                        )
                                        .background(
                                            item.buttonColor
                                                .shadow(color: .gray, radius: 2, x: 0, y: 2))
                                        //button design
                                    .foregroundColor(.black)
                                //text color
                            })
                            
                        }
                    }
                    .padding(.bottom, 3)
                    
                }
                
            }
            
        }
       
    }

    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
                self.operationname = "ADD"
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
                self.operationname = "SUBTRACT"
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
                self.operationname = "MULTIPLY"
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
                self.operationname = "DIVIDE"
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                    
                case .add:
                    self.value = "\(runningValue + currentValue)"
                    
                case .subtract:
                    self.value = "\(runningValue - currentValue)"
                    
                case .multiply:
                    self.value = "\(runningValue * currentValue)"
                    
                case .divide:
                    self.value = "\(runningValue / currentValue)"
                    
                case .none:
                    break
                }
                self.operationname = "EQUAL"
            }
            if button != .equal {
                self.value = "0"
            }
        case.clear:
            self.value = "0"
            self.operationname = "CLEAR"
       
        case .decimal, .negative, .percent:
            break
       
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
        
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }

    func buttonHeight(item: CalcButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }

}


