//
//  Person.swift
//  MapTest
//
//  Created by Михаил Задорожный on 16.03.2021.
//

import Foundation
import CoreLocation

struct Person {
    
    var name: String
    var time: String
    var coordinate: CLLocationCoordinate2D
    var imgName: String
    var navigationSystem: String = "GPS"
    var date: String
    
    static func createPeople() -> [Person] {
        let person1 = Person(name: "Алекс", time: "12: 00", coordinate: CLLocationCoordinate2D(latitude: 55.4507, longitude: 37.3656), imgName: "face_c_1", date: "13.11.19")
        let person2 = Person(name: "Михаил", time: "13: 40", coordinate: CLLocationCoordinate2D(latitude: 54.4, longitude: 38.5), imgName: "face_c_2", date: "14.06.18")
        let person3 = Person(name: "Олег", time: "11: 20", coordinate: CLLocationCoordinate2D(latitude: 55.7, longitude: 38.3), imgName: "face_c_3", date: "20.12.20")
        let person4 = Person(name: "Дима", time: "10: 55", coordinate: CLLocationCoordinate2D(latitude: 57.4, longitude: 38.5), imgName: "face_c_4", date: "04.05.17")
        return [person1,person2,person3,person4]
    }
}
