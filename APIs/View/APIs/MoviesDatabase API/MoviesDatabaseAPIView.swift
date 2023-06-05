//
//  MoviesDatabaseAPIView.swift
//  APIs
//
//  Created by KaayZenn on 12/05/2023.
//

import SwiftUI

struct MoviesDatabaseAPIView: View {

    //Custom type
    @State private var movies: ApiResponse? = nil

    //Environnements

    //State or Binding String
    @State private var yearSelected: String = "2023"

    //State or Binding Int, Float and Double

    //State or Binding Bool
    
    //State or Binding Date

    //Enum

    //Computed var
    
    //Other
    var layout: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]

    //MARK: - Body
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                HStack {
                    Button(action: {
                        moviesDatabaseAPI()
                    }, label: {
                        Text("Get movies")
                    })
                    
                    Spacer()
                    
                    Picker("", selection: $yearSelected) {
                        ForEach(2023...2033, id: \.self) {
                            Text(String($0)).tag(String($0))
                        }
                    }
                }
                .padding(.horizontal)
                
                if let movies = movies {
                    LazyVGrid(columns: layout) {
                        ForEach(movies.results, id: \.self) { result in
                            VStack {
                                if let image = result.primaryImage {
                                    AsyncImage(url: URL(string: image.url)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: (geo.size.width / 2) - 20, height: 300)
                                            .cornerRadius(30)
                                    } placeholder: {
                                        Color.gray.opacity(0.3)
                                    }
                                }
                                Text(result.titleText.text)
                                
                                Text(dateDisplay(releaseDate: result.releaseDate))
                            }
                            .padding(8)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(30)
                        }
                    }
                }
            }
            .navigationTitle("MoviesDatabase")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: {
                        SettingView(apiName: "MoviesDatabase", apiURL: "https://rapidapi.com/SAdrian/api/moviesdatabase/")
                    }, label: {
                        Image(systemName: "gear")
                            .foregroundColor(.colorLabel)
                    })
                }
            }
        }
    }//END body

    //MARK: Fonctions
    func moviesDatabaseAPI() {
        let headers = [
            "X-RapidAPI-Key": "27fcb5eff0msh896cc01a86db4b1p11f0edjsn8ce9812c9933",
            "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://moviesdatabase.p.rapidapi.com/titles/x/upcoming?year=\(yearSelected)&limit=20")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            guard let data = data else { return }

            let jsonString = String(data: data, encoding: .utf8)!
            let jsonData = jsonString.data(using: .utf8)!

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let apiResponse = try decoder.decode(ApiResponse.self, from: jsonData)
                self.movies = apiResponse
                print(apiResponse)
            } catch {
                print("Erreur lors de la décodage du JSON : \(error)")
            }
        }
        task.resume()
    }
    
    func dateDisplay(releaseDate: ReleaseDate) -> String {
        return "\(releaseDate.day)/\(releaseDate.month)/\(releaseDate.year)"
    }

}//END struct

//MARK: - Preview
struct MoviesDatabaseAPIView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesDatabaseAPIView()
    }
}
