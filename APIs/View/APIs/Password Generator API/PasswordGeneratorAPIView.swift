//
//  PasswordGeneratorAPIView.swift
//  APIs
//
//  Created by KaayZenn on 15/05/2023.
//

import SwiftUI

struct PasswordGeneratorAPIView: View {

    //Custom type
    @State private var passwordGenerator: PasswordGenerator? = nil

    //Environnements

    //State or Binding String
    @State private var password: String = ""

    //State or Binding Int, Float and Double
    @State private var lengthPassword: Int = 16

    //State or Binding Bool
    @State private var update: Bool = false
    @State private var passwordIsHidden: Bool = true
    @State private var excludeNumbers: Bool = false
    @State private var excludeSpecialChars: Bool = false

    //Enum

    //Computed var

    //MARK: - Body
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Exclude Numbers")
                Picker("", selection: $excludeNumbers, content: {
                    Text("FALSE").tag(false)
                    Text("TRUE").tag(true)
                })
                .pickerStyle(.segmented)
            }
            .padding()
            
            VStack(alignment: .leading) {
                Text("Exclude Speciale Chars")
                Picker("", selection: $excludeSpecialChars, content: {
                    Text("FALSE").tag(false)
                    Text("TRUE").tag(true)
                })
                .pickerStyle(.segmented)
            }
            .padding()
            
            VStack(alignment: .leading) {
                Text("Length of password")
                TextField("Length of password", value: $lengthPassword, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            if passwordGenerator != nil {
                VStack(alignment: .leading) {
                    Text("Generated password :")
                    if passwordIsHidden {
                        SecureField("", text: $password)
                            .overlay(alignment: .trailing) {
                                Button(action: {
                                    passwordIsHidden.toggle()
                                }, label: {
                                    Image(systemName: "eye.slash")
                                        .foregroundColor(.colorLabel)
                                })
                            }
                    } else {
                        TextField("", text: $password)
                            .overlay(alignment: .trailing) {
                                Button(action: {
                                    passwordIsHidden.toggle()
                                }, label: {
                                    Image(systemName: "eye")
                                        .foregroundColor(.colorLabel)
                                })
                            }
                    }
                }
                .padding()
            }
            
            Spacer()
            
            Button(action: { passwordGeneratorAPI() }, label: {
                HStack {
                    Spacer()
                    Text("Generate Password")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(8)
                .background(Color.blue)
                .cornerRadius(12)
            })
            .padding()
        }
        .navigationTitle("Password Generator")
        .onChange(of: update, perform: { newValue in
            if let pass = passwordGenerator { password = pass.randomPassword }
        })
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: {
                    SettingView(apiName: "Password Generator", apiURL: "https://rapidapi.com/apininjas/api/password-generator-by-api-ninjas")
                }, label: {
                    Image(systemName: "gear")
                        .foregroundColor(.colorLabel)
                })
            }
        }
    }//END body

    //MARK: Fonctions
    func passwordGeneratorAPI() {
        let headers = [
            "X-RapidAPI-Key": "27fcb5eff0msh896cc01a86db4b1p11f0edjsn8ce9812c9933",
            "X-RapidAPI-Host": "password-generator-by-api-ninjas.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://password-generator-by-api-ninjas.p.rapidapi.com/v1/passwordgenerator?length=\(String(lengthPassword))&exclude_numbers=\(excludeNumbers)&exclude_special_chars=\(excludeSpecialChars)")! as URL,
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
                let passwordGenerator = try decoder.decode(PasswordGenerator.self, from: jsonData)
                self.passwordGenerator = passwordGenerator
                update.toggle()
            } catch {
                print("Erreur de décodage : \(error.localizedDescription)")
            }
        }
        task.resume()
    }

}//END struct

//MARK: - Preview
struct PasswordGeneratorAPIView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordGeneratorAPIView()
    }
}
