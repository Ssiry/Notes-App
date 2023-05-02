//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Hassan Assiry on 23/04/2023.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    @AppStorage("lineCount") var lineCount : Int = 1
    @State private var notes: [Note] = [Note]()
    @State private var text = ""
    // MARK: - FUNCTIONS
    func getDocumentDirctory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    func save(){
        // dump(notes)
        do{
            // Convert the note array to data using JSONEncoder
            let data = try JSONEncoder().encode(notes)
            // Create new URL to save the file using getDocumentDirctory
            let url = getDocumentDirctory().appendingPathComponent("notes")
            // Write the data to giving URL
            try data.write(to: url)
        }catch{
            print("Saving data has fialed!!")
        }
        
    }
    func load(){
        DispatchQueue.main.async {
            do {
                // Get the note url path
                let url = getDocumentDirctory().appendingPathComponent("notes")
                // Create a new property for the data
                let data = try Data(contentsOf: url)
                // Decode the data
                notes = try JSONDecoder().decode([Note].self, from: data)
            }catch{
                // nothing
            }
        }
    }
    func delete(Offset: IndexSet){
        withAnimation {
            notes.remove(atOffsets: Offset)
            save()
        }
    }
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center,spacing: 6) {
                    TextField("Add new Note", text: $text)
                    Button {
                        //only run the button when the textfield is not empity
                        guard text.isEmpty == false else { return }
                        // create a new note item and initialize it with text value
                        let note = Note(id: UUID(), text: text)
                        // add item to array
                        notes.append(note)
                        // make the text field empity
                        text = ""
                        // save the note (function)
                        save()
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42,weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                }//: H-STACK
                Spacer()
                if notes.count >= 1 {
                    List {
                      ForEach(0..<notes.count, id: \.self) { i in
                        NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                          HStack {
                            Capsule()
                              .frame(width: 4)
                              .foregroundColor(.accentColor)
                            Text(notes[i].text)
                              .lineLimit(lineCount)
                              .padding(.leading, 5)
                          }
                        } //: HSTACK
                      } //: LOOP
                      .onDelete(perform: delete)
                    }
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .padding(25)
                        .opacity(0.5)
                    Spacer()
                }
            }
            //: V-STACK
            .onAppear(
                perform:{
                    load()
                }
            )
        .navigationTitle("Notes")
            
        }
    }
        
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
