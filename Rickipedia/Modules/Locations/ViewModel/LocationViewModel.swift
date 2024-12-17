//
//  LocationViewModel.swift
//  Rickipedia
//
//  Created by App_team on 2024/12/17.
//

import Foundation

class LocationViewModel: ObservableObject {
    
    @Published var locations: [Location] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    func fetchCharacters() {
        print("Fetching Locatons...")
        errorMessage = nil
        isLoading = true
        
        NetworkManager.shared.fetchData(endPoint: "location", type: Locations.self) { [weak self] result in
            guard let self = self else { return }
            isLoading = false
            
            switch result {
            case .success(let locationData):
                self.locations = locationData.results
                print("Fetched Locations: \(locationData.results.count)")
            case .failure(let error):
                self.errorMessage = "Failed to load locations: \(error.localizedDescription)"
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
