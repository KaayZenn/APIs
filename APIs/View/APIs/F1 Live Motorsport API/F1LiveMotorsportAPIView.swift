//
//  F1LiveMotorsportAPIView.swift
//  APIs
//
//  Created by KaayZenn on 14/05/2023.
//

import SwiftUI

struct F1LiveMotorsportAPIView: View {

    //Custom type
    @State private var f1LiveMotorSportDriver: F1LiveMotorSportDriver? = nil
    
    //Environnements

    //State or Binding String
    @State private var seasonSelected: String = "2023"
    
    //State or Binding Int, Float and Double

    //State or Binding Bool
    @State private var update: Bool = false
    @State private var isLoading: Bool = false

    //Enum

    //Computed var

    //MARK: - Body
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isLoading.toggle()
                    getDriversLiveMotorsportAPI()
                }, label: {
                    Text("Get Drivers")
                })
                
                Spacer()
                
                Picker("", selection: $seasonSelected, content: {
                    ForEach(2000...2023, id: \.self) { year in
                        Text(String(year)).tag(String(year))
                    }
                })
            }
            .padding()
            
            ScrollView {
                if let f1LiveMotorSportDriver = f1LiveMotorSportDriver {
                    ForEach(f1LiveMotorSportDriver.results.sorted { $0.teamName < $1.teamName }, id: \.self) { driver in
                        if driver.isReserve == 0 {
                            HStack {
                                Text(driver.teamName + " : ")
                                Spacer()
                                Text(driver.driverName)
                            }
                            .padding(6)
                        }
                    }
                } else if isLoading {
                    ProgressView()
                }
            }
            
            Spacer()
        }
        .navigationTitle("F1 Live Motorsport")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: {
                    SettingView(apiName: "F1 Live Motorsport", apiURL: "https://rapidapi.com/sportcontentapi/api/f1-live-motorsport-data")
                }, label: {
                    Image(systemName: "gear")
                        .foregroundColor(.colorLabel)
                })
            }
        }
    }//END body

    //MARK: Fonctions
    
    func getDriversLiveMotorsportAPI() {
        let headers = [
            "X-RapidAPI-Key": "27fcb5eff0msh896cc01a86db4b1p11f0edjsn8ce9812c9933",
            "X-RapidAPI-Host": "f1-live-motorsport-data.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://f1-live-motorsport-data.p.rapidapi.com/drivers/\(seasonSelected)")! as URL,
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
                let f1LiveMotorSportDriver = try decoder.decode(F1LiveMotorSportDriver.self, from: jsonData)
                self.f1LiveMotorSportDriver = f1LiveMotorSportDriver
                update.toggle()
            } catch {
                print("Erreur de décodage : \(error.localizedDescription)")
            }
        }
        task.resume()
    }

}//END struct

//MARK: - Preview
struct F1LiveMotorsportAPIView_Previews: PreviewProvider {
    static var previews: some View {
        F1LiveMotorsportAPIView()
    }
}
