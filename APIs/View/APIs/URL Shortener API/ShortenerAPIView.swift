//
//  ShortenerAPIView.swift
//  APIs
//
//  Created by KaayZenn on 12/05/2023.
//

import SwiftUI

struct ShortenerAPIView: View {

    //Custom type
    @State private var shortener: Shortener? = nil
    
    //Environnements

    //State or Binding String
    @State private var actualUrl: String = ""
    @State private var newUrl: String = ""

    //State or Binding Int, Float and Double

    //State or Binding Bool
    @State private var update: Bool = false

    //Enum

    //Computed var

    //MARK: - Body
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Your URL")
                TextField("Actual url", text: $actualUrl)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            if newUrl != "" {
                VStack(alignment: .leading) {
                    Text("New URL")
                    TextEditor(text: $newUrl)
                }
                .padding()
            }

            Spacer()
            
            Button(action: {
                shortenerAPI()
            }, label: {
                HStack {
                    Spacer()
                    Text("Cut the link")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(8)
                .background(Color.blue)
                .cornerRadius(12)
            })
            .padding()
        }
        .padding(update ? 0 : 0)
        .onChange(of: update) { newValue in
            if let shortener = shortener {
                newUrl = shortener.resultUrl
            }
        }
        .navigationTitle("URL Shortener")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: {
                    SettingView(apiName: "URL Shortener", apiURL: "https://rapidapi.com/BigLobster/api/url-shortener-service/")
                }, label: {
                    Image(systemName: "gear")
                        .foregroundColor(.colorLabel)
                })
            }
        }
    }//END body

    //MARK: Fonctions
    
    func shortenerAPI() {
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "X-RapidAPI-Key": "27fcb5eff0msh896cc01a86db4b1p11f0edjsn8ce9812c9933",
            "X-RapidAPI-Host": "url-shortener-service.p.rapidapi.com"
        ]

        let url: String = "url=" + actualUrl
        let postData = NSMutableData(data: url.data(using: String.Encoding.utf8)!)

        let request = NSMutableURLRequest(url: NSURL(string: "https://url-shortener-service.p.rapidapi.com/shorten")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            guard let data = data else { return }

            let jsonString = String(data: data, encoding: .utf8)!
            let jsonData = jsonString.data(using: .utf8)!

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let shortener = try decoder.decode(Shortener.self, from: jsonData)
                self.shortener = shortener
                update.toggle()
            } catch {
                print("Erreur de décodage : \(error.localizedDescription)")
            }
        }
        task.resume()
    }

}//END struct

//MARK: - Preview
struct ShortenerAPIView_Previews: PreviewProvider {
    static var previews: some View {
        ShortenerAPIView()
    }
}
