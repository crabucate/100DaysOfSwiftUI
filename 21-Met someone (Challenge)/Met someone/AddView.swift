//
//  EditView.swift
//  Met someone
//
//  Created by Felix Leitenberger on 27.03.21.
//

import SwiftUI
import MapKit

struct AddView: View {

    @ObservedObject var personStore: PersonStore

    @State private var pickedImage: UIImage?
    @State private var name: String = ""
    @State private var showPicker = false
    @Binding var isPresented: Bool

    let locationFetcher = LocationFetcher()

    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

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

                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.largeTitle)
                        .padding()
                ZStack {
                    Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .none)
                    Circle()
                        .fill(Color.blue)
                        .opacity(0.3)
                        .frame(width: 32, height: 32)
                }
                .onAppear(perform: {
                    locationFetcher.start()
                    if let lastRegion = locationFetcher.lastKnownLocation {
                        region = MKCoordinateRegion(center: lastRegion, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                    } else {
                        print("No region")
                    }

                })

                Text("\(region.center.latitude), \(region.center.longitude)")
                    .onTapGesture {

                        locationFetcher.start()
                        if let lastRegion = locationFetcher.lastKnownLocation {
                            region = MKCoordinateRegion(center: lastRegion, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                        } else {
                            print("No region")
                        }
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

                        let latitude = region.center.latitude
                        let longitude = region.center.longitude
                       
                        let newPerson = Person(id: UUID(), name: name, imageUUID: imageID, latitude: latitude, longitude: longitude)

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

struct PlusButton: View {
    var body: some View {
        Image(systemName: "plus")
            .padding()
            .background(Color.black.opacity(0.75))
            .foregroundColor(.white)
            .font(.title)
            .edgesIgnoringSafeArea(.all)
            .clipShape(Circle())
            .padding()
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(personStore: PersonStore(), isPresented: .constant(true))
    }
}
