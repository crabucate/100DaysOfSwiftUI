//
//  Person.swift
//  Met someone
//
//  Created by Felix Leitenberger on 27.03.21.
//

import Foundation
import MapKit

struct Person: Identifiable, Codable, Comparable {
    var id: UUID
    var name: String
    var imageUUID: UUID?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?

    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}

