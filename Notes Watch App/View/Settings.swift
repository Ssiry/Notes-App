//
//  Settings.swift
//  Notes Watch App
//
//  Created by Hassan Assiry on 25/04/2023.
//

import SwiftUI

struct Settings: View {
    // MARK: - PROPERTY
    @AppStorage("lineCount") var lineCount : Int = 1
    @State private var value: Float = 1.0
    
    func update(){
        lineCount = Int(value)
    }
    // MARK: - BODY
    var body: some View {
        VStack(spacing:8){
            // header
            HeaderView(title: "Settings")
            // acutual line count
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.bold)
            // slider
            Slider(value: Binding(get: {
                self.value
            }, set: { (newValue) in
                self.value = newValue
                self.update()
            }),in: 1...4,step: 1)
                .accentColor(.accentColor)
        }//: V - stack
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
