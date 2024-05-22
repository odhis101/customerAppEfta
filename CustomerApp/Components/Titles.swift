//
//  TitleIntroduction.swift
//  CustomerApp
//
//  Created by Natasha Odhiambo on 13/05/2024.
//

import SwiftUI

struct LogoAndTitleView: View {
    @EnvironmentObject var config: AppConfig
    let geometry: GeometryProxy
    var title: String
    var subTitle : String
    @Binding var presentationMode: PresentationMode // Binding for navigation

    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    print("pressed")
                    self.presentationMode.dismiss()
                    //self.showAlert = true // Set showAlert to true to show the alert

                }) {
                    Image("backButton")
                }
                
                Spacer ()
                
                Image(config.splashImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.2)
                    .padding(.top, 0)
                    .padding(.trailing,geometry.size.width * 0.2)
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(config.primaryColor)
                
                Text(subTitle)
                    .font(.headline)
                    .foregroundColor(Color.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Allow the VStack to expand horizontally
            .padding()
        }
        .navigationBarHidden(true)

    }

}


struct LogoAndTitleViewWithProgressbar: View {
    @EnvironmentObject var config: AppConfig
    let geometry: GeometryProxy
    var title: String
    var subTitle : String
    @Binding var progress: CGFloat // Binding for dynamic progress

    @Binding var presentationMode: PresentationMode // Binding for navigation

    var body: some View {
        
        VStack {
            HStack{
                Button(action: {
                    print("pressed")
                    self.presentationMode.dismiss()
                    //self.showAlert = true // Set showAlert to true to show the alert

                }) {
                    Image("backButton")
                }
                
                Spacer ()
                
                Image(config.splashImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.2)
                    .padding(.top, 0)
                    .padding(.trailing,geometry.size.width * 0.2)
                
                Spacer()
            }
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width - 30, height: 5) // Adjusted width to account for padding
                    .foregroundColor(.gray.opacity(0.4))
                    .cornerRadius(10)
                
                Rectangle()
                    .frame(width: (geometry.size.width - 30) * progress, height: 5) // Adjusted width to account for padding
                    .foregroundColor(config.primaryColor)
                    .cornerRadius(10)
            }

            
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(config.primaryColor)
                
                Text(subTitle)
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Allow the VStack to expand horizontally
            .padding()
        }
        .navigationBarHidden(true)

    }

}


/*
#Preview {
    
 GeometryReader { geometry in
     LogoAndTitleView(geometry: geometry, title: "Title", subTitle: "Subtitle", presentationMode: <#Binding<PresentationMode>#>)
         .environmentObject( AppConfig(region: .efken)) // Provide environment object
 }

}
 */
/*
struct LogoAndTitleViewWithProgressbar_Previews: PreviewProvider {
    @State private static var progress: CGFloat = 0.5 // Initial progress value for preview
    
    static var previews: some View {
        GeometryReader { geometry in
            LogoAndTitleViewWithProgressbar(geometry: geometry, title: "Title", subTitle: "Subtitle", progress: $progress)
                .environmentObject(AppConfig(region: .efken)) // Provide environment object
        }
    }
}
*/
