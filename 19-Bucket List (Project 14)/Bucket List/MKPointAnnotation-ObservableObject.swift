//
//  MKPointAnnotation-ObservableObject.swift
//  Bucket List
//
//  Created by Felix Leitenberger on 05.03.21.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }

        set {
            title = newValue
        }
    }

    var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }

        set {
            subtitle = newValue
        }
    }
}
