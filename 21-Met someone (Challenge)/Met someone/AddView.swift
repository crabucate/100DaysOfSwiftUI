//
//  EditView.swift
//  Met someone
//
//  Created by Felix Leitenberger on 27.03.21.
//

import SwiftUI

struct AddView: View {

    @ObservedObject var personStore: PersonStore

    @State private var pickedImage: UIImage?
    @State private var name: String = ""
    @State private var showPicker = false
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            VStack {
                if pickedImage != nil {
                    Image(uiImage: (pickedImage ?? UIImage(systemName: "person"))!)
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipShape(Circle())
                        .onTapGesture {
                            showPicker = true
                        }
                } else {
                    Circle()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(.black).opacity(0.3)
                        .overlay(Image(systemName: "plus").foregroundColor(.gray))
                        .onTapGesture {
                            showPicker = true
                        }
                }
                Form {
                    TextField("Name", text: $name)
                }
            }
            .navigationTitle("Add Someone")
            .sheet(isPresented: $showPicker, content: {
                ImagePicker(image: $pickedImage)
            })
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.confirmationAction) {
                    Button {
                        var imageID: UUID? = nil

                        if let image = pickedImage {
                            imageID = UUID()
                            personStore.saveImage(image: image, imageID: imageID!)
                        } else {
                            print("No image picked")
                        }
                        let newPerson = Person(id: UUID(), name: name, imageUUID: imageID)

                        personStore.persons.append(newPerson)
                        personStore.persons.sort()
                        isPresented = false
                    } label: {
                        Text("Done")
                            .font(.title)
                    }.disabled(name == "" ? true : false)
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isPresented = false
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(personStore: PersonStore(), isPresented: .constant(true))
    }
}
