//
//  CharacterViewModel.swift
//  Rickipedia
//
//  Created by App_team on 2024/12/17.
//

import Foundation

class CharacterViewModel: ObservableObject {
    
    @Published var characters: [Character] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    func fetchCharacters() {
        print("Fetching Characters...")
        errorMessage = nil
        isLoading = true
        
        NetworkManager.shared.fetchData(endPoint: "character", type: Characters.self) { [weak self] result in
            guard let self = self else { return }
            isLoading = false
            
            switch result {
            case .success(let characterData):
                self.characters = characterData.results
                print("Fetched Characters: \(characterData.results.count)")
            case .failure(let error):
                self.errorMessage = "Failed to load characters: \(error.localizedDescription)"
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
