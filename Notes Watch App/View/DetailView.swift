//
//  DetailView.swift
//  Notes Watch App
//
//  Created by Hassan Assiry on 24/04/2023.
//

import SwiftUI

struct DetailView: View {
    // MARK: - PROPERTY
    let note: Note
    let count: Int
    let index: Int
    @State private var isCreditShow: Bool = false
    @State private var isSettingsShow: Bool = false
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .center,spacing: 3) {
            // header
            HStack{
                Capsule()
                    .frame(height: 1)
                Image(systemName: "note.text")
                Capsule()
                    .frame(height: 1)
            }
            .foregroundColor(.accentColor)
            Spacer()
            // content
            ScrollView(.vertical){
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            // footer
            HStack(alignment: .center) {
                Image(systemName: "gear").imageScale(.large)
                    .onTapGesture {
                        isSettingsShow.toggle()
                    }
                    .sheet(isPresented: $isSettingsShow) {
                        Settings()
                    }
                Spacer()
                Text("\(count) / \(index+1)")
                Spacer()
                Image(systemName: "info.circle").imageScale(.large)
                    .onTapGesture {
                        isCreditShow.toggle()
                    }
                    .sheet(isPresented: $isCreditShow) {
                        CreditsView()
                    }
            }
            .foregroundColor(.secondary)
            
        }//: V-Stack
        .padding(3)
    }
}
// MARK: - prevew
struct DetailView_Previews: PreviewProvider {
    static var sampledata = Note(id: UUID(), text: "gggggggggg")
    
    static var previews: some View {
        DetailView(note: sampledata, count: 5, index: 1)
    }
}
