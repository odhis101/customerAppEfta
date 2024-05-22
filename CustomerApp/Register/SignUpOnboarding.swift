//
//  SignUp.swift
//  CustomerApp
//
//  Created by Natasha Odhiambo on 13/05/2024.
//

import SwiftUI
struct SignUpOnboarding: View {
    // Array containing carousel items
    let carouselItems: [(String, [String])] = [
        ("Rectangle 7", ["Welcome to EFTA", "“When other lenders say no, we often                       say yes."]),
        ("Rectangle 7 (1)", ["Access Equipment Financing", "For small and medium enterprises across all sectors."]),
        ("Rectangle 8", ["Flexible repayment               plan", "To bring a transformative impact to        the people "]),
    ]
    @State private var isModalVisible = false

    @State private var currentIndex = 0
    @State private var StaffNumber:String=""
    @State private var PhoneNumber:String=""
    @EnvironmentObject var config: AppConfig
    @EnvironmentObject var pinHandler: PinHandler
    
    
 
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack() {
                    // Background Image Carousel
                    ForEach(carouselItems.indices, id: \.self) { index in
                        Image(carouselItems[index].0)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height - 0)
                            .opacity(index == currentIndex ? 1 : 0) // Show only the current image
                            .animation(.easeInOut(duration: 1.0)) // Add animation for opacity change
                            .transition(.opacity) // Apply opacity transition
                            .padding(index == 1 ? .bottom : .top, 0)

                    }
                    ZStack {
                        VStack {
                            HStack(alignment: .center) {
                                Image(config.splashImageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.3)
                            }
                            .padding(.bottom, geometry.size.height * 0.35)
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Image("Intersect2")
                                    .resizable()
                                    .frame(width: geometry.size.width * 1)
                                    .aspectRatio(contentMode: .fit)
                                    .overlay(
                                        VStack(alignment: .leading) {
                                            ForEach(carouselItems[currentIndex].1.indices, id: \.self) { index in
                                                let text = carouselItems[currentIndex].1[index]
                                                
                                                Text(text)
                                                    .font(index == 0 ? .title : .headline)
                                                    .foregroundColor(.white)
                                                    .fontWeight(index == 0 ? .bold : .regular)
                                                    .multilineTextAlignment(.leading)
                                                    //.padding(.top, index == 0 ? 8 : 8)
                                                    //.padding(.bottom, index == 0 ? 0 : 8)
                                                    .padding(.horizontal)
                                            }
                                            VStack(spacing: 16) {
                                                CustomNavigationButton(destination: Text("Next View"), label: "Get Started", backgroundColor: Color(hex:"#2AA241"), strokeColor: .white,strokeWidth:1)
                                                // add a hstack to this 
                                                Text("Already have an account?Login")
                                                    .foregroundColor(.white)
                                                Image("FrameLogin")
                                                
                                                


                                            }
                                        }
                                    )
                            }
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                    

                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < 0 {
                                    currentIndex = (currentIndex + 1) % carouselItems.count
                                } else {
                                    currentIndex = currentIndex == 0 ? carouselItems.count - 1 : currentIndex - 1
                                }
                            }
                    )
                    /*
                    
                    .overlay(
                         ModalView(isVisible: $isModalVisible)
                             .animation(.easeInOut)
                             .offset(y: isModalVisible ? 0 : geometry.size.height) // Set initial offset

                     )
            
*/
                  
                }
                .navigationBarHidden(true)
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }

}

#Preview {
    SignUpOnboarding()
        .environmentObject(AppConfig(region: .efken))
        .environmentObject(PinHandler())
}





