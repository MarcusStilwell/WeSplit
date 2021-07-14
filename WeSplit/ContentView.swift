//
//  ContentView.swift
//  WeSplit
//
//  Created by Marcus Stilwell on 6/23/21.
//

import SwiftUI

struct redForZero: ViewModifier{
    func body(content: Content) -> some View {
        Text("Hello World")
    }
}

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    @State private var tipIsZero = false
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double{
        let peopleCount = Double(Int(numberOfPeople) ?? 0 + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var totalForAll: Double{
        return totalPerPerson * Double(Int(numberOfPeople) ?? 0)
    }
    
    var body: some View {
        NavigationView{
        Form {
            Section {
                TextField("Amount", text: $checkAmount)
                    .keyboardType(.decimalPad)
                
                TextField("Number of people", text: $numberOfPeople)
                    .keyboardType(.numberPad)
            }
        
            Section(header: Text("How much tip do you want to leave?")){
                Picker("Tip percentage", selection: $tipPercentage) {
                    ForEach(0 ..< tipPercentages.count){
                        Text("\(self.tipPercentages[$0])%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Amount per person")){
                Text("$\(totalPerPerson, specifier: "%.2f")")
            }
            
            Section(header: Text("Total bill")){
                Text("$\(totalForAll, specifier: "%.2f")")
                    .foregroundColor(tipPercentage == 4 ? .red : .black)
            }
        }
        }
        .navigationBarTitle("WeSplit")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
