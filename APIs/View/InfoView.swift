//
//  InfoView.swift
//  APIs
//
//  Created by KaayZenn on 05/06/2023.
//

import SwiftUI

struct InfoView: View {

    //Custom type

    //Environnements
    @Environment(\.colorScheme) private var colorScheme

    //State or Binding String

    //State or Binding Int, Float and Double

    //State or Binding Bool

	//Enum
	
	//Computed var

    //MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        Text("I decided to create this little application to improve my skills with APIs in SwiftUI.")
                        
                        Text("You can contact me on twitter for any question or to add an API.")
                        
                        Button(action: {
                            UIApplication.shared.open(URL(string: "https://twitter.com/KaayZenn_")!)
                        }, label: {
                            Text("@KaayZenn_")
                        })
                    }
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                }
                
                Text("Make with ❤️ in 🇫🇷 by KaayZenn.")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
            }
            .background(colorScheme == .dark ? Color(hex: 0x1C1C1E) : Color(hex: 0xF2F2F7))
            .navigationTitle("APIs")
            .navigationBarTitleDisplayMode(.large)
        }
    }//END body

    //MARK: Fonctions

}//END struct

//MARK: - Preview
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
