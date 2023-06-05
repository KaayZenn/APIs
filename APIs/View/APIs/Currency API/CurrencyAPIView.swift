//
//  CurrencyAPIView.swift
//  APIs
//
//  Created by KaayZenn on 12/05/2023.
//

import SwiftUI

struct CurrencyAPIView: View {

    //Custom type
    @State private var currency: Currency? = nil

    //Environnements

    //State or Binding String
    @State private var actualCurrency: String = "EUR"
    @State private var currencyWanted: String = "USD"
    @State private var currencySymbolWanted: String = "$"
    
    //State or Binding Int, Float and Double
    @State private var amount: Double = 0.0

    //State or Binding Bool
    @State private var isConverting: Bool = false

    //Enum

    //Computed var

    //MARK: - Body
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Actual Currency")
                Picker("", selection: $actualCurrency, content: {
                    Text("EUR").tag("EUR")
                    Text("USD").tag("USD")
                    Text("GBP").tag("GBP")
                })
                .pickerStyle(.segmented)
            }
            .padding()
            
            VStack(alignment: .leading) {
                Text("Currency Wanted")
                Picker("Currency Wanted", selection: $currencyWanted, content: {
                    Text("EUR").tag("EUR")
                    Text("USD").tag("USD")
                    Text("GBP").tag("GBP")
                })
                .pickerStyle(.segmented)
            }
            .padding()
            
            VStack(alignment: .leading) {
                Text("Amount to be converted")
                TextField("Amount", value: $amount, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            
            if let currency = currency {
                Text(String(format: "%0.f", currency.newAmount) + " " + currencySymbolWanted)
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
            } else if isConverting && currency == nil {
                ProgressView()
            } else {
                Text("0 " + currencySymbolWanted)
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
            }
            
            Spacer()
            
            Button(action: {
                isConverting.toggle()
                currencyAPI()
            }, label: {
                HStack {
                    Spacer()
                    Text("Convert")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(8)
                .background(Color.blue)
                .cornerRadius(12)
            })
            .padding()
        }
        .onChange(of: currencyWanted) { newValue in
            if currencyWanted == "EUR" { currencySymbolWanted = "€" }
            if currencyWanted == "USD" { currencySymbolWanted = "$" }
            if currencyWanted == "GBP" { currencySymbolWanted = "£" }
        }
        .navigationTitle("Currency Converter")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: {
                    SettingView(apiName: "Currency Converter", apiURL: "https://rapidapi.com/fyhao/api/currency-exchange")
                }, label: {
                    Image(systemName: "gear")
                        .foregroundColor(.colorLabel)
                })
            }
        }
    }//END body

    //MARK: Fonctions
    func currencyAPI() {
        let url = URL(string: "https://api.api-ninjas.com/v1/convertcurrency?want=\(currencyWanted)&have=\(actualCurrency)&amount=\(String(format: "%0.f", amount))")!
        var request = URLRequest(url: url)
        request.setValue("27fcb5eff0msh896cc01a86db4b1p11f0edjsn8ce9812c9933", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }

            let jsonString = String(data: data, encoding: .utf8)!
            let jsonData = jsonString.data(using: .utf8)!

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let currency = try decoder.decode(Currency.self, from: jsonData)
                self.currency = currency
                self.isConverting = false
                print(currency)
            } catch {
                print("Erreur de décodage : \(error.localizedDescription)")
            }
        }
        task.resume()
    }

}//END struct

//MARK: - Preview
struct CurrencyAPIView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyAPIView()
    }
}
