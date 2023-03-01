//
//  ContentView.swift
//  PrefixCalculator
//
//  Created by Denis Abramov on 02.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var saveValue = 0
    @State var currentOperation: Operation = .none
    @State var memoryOperation: MemoryOperation = .none

    let buttons: [[CalculatorButton]] = [
        [.clear, .save, .paste, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .equal],
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                // Text display
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()

                // Our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button( action: { self.didTap(button: item) },
                                   label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(item: item),
                                        height: self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalculatorButton) {
        
        switch button {
        case .add, .subtract, .mutliply, .divide, .equal, .save, .paste:
            
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .mutliply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .save {
                self.memoryOperation = .save
                self.runningNumber = Int(self.value) ?? 0
                saveValue = self.runningNumber
                
                switch self.memoryOperation {
                case .save:
                    self.value = "\(saveValue)"
                    print(saveValue)
                case .paste, .none:
                    break
                }
                print("SAVE")
            } else if button == .paste {
                self.memoryOperation = .paste
                self.runningNumber = saveValue
                print("START PASTE")
                print(saveValue)
                print(runningNumber)
                
                switch self.memoryOperation {
                case .save:
                    break
                case .paste:
                    self.value = "\(runningNumber)"
                    print(runningNumber)
                    print(saveValue)
                case .none:
                    break
                }
                print("PASTE")
            } else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                
                switch self.currentOperation {
                case .add:
                    self.value = "+\(runningValue)\(currentValue)"
                case .subtract:
                    self.value = "-\(runningValue)\(currentValue)"
                case .multiply:
                    self.value = "×\(runningValue)\(currentValue)"
                case .divide:
                    self.value = "÷\(runningValue)\(currentValue)"
                case .none:
                    break
                }
            }

            if button != .equal {
                self.value = "0"
            }
            
            if button == .paste {
                self.value = "\(saveValue)"
            }
            
        case .clear:
            self.value = "0"
            
        default:
            let number = button.rawValue
            
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }

    func buttonWidth(item: CalculatorButton) -> CGFloat {
       
        if item == .zero {
            return (UIScreen.main.bounds.width - (2 * 12)) / 4 * 3
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

struct ContentViewPreviews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
