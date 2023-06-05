//
//  HomeScreenView.swift
//  APIs
//
//  Created by KaayZenn on 12/05/2023.
//

import SwiftUI

struct HomeScreenView: View {

    //Custom type

    //Environnements

    //State or Binding String

    //State or Binding Int, Float and Double

    //State or Binding Bool
    @State private var showInfoView: Bool = false

    //Enum

    //Computed var

    //MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink(destination: CurrencyAPIView(), label: {
                        Text("Currency Converter")
                    })
                    NavigationLink(destination: ShortenerAPIView(), label: {
                        Text("URL Shortener")
                    })
                    NavigationLink(destination: MoviesDatabaseAPIView(), label: {
                        Text("Movies Database")
                    })
                    NavigationLink(destination: TextTranslatorAPIView(), label: {
                        Text("Text Translator")
                    })
                    NavigationLink(destination: F1LiveMotorsportAPIView(), label: {
                        Text("F1 Live Motorsport")
                    })
                    
                    NavigationLink(destination: LoveCalculatorAPIView(), label: {
                        Text("Love Calculator")
                    })
                    NavigationLink(destination: PasswordGeneratorAPIView(), label: {
                        Text("Password Generator")
                    })
                    NavigationLink(destination: LogoFinderAPIView(), label: {
                        Text("Logo Finder")
                    })
                } header: {
                    Text("APIs")
                }
            }
            .navigationTitle("APIs")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showInfoView, content: { InfoView() })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showInfoView.toggle()
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                }
            }
        }
    }//END body

    //MARK: Fonctions

}//END struct

//MARK: - Preview
struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
