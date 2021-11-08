//
//  PlaceView.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 02.11.2021.
//

import SwiftUI

struct PlaceView: View {
    var place: Place
    
    var body: some View {
        Text(place.name)
            .contentShape(Rectangle())
    }
}

struct PlaceListItemView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView(place: Place(id: "1", name: "НГУ", point: Place.Point(latitude: 0, longitude: 0)))
    }
}
