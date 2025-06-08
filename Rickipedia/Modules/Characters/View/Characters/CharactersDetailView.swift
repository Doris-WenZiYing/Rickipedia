import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background
            Color(hex: "272B33")
                .ignoresSafeArea()

            VStack {
                HStack {
                    Image(systemName: "arrow.backward")
                        .font(.system(size: 24, weight: .bold))
                    Text("Back")
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .cornerRadius(8)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()

                }
                .padding(.top, 16)
                .padding(.leading, 16)

                // Main Content
                ScrollView {
                    VStack(spacing: 24) {
                        Color.clear.frame(height: 30)

                        VStack(spacing: 16) {
                            Text(character.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            AsyncImage(url: URL(string: character.image)) { img in
                                img
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .cornerRadius(15)
                            .padding(.horizontal, 20)

                            VStack(alignment: .leading, spacing: 10) {
                                Text("Status: \(character.status)")
                                Text("Species: \(character.species)")
                                Text("Gender: \(character.gender)")
                                Text("Origin: \(character.origin.name)")
                                Text("Location: \(character.location.name)")
                            }
                            .font(.title3)
                        }
                        .padding(.horizontal, 20)

                        Spacer()
                    }
                }
            }
        }
        .foregroundColor(.white)
        .navigationBarHidden(true)
    }
}

#Preview {
    CharacterDetailView(character: Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: CharacterLocation(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
        location: CharacterLocation(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        episode: [
            "https://rickandmortyapi.com/api/episode/1",
            "https://rickandmortyapi.com/api/episode/2",
            "https://rickandmortyapi.com/api/episode/3"
            // Add more episodes if needed
        ],
        url: "https://rickandmortyapi.com/api/character/1",
        created: "2017-11-04T18:48:46.250Z"
    ))
}
