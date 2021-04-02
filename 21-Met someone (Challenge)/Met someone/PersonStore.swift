//
//  PersonStore.swift
//  Met someone
//
//  Created by Felix Leitenberger on 27.03.21.
//

import UIKit

class PersonStore: ObservableObject {

    init() {
        do {
            let fileURL = try FileManager.default.url(
                for: .applicationSupportDirectory,
                in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("Persons.json")
            let data = try Data(contentsOf: fileURL)
            persons = try JSONDecoder().decode([Person].self, from: data)
            return
        } catch {
            print(error)
        }
        persons = []
    }

    @Published var persons: [Person] {
        didSet {
            savePersons()
        }
    }


    func savePersons() {
        if let fileURL = getApplicationSupportDirectory()?.appendingPathComponent("Persons.json") {
            do {
                try JSONEncoder().encode(persons).write(to: fileURL)
            } catch {
                print(error)
            }
        }
    }

    func saveImage(image: UIImage, imageID: UUID) {
        if let url = getApplicationSupportDirectory()?.appendingPathComponent(imageID.uuidString + ".jpg") {
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: url, options: [.atomicWrite, .completeFileProtection])
            }
        }
    }

    func loadImage(with imageID: UUID?) -> UIImage {
        let largeSize = UIImage.SymbolConfiguration(pointSize: 100)
        let placeholderImage = UIImage(systemName: "person", withConfiguration: largeSize)!
        if let imageID = imageID {
            if let url = getApplicationSupportDirectory()?.appendingPathComponent(imageID.uuidString + ".jpg") {
                if let data = FileManager.default.contents(atPath: url.path) {
                    return UIImage(data: data) ?? placeholderImage
                }
            }
        }
        return placeholderImage
    }

    func getApplicationSupportDirectory() -> URL? {
        let fileURL: URL

        do {
            fileURL = try FileManager.default.url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true)
        }
        catch {
            return nil
        }
        return fileURL
    }
}
