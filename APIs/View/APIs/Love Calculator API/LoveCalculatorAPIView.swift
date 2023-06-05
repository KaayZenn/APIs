//
//  LoveCalculatorAPIView.swift
//  APIs
//
//  Created by KaayZenn on 15/05/2023.
//

import SwiftUI

struct LoveCalculatorAPIView: View {

    //Custom type
    @State private var loveCalculator: LoveCalculator? = nil

    //Environnements

    //State or Binding String
    @State private var firstName: String = ""
    @State private var secondName: String = ""

    //State or Binding Int, Float and Double
    @State private var scale: CGFloat = 0.0
    
    //State or Binding Bool
    @State private var update: Bool = false

    //Enum

    //Computed var

    //MARK: - Body
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("First name")
                    TextField("", text: $firstName)
                        .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading) {
                    Text("Second name")
                    TextField("", text: $secondName)
                        .textFieldStyle(.roundedBorder)
                }
            }
            .padding()
            
            Spacer()

            if let love = loveCalculator {
                ZStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 150))
                        
                    Text(love.percentage)
                        .font(.system(size: 62, weight: .semibold, design: .rounded))
                }
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(.spring().repeatForever()) {
                        scale = 1
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                loveCalculatorAPI()
            }, label: {
                HStack {
                    Spacer()
                    Text("Calculate")
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
        .navigationTitle("Love Calculator")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: {
                    SettingView(apiName: "Love Calculator", apiURL: "https://rapidapi.com/ajith/api/love-calculator/")
                }, label: {
                    Image(systemName: "gear")
                        .foregroundColor(.colorLabel)
                })
            }
        }
    }//END body

    //MARK: Fonctions
    func loveCalculatorAPI() {
        let headers = [
            "X-RapidAPI-Key": "27fcb5eff0msh896cc01a86db4b1p11f0edjsn8ce9812c9933",
            "X-RapidAPI-Host": "love-calculator.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://love-calculator.p.rapidapi.com/getPercentage?sname=\(firstName.folding(options: .diacriticInsensitive, locale: .current))&fname=\(secondName.folding(options: .diacriticInsensitive, locale: .current))")! as URL,
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
                let loveCalculator = try decoder.decode(LoveCalculator.self, from: jsonData)
                self.loveCalculator = loveCalculator
                update.toggle()
            } catch {
                print("Erreur de décodage : \(error.localizedDescription)")
            }
        }
        task.resume()
    }

}//END struct

//MARK: - Preview
struct LoveCalculatorAPIView_Previews: PreviewProvider {
    static var previews: some View {
        LoveCalculatorAPIView()
    }
}
