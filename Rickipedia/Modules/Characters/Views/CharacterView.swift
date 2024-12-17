//
//  CharacterView.swift
//  Rickipedia
//
//  Created by App_team on 2024/12/14.
//

import SwiftUI

struct CharacterView: View {
    
    @StateObject private var vm = CharacterViewModel()
    
    var body: some View {
        ZStack {
            NavigationStack {
                ZStack {
                    Color(hex: "#051622")
                    if vm.isLoading {
                        ProgressView("Loading...")
                    } else if let error = vm.errorMessage {
                        Text(error)
                            .foregroundStyle(.red)
                    } else {
                        ScrollView {
                            LazyVGrid(columns: [
                                GridItem(.adaptive(minimum: 400))
                            ], spacing: 20) {
                                ForEach(vm.characters, id: \.id) { character in
                                    NavigationLink {
                                        CharacterDetailView()
                                    } label: {
                                        
                                    }
                                }
                            }
                            
                            
//                            List(vm.characters, id: \.id) { character in
//                                HStack {
//                                    AsyncImage(url: URL(string: character.image)) { image in
//                                        image
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fill)
//                                    } placeholder: {
//                                        Color.gray
//                                    }
//                                }
//                                .frame(width: 50, height: 50)
//                                .clipShape(RoundedRectangle(cornerRadius: 10))
//                                
//                                VStack {
//                                    Text(character.name)
//                                        .font(.headline)
//                                        .bold()
//                                    
//                                    Text(character.status)
//                                        .font(.subheadline)
//                                        .foregroundStyle(character.status == "Alive" ? .green : .red)
//                                }
//                            }
                        }
                    }
                }
                .navigationTitle("Characters")
                
            }
            .onAppear {
                vm.fetchCharacters()
            }
        }
    }
}

#Preview {
    CharacterView()
        .preferredColorScheme(.dark)
}
