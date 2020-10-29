//
//  CalculatorView.swift
//  TechSmith_Calculator
//
//  Created by Joshua Jarvis on 10/27/20.
//

import SwiftUI

// CalculatorView which sets up the UI and stores a controller for the calculator logic
struct CalculatorView: View {
    
    // CalculatorController object that runs the logic of the calculator
    @ObservedObject private var controller = CalculatorController()
    
    // number variable that filters out all chars except numbers
    @ObservedObject private var number = NumberFilter()
    
    // UI Design
    var body: some View {
        VStack{
            // Number input text field
            HStack{
                if controller.negative {
                    Text("-")
                        .foregroundColor(Color.white)
                        .font(.custom("", size: 60))
                        .frame(height: 60)
                        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.089))
                }
                TextField("0", text: $number.value)
                    .foregroundColor(Color.white)
                    .font(.custom("", size: 60))
                    .frame(height: 60)
                    .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.089))
            }
            HStack{
                Button(action: {
                    print("All Clear")
                    controller.allClear()
                    number.value = ""
                }) {
                    Text("AC")
                        .frame(width: 60, height: 60)
                        .font(.title)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                    .buttonStyle(PlainButtonStyle())
                    .padding(10)
                Button(action: {
                    print("Add")
                    number.value = controller.add(num: Int(number.value) ?? 0)
                }) {
                    Text("+")
                        .frame(width: 60, height: 60)
                        .font(.title)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                    .buttonStyle(PlainButtonStyle())
                    .padding(10)
                Button(action: {
                    print("Subtract")
                    number.value = controller.subtract(num: Int(number.value) ?? 0)
                }) {
                    Text("-")
                        .frame(width: 60, height: 60)
                        .font(.title)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                    .buttonStyle(PlainButtonStyle())
                    .padding(10)
            }
            HStack{
                Button(action: {
                    print("Negative")
                    controller.negativeTap()
                }) {
                    Text("+/-")
                        .frame(width: 60, height: 60)
                        .font(.title)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                    .buttonStyle(PlainButtonStyle())
                    .padding(10)
                Button(action: {
                    print("Multiply")
                    number.value = controller.multiply(num: Int(number.value) ?? 0)
                }) {
                    Text("x")
                        .frame(width: 60, height: 60)
                        .font(.title)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                    .buttonStyle(PlainButtonStyle())
                    .padding(10)
                Button(action: {
                    print("Divide")
                    number.value = controller.divide(num: Int(number.value) ?? 0)
                }) {
                    Text("÷")
                        .frame(width: 60, height: 60)
                        .font(.title)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                    .buttonStyle(PlainButtonStyle())
                    .padding(10)
            }
            Button(action: {
                print("Equals")
                number.value = controller.equals(num: Int(number.value) ?? 0)
            }) {
                Text("=")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
                .buttonStyle(PlainButtonStyle())
                .padding(10)
        }
        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.089))
    }
}

// Class to filter text input to only use numbers
// returns number only text
// Code retrieved from tutorial https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
class NumberFilter: ObservableObject {
    // Published wrapper allows value to be automatically updated using the number filter
    @Published var value = "" {
        // using didSet to execute code immediately when value is set or changed
        didSet {
            // create filter of text with numbers only, goes through each char and checks if it is a number
            let filtered = value.filter { $0.isNumber }
            // Check if value is the same as filtered
            if value != filtered {
                value = filtered
            }
        }
    }
}

// CalculatorController which holds the logic of the calculator
class CalculatorController: ObservableObject {
    // Variable to track negative button
    @Published var negative = false
    private var currentNumber = 0
    private var previousNumber = 0
    // Variable which holds the current operation to be executed
    private var operatorSymbol = ""
    
    // Add function: Takes in num, executes current operation, and then sets up the next operation to be addition
    func add(num: Int) -> String {
        self.updateCurrentNumber(num: num)
        self.execute()
        self.operatorSymbol = "+"
        return String(self.currentNumber)
    }
    
    // Subtract function: Takes in num, executes current operation, and then sets up the next operation to be subtraction
    func subtract(num: Int) -> String {
        self.updateCurrentNumber(num: num)
        self.execute()
        self.operatorSymbol = "-"
        return String(self.currentNumber)
    }
    
    // Multiply function: Takes in num, executes current operation, and then sets up the next operation to be multiplication
    func multiply(num: Int) -> String {
        self.updateCurrentNumber(num: num)
        self.execute()
        self.operatorSymbol = "x"
        return String(self.currentNumber)
    }
    
    // Divide function: Takes in num, executes current operation, and then sets up the next operation to be division
    func divide(num: Int) -> String {
        self.updateCurrentNumber(num: num)
        self.execute()
        self.operatorSymbol = "/"
        return String(self.currentNumber)
    }
    
    // Equals function: Takes in num and then executes the current operation
    func equals(num: Int) -> String {
        self.updateCurrentNumber(num: num)
        self.execute()
        self.operatorSymbol = ""
        return String(self.currentNumber)
    }
    
    // Execute function determines the current operation and executes it with the current and previous numbers accordingly
    func execute() {
        // Using a switch in order to easily check which operation is taking place
        switch self.operatorSymbol {
        case "+":
            self.currentNumber = self.currentNumber + self.previousNumber
        case "-":
            self.currentNumber = self.previousNumber - self.currentNumber
        case "x":
            self.currentNumber = self.currentNumber * self.previousNumber
        case "/":
            self.currentNumber = self.previousNumber / self.currentNumber
        default:
            print("No math")
        }
        if self.currentNumber < 0{
            self.negative = true
        }
    }
    
    // Getter for currentNumber
    func getCurrentNumber() -> String {
        return String(self.currentNumber)
    }
    
    // Setter for currentNumber
    func setCurrentNumber(num: Int) {
        self.currentNumber = num
    }
    
    // Function to update the current and previous numbers
    func updateCurrentNumber(num: Int) {
        self.previousNumber = self.currentNumber
        self.currentNumber = num
        if self.negative{
            self.currentNumber *= -1
            self.negative = false
        }
        print("Current Number: " + String(self.currentNumber))
        print("Previous Number: " + String(self.previousNumber))
    }
    
    // All Clear function: resets calculator
    func allClear() {
        self.currentNumber = 0
        self.previousNumber = 0
        self.operatorSymbol = ""
    }
    
    // Negative Tap: Switches current number between negative and positive
    func negativeTap() {
        self.negative = !self.negative
    }
}
