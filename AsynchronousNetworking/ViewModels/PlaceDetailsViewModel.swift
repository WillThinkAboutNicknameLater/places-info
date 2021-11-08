//
//  PlaceDetailsViewModel.swift
//  AsynchronousNetworking
//
//  Created by Mackem Meya on 08.11.2021.
//

import Foundation
import Combine

final class PlaceDetailsViewModel: ObservableObject {
    private var cancellables: [AnyCancellable] = []
    
    private let placeService = PlaceService()
    
    private var placeId: String
    @Published var details: PlaceDetails?
    
    init(placeId: String) {
        self.placeId = placeId
    }
    
    func updatePlaceDetails() {
        placeService.getPlaceDetails(placeId: placeId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { details in
                self.details = details
            })
            .store(in: &cancellables)
    }
}
