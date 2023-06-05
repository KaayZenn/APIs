//
//  SettingView.swift
//  APIs
//
//  Created by KaayZenn on 15/05/2023.
//

import SwiftUI

struct SettingView: View {

    //Custom type

    //Environnements

    //State or Binding String
    var apiName: String
    var apiURL: String

    //State or Binding Int, Float and Double

    //State or Binding Bool

    //Enum

    //Computed var

    //MARK: - Body
    var body: some View {
        Form {
            Section {
                Text(apiName)
                Button(action: {
                    let url: URL = URL(string: apiURL)!
                    UIApplication.shared.open(url)
                }, label: {
                    HStack {
                        Text("View API")
                        Spacer()
                        Image(systemName: "paperplane.fill")
                    }
                })
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }//END body

    //MARK: Fonctions

}//END struct

//MARK: - Preview
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(apiName: "API Preview", apiURL: "https://facebook.com")
    }
}
