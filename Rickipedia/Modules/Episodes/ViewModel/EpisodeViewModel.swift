//
//  EpisodeViewModel.swift
//  Rickipedia
//
//  Created by App_team on 2024/12/17.
//

import Foundation

class EpisodeViewModel: ObservableObject {
    
    @Published var episodes: [Episode] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    func fetchCharacters() {
        print("Fetching Episodes...")
        errorMessage = nil
        isLoading = true
        
        NetworkManager.shared.fetchData(endPoint: "episode", type: Episodes.self) { [weak self] result in
            guard let self = self else { return }
            isLoading = false
            
            switch result {
            case .success(let episodeData):
                self.episodes = episodeData.results
                print("Fetched Characters: \(episodeData.results.count)")
            case .failure(let error):
                self.errorMessage = "Failed to load episodes: \(error.localizedDescription)"
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
