//
//  LocationsViewModel.swift
//  Rickipedia
//
//  Created by Doris Wen on 5.05.2024.
//

import Foundation

@MainActor
final class LocationsViewModel: ObservableObject {
    private let client = Client()
    
    @Published private(set) var locations: [Location] = []
    @Published private(set) var residents: [Character] = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published private var isFetching = false
    @Published var filterType: String = "All"
    @Published var isFilterSwitchOn = false
    @Published var isOpenFilterSheet = false
    @Published var isOpenSortingSheet = false
    @Published private(set) var filteredLocations: [Location] = []
    @Published var locationPopulationDictList = []
    @Published var allLocations: [Location] = []
    var nextPage: String?
    var currentPage = 1
    var totalPage = 0
    
    // MARK: Fetch
    func fetchLocations() async {
        let request = URLRequest(url: URL(string: "\(BASE_URL)/location")!)
        do {
            let response = try await client.fetch(type: Locations.self, with: request)
            locations.append(contentsOf: response.results)
            nextPage = response.info.next
            totalPage = response.info.pages
        } catch {
            handleFetchError(error: error)
        }
    }
    
    func fetchResidents(urlStrings: [String]) async {
        for urlString in urlStrings {
            print(urlString)
            guard let url = URL(string: urlString) else { return }
            let request = URLRequest(url: url)
            do {
                let response = try await client.fetch(type: Character.self, with: request)
                residents.append(response)
            } catch {
                handleFetchError(error: error)
            }
        }
    }
    
    func fetchAllLocations() async throws {
        while currentPage < totalPage {
            let urlString = "\(BASE_URL)/location/?page=\(currentPage)"
            let request = URLRequest(url: URL(string: urlString)!)

            do {
                let response = try await client.fetch(type: Locations.self, with: request)
                allLocations.append(contentsOf: response.results)
            } catch {
                handleFetchError(error: error)
                break 
            }
            currentPage += 1
        }
        print(allLocations)
    }
    
    // MARK: Pagination
    func pagination(currentItem: Location) async throws  {
        if let lastLocation = locations.last, lastLocation.id == currentItem.id {
            try await fetchNextPage()
        }
    }
    
    func fetchNextPage() async throws {
        if let nextPage {
            let request = URLRequest(url: URL(string: nextPage)!)
            let response = try await client.fetch(type: Locations.self, with: request)
            locations.append(contentsOf: response.results)
            self.nextPage = response.info.next
        }
    }
    
    // MARK: Error
    private func handleFetchError(error: Error) {
        let message: String
        if let apiError = error as? APIError {
            message = apiError.customDescription
        } else {
            message = error.localizedDescription
        }
        errorMessage = message
        hasError = true
        print("Fetch error:", message)
    }

    // MARK: Search
    func searchLocation(location: String) async throws {
        locations = []
        let path = "\(BASE_URL)/location/?name=\(location)"
        let request = URLRequest(url: URL(string: path)!)
        do {
            let response = try await client.fetch(type: Locations.self, with: request)
            locations.append(contentsOf: response.results)
            //nextPage += 1
        } catch {
            handleFetchError(error: error)
        }
    }
    
    // MARK: Reset
    func resetSearch() async throws {
        locations = []
        await fetchLocations()
    }
    
    func resetFitlter() {
        filterType = "All"
        filterSwitchOnOff(bool: false)
    }
    
    // MARK: Filter
    let typeOptions = ["All", "Planet", "Microverse", "Dream", "Dimension", "Quadrant", "Asteroid", "Country", "Unknown" ]
    
    func filterLocation() async {
        locations = []
        let request = URLRequest(url: URL(string: "\(BASE_URL)/location/?type=\(filterType)")!)
        do {
            let response = try await client.fetch(type: Locations.self, with: request)
            locations.append(contentsOf: response.results)
            nextPage = response.info.next
        } catch {
            handleFetchError(error: error)
        }
    }
    
    // MARK: Toggle Sheets
    func filterSwitchOnOff(bool: Bool) {
        if bool {
            isFilterSwitchOn = true
        } else {
            isFilterSwitchOn = false
        }
    }
    
    func toggleSortingSheet(with bool: Bool) {
        if bool {
            isOpenSortingSheet = true
        } else {
            isOpenSortingSheet = false
        }
    }
    
    // MARK: Sort
    func sortLocations(by option: SortOption) -> [Location] {
        locations = []
        switch option {
        case .nameAscending:
            return allLocations.sorted { $0.name < $1.name }
        case .nameDescending:
            return allLocations.sorted { $0.name > $1.name }
        }
    }
    
    func sort(by option: SortOption) {
       locations = sortLocations(by: option)
    }
}
