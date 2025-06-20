//
//  EpisodesView.swift
//  Rickipedia
//
//  Created by Doris Wen on 5.05.2024.
//

import SwiftUI

struct EpisodesView: View {
    @StateObject var viewModel = EpisodesViewModel()
    @State private var searchText = ""
    @State private var showSearchButton = false
    @State private var isFilterSheetOpen = false
    @State private var isSortingSheetOpen = false
    @State private var selectedNumber: Int = 1
    @State private var selectedSortOption: SortOption = .nameAscending
    
    var body: some View {
        ZStack {
            Color(hex: "272B33")
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Rickipedia").font(.title).fontWeight(.bold)
                        Text("Episodes").font(.title2).fontWeight(.bold)
                    }
                    Spacer()
                    // MARK: Filter
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.gray.opacity(0.5))
                        .overlay {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                .font(.title)
                        }
                        .onTapGesture {
                            isFilterSheetOpen = true
                        }
                    // MARK: Sort
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.gray.opacity(0.5))
                        .overlay {
                            Image(systemName: "list.number")
                                .font(.title)
                        }.onTapGesture {
                           isSortingSheetOpen = true
                            Task {
                               try await viewModel.fetchAllEpisodes()
                            }
                        }
                }
                .padding(.top ,60)
                .padding(.horizontal ,20)
                
                // MARK: Search
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 60)
                    .foregroundStyle(.gray.opacity(0.4))
                    .overlay {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Search", text: $searchText)
                                .foregroundColor(.white)
                                .onChange(of: searchText) { oldValue, newValue in
                                    withAnimation {
                                        if newValue != "" {
                                            showSearchButton = true
                                        } else {
                                            showSearchButton = false
                                        }
                                    }
                                }
                            Spacer()
                            showSearchButton ? searchButton
                            : nil
                            Image(systemName: "xmark").foregroundStyle(.white)
                                .onTapGesture {
                                    searchText = ""
                                    Task {
                                        try await viewModel.resetSearch()
                                    }
                                }
                        }.padding()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                    .tint(.white)
                // MARK: Episodes
                ScrollView {
                    ForEach(viewModel.episodes, id: \.id) { episode in
                        EpisodeCell(episode: episode)
                            .onAppear {
                                Task {
                                    try await viewModel.pagination(currentItem: episode)
                                }
                            }
                    }
                }
            }
            .task {
                if searchText == "" {
                    await viewModel.fetchEpisodes()
                }
            }
        }
        .ignoresSafeArea()
        .sheet(isPresented: $isFilterSheetOpen) {
            filterSheet
        }
        .sheet(isPresented: $isSortingSheetOpen) {
            sortingSheet
        }
    }
    
    // MARK: Filter Sheet
    var filterSheet: some View {
        VStack {
            Text("Filter")
                .font(.largeTitle)
                .bold()
            Text("Selected Episode: \(selectedNumber)")
                .font(.headline)
                .padding()
            Picker("Select a number", selection: $selectedNumber) {
                ForEach(1...51, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }.pickerStyle(.wheel)
            Button("Filter", action: {
                Task {
                    do {
                        try await viewModel.filterEpsiodes(episode: selectedNumber)
                    } catch {
                        print(error)
                    }
                }
                isFilterSheetOpen = false
            }
            ).buttonStyle(.borderedProminent)
                .tint(.green)
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)
        }
        .padding()
    }
    
    // MARK: Sorting Sheet View
    var sortingSheet: some View {
        VStack {
            Text("Sort Characters").font(.title).bold()
                .padding(.top, 30)
            ForEach(SortOption.allCases, id: \.self) { option in
                Button(action: {
                    selectedSortOption = option
                    
                }) {
                    HStack {
                        Text(option.rawValue)
                        Spacer()
                        if option == selectedSortOption {
                            Image(systemName: "checkmark")
                        }
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
            
            Button(action: {
                isSortingSheetOpen = false
                viewModel.sort(by: selectedSortOption)
            }) {
                Text("Sort")
                    .font(.headline)
                    .padding()
                    .background(.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.vertical)
            .buttonStyle(.borderedProminent)
            .tint(.green)
            Spacer()
        }
    }
    
    // MARK: Search Button
    @ViewBuilder
    var searchButton: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 100, height: 40)
            .foregroundStyle(.green)
            .overlay {
                Text("Search")
                    .foregroundStyle(.white)
            }.onTapGesture {
                Task {
                    try await viewModel.searchEpisode(episode: searchText)
                }
            }
    }
}

#Preview {
    EpisodesView()
}

struct EpisodeCell: View {
    var episode: Episode
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: UIScreen.main.bounds.width - 30, height: 60)
            .foregroundStyle(Color(hex: "3B3E43"))
            .overlay {
                HStack {
                    VStack(alignment: .leading) {
                        Text(episode.name).bold()
                        Text(episode.episode)
                        
                    }
                    Spacer()
                }.padding()
            }
    }
}
