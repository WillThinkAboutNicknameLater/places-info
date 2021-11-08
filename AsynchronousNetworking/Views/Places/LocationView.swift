//
//  LocationView.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 02.11.2021.
//

import SwiftUI

struct LocationView: View {
    var location: Location
    
    var body: some View {
        VStack (spacing: 5) {
            HStack {
                let placeInformation = [ location.name, location.street, location.houseNumber, location.postCode ].compactMap({ $0 }).joined(separator: ", ")
                Text(placeInformation)
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                let locationInformation = [ location.country, location.state, location.city ].compactMap({ $0 }).joined(separator: ", ")
                Text(locationInformation)
                    .font(.caption)
                Spacer()
            }
        }
        .contentShape(Rectangle())
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(location: Location(point: Location.Point(latitude: 0, longitude: 0), name: "НГУ", country: "Россия", state: "Новосибирская область", city: "Новосибирск", street: "Пирогова", houseNumber: "1", postCode: nil))
    }
}
