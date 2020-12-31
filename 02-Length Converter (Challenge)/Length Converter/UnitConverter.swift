//
//  ContentView.swift
//  Length Converter
//
//  Created by Felix Leitenberger on 31.12.20.
//

import SwiftUI

struct UnitConverter: View {
    
    enum Units: String, CaseIterable {
        case meters = "m"
        case kilometers = "km"
        case feets = "feet"
        case yards = "yards"
        case miles = "miles"
    }
    
    let unitLength = [Units.meters : UnitLength.meters, Units.kilometers : UnitLength.kilometers, Units.feets : UnitLength.feet, Units.yards : UnitLength.yards, Units.miles : UnitLength.miles]
    
    let inputUnits = Units.allCases
    let outputUnits = Units.allCases
    
    @State private var selectedInputUnitString = Units.kilometers
    @State private var selectedOutputUnitString = Units.miles
    
    @State private var inputValueString = ""
    
    var outputValue: Double {
        let inputValue = Measurement(value: Double(inputValueString) ?? 0, unit: unitLength[selectedInputUnitString]!)
        let output = inputValue.converted(to: unitLength[selectedOutputUnitString]!)
        
        return output.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Value to convert:")) {
                    TextField("...", text: $inputValueString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        
                    Picker("Input unit:", selection: $selectedInputUnitString) {
                        ForEach(inputUnits, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Select unit to convert to:")) {
                    Picker("Output unit:", selection: $selectedOutputUnitString) {
                        ForEach(outputUnits, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result of conversion:")) {
                    Text("\(outputValue, specifier: "%.2f") \(selectedOutputUnitString.rawValue)")
                        .font(.title)
                        .bold()
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UnitConverter()
    }
}
