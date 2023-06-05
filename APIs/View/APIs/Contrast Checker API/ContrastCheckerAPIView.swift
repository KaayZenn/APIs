//
//  ContrastCheckerAPIView.swift
//  APIs
//
//  Created by Théo Sementa on 05/06/2023.
//

import SwiftUI

struct ContrastCheckerAPIView: View {

    //Custom type
    @State private var contrastChecker: ContrastChecker? = nil

    //Environnements

    //State or Binding String
    @State private var textColor: String = ""
    @State private var backgroundColor: String = ""

    //State or Binding Int, Float and Double
    
    //State or Binding Bool
    @State private var update: Bool = false

    //Enum
    
    //Computed var

    //MARK: - Body
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Text color")
                    TextField("Hexa value", text: $textColor)
                        .textFieldStyle(.roundedBorder)
                }
                VStack(alignment: .leading) {
                    Text("Background Color")
                    TextField("Hexa value", text: $backgroundColor)
                        .textFieldStyle(.roundedBorder)
                }
            }
            .padding()
            
            Spacer()

            if let contrastChecker  {
                VStack {
     
                    Text("ratio: " + contrastChecker.ratio + ":1")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 200, height: 200)
                        .foregroundColor(Color(hex: backgroundColor))
                        .overlay {
                            VStack {
                                Text("Hello World!")
                                    .fontWeight(.regular)
                                    .foregroundColor(Color(hex: textColor))
                                    .padding()
                                
                                Text("Hello World!")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(hex: textColor))
                                    .padding()
                            }
                        }
                    
                    HStack {
                        Spacer()
                        VStack {
                            Text("Normal Text")
                            VStack {
                                Text("AA : \(contrastChecker.AA)")
                                Text("AAA : \(contrastChecker.AAA)")
                            }
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("Large Text")
                            VStack {
                                Text("AA : \(contrastChecker.AALarge)")
                                Text("AAA : \(contrastChecker.AAALarge)")
                            }
                        }
                        Spacer()
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                contrastCheckerAPI(textColorHEXA: textColor, backgroundColorHEXA: backgroundColor)
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
        .navigationTitle("Contrast Checker")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: {
                    SettingView(apiName: "Contrast Checker", apiURL: "https://webaim.org/resources/contrastchecker/")
                }, label: {
                    Image(systemName: "gear")
                        .foregroundColor(.colorLabel)
                })
            }
        }
    }//END body

    //MARK: Fonctions
    func contrastCheckerAPI(textColorHEXA: String, backgroundColorHEXA: String) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://webaim.org/resources/contrastchecker/?fcolor=\(textColorHEXA)&bcolor=\(backgroundColorHEXA)&api")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            guard let data = data else { return }

            let jsonString = String(data: data, encoding: .utf8)!
            let jsonData = jsonString.data(using: .utf8)!

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let contrastChecker = try decoder.decode(ContrastChecker.self, from: jsonData)
                self.contrastChecker = contrastChecker
                update.toggle()
            } catch {
                print("Erreur de décodage : \(error.localizedDescription)")
            }
        }
        task.resume()
    }

}//END struct

//MARK: - Preview
struct ContrastCheckerAPIView_Previews: PreviewProvider {
    static var previews: some View {
        ContrastCheckerAPIView()
    }
}
