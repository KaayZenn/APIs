//
//  LogoFinderAPIView.swift
//  APIs
//
//  Created by KaayZenn on 16/05/2023.
//

import SwiftUI

struct LogoFinderAPIView: View {

    //Custom type
    @State private var logoBrand: LogoBrand? = nil

    //Environnements

    //State or Binding String
    @State private var brandName: String = ""

    //State or Binding Int, Float and Double

    //State or Binding Bool
    @State private var update: Bool = false
    @State private var logoNotFound: Bool = false

    //Enum

    //Computed var

    //MARK: - Body
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Name of brand")
                TextField("Name of brand", text: $brandName)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            Spacer()
            
            if let logo = logoBrand {
                let images = logo.image.components(separatedBy: "https://")
                AsyncImage(url: URL(string: "https://"+images.last!)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width - 20)
                } placeholder: { ProgressView() }
            }
            
            Spacer()
            
            Button(action: { logoFinderAPI() }, label: {
                HStack {
                    Spacer()
                    Text("Find Logo")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(8)
                .background(Color.blue)
                .cornerRadius(12)
            })
            .padding()
        }
        .alert(isPresented: $logoNotFound, content: {
            return Alert(title: Text("Logo not found"), dismissButton: .cancel(Text("OK"), action: { return }))
        })
        .navigationTitle("Logo Finder")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: {
                    SettingView(apiName: "Logo Finder", apiURL: "https://api-ninjas.com/api/logo")
                }, label: {
                    Image(systemName: "gear")
                        .foregroundColor(.colorLabel)
                })
            }
        }
    }//END body

    //MARK: Fonctions
    
    func logoFinderAPI() {
        let name = brandName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
        let url = URL(string: "https://api.api-ninjas.com/v1/logo?name="+name!)!
        
        var request = URLRequest(url: url)
        
        request.setValue("oS4KKZAPQZ8RDo0UuNC9Qw==DrFJuc9NhU5LujLn", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            guard let data = data else { return }

            let jsonString = String(data: data, encoding: .utf8)!
            let jsonData = jsonString.data(using: .utf8)!

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let logoBrand = try decoder.decode([LogoBrand].self, from: jsonData)
                if logoBrand.count != 0 { self.logoBrand = logoBrand[0] } else { logoNotFound = true }
                update.toggle()
            } catch {
                print("Erreur de décodage : \(error.localizedDescription)")
            }
        }
        task.resume()
    }

}//END struct

//MARK: - Preview
struct LogoFinderAPIView_Previews: PreviewProvider {
    static var previews: some View {
        LogoFinderAPIView()
    }
}
