//
//  ContentView.swift
//  TechSmith_Calculator
//
//  Created by Joshua Jarvis on 10/27/20.
//

import SwiftUI

struct ContentView: View {
    private var negative = true
    // number variable that filters out all chars except numbers
    @ObservedObject private var number = NumberFilter()
    
    var body: some View {
        VStack{
            // Number input
            TextField("0", text: $number.value)
                .foregroundColor(Color.white)
                .font(.custom("", size: 60))
                .frame(height: 60)
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.089))
            HStack{
                Text("AC")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.gray)
                    .foregroundColor(.black)
                    .clipShape(Circle())
                    .padding(10)
                Text("+")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding(10)
                Text("-")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding(10)
            }
            HStack{
                Text("=")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding(10)
                Text("x")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding(10)
                Text("÷")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding(10)
            }
            Text("+/-")
                .frame(width: 60, height: 60)
                .font(.title)
                .background(Color.orange)
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding(10)
        }
        .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.089))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Class to filter text input to only use numbers
// returns number only text
class NumberFilter: ObservableObject {
    @Published var value = "" {
        // using didSet to execute code immediately when value is set or changed
        didSet {
            // create filter of text with numbers only, goes through each char and checks if it is a number
            let filtered = value.filter { $0.isNumber }
            // Check if value is a number
            if value != filtered {
                value = filtered
            }
        }
    }
}
