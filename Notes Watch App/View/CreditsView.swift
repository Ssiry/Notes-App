//
//  CreditsView.swift
//  Notes Watch App
//
//  Created by Hassan Assiry on 24/04/2023.
//

import SwiftUI

struct CreditsView: View {
    // MARK: - PROPERTY
    @State private var randomNum : Int = Int.random(in: 1..<4)
    private var randomImage: String{
        return "developer-no\(randomNum)"
    }
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 3) {
            // profile image
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            
            // header
            HeaderView(title: "cridets")
            // content
            Text("Hassan Asery")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .foregroundColor(.secondary)
                .font(.footnote)
                .fontWeight(.light)
        }//: V - Stack
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
