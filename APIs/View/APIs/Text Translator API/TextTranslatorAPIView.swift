//
//  TextTranslatorAPIView.swift
//  APIs
//
//  Created by KaayZenn on 14/05/2023.
//

import SwiftUI

struct TextTranslatorAPIView: View {

    //Custom type
    @State private var textTranslator: TextTranslator? = nil

    //Environnements

    //State or Binding String
    @State private var sourceLanguage: String = "en"
    @State private var targetLanguage: String = "fr"
    @State private var textForTranslate: String = ""

    //State or Binding Int, Float and Double

    //State or Binding Bool
    @State private var update: Bool = false
    @State private var isLoading: Bool = false

    //Enum

    //Computed var

    //MARK: - Body
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Source Language")
                Picker(selection: $sourceLanguage) {
                    Text("English").tag("en")
                    Text("French").tag("fr")
                    Text("Spanish").tag("sp")
                } label: {
                    Text("Source Language")
                }
                .pickerStyle(.segmented)
            }
            .padding()
            
            VStack(alignment: .leading) {
                Text("Target Language")
                Picker(selection: $targetLanguage) {
                    Text("English").tag("en")
                    Text("French").tag("fr")
                    Text("Spanish").tag("sp")
                } label: {
                    Text("Source Language")
                }
                .pickerStyle(.segmented)
            }
            .padding()

            VStack(alignment: .leading) {
                Text("Text to be translated")
                TextField("Enter your text", text: $textForTranslate)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            if let textTranslator = textTranslator {
                VStack(alignment: .leading) {
                    Text("Result :")
                    Text(textTranslator.data.translatedText)
                }
            }
            
            Spacer()
            
            Button(action: {
                textTransaltorAPI()
            }, label: {
                HStack {
                    Spacer()
                    Text("Translate")
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
        .navigationTitle("Text Translator")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: {
                    SettingView(apiName: "Text Translator", apiURL: "https://rapidapi.com/dickyagustin/api/text-translator2")
                }, label: {
                    Image(systemName: "gear")
                        .foregroundColor(.colorLabel)
                })
            }
        }
    }//END body

    //MARK: Fonctions

    func textTransaltorAPI() {
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "X-RapidAPI-Key": "27fcb5eff0msh896cc01a86db4b1p11f0edjsn8ce9812c9933",
            "X-RapidAPI-Host": "text-translator2.p.rapidapi.com"
        ]

        let postData = NSMutableData(data: "source_language=\(sourceLanguage)".data(using: String.Encoding.utf8)!)
        postData.append("&target_language=\(targetLanguage)".data(using: String.Encoding.utf8)!)
        postData.append("&text=\(textForTranslate)".data(using: String.Encoding.utf8)!)

        let request = NSMutableURLRequest(url: NSURL(string: "https://text-translator2.p.rapidapi.com/translate")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
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
                let textTranslator = try decoder.decode(TextTranslator.self, from: jsonData)
                self.textTranslator = textTranslator
                update.toggle()
            } catch {
                print("Erreur de décodage : \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
}//END struct

//MARK: - Preview
struct TextTranslatorAPIView_Previews: PreviewProvider {
    static var previews: some View {
        TextTranslatorAPIView()
    }
}
