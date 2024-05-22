//
//  Modals.swift
//  CustomerApp
//
//  Created by Natasha Odhiambo on 09/05/2024.
//

import SwiftUI

struct ModalView: View {
    @Binding var isVisible: Bool
    @GestureState private var dragState = DragState()
    @State private var keyboardHeight: CGFloat = 0
    @EnvironmentObject var pinHandler: PinHandler
    @State private var isLoading = false
    @State private var navigationActive = false
    @EnvironmentObject var config: AppConfig
    @State private var modalMove: CGFloat = 0
    // State variable to track keyboard height
   
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: geometry.size.width, height: modalHeight)
                        .cornerRadius(20)
                    
                    VStack(spacing: 16) {
                        // Title
                        HStack {
                       
                                    Capsule()
                                        .fill(Color.gray.opacity(0.8))
                                        .frame(width: 30, height: 6)
                                
                        }
                        
                      
                            VStack(alignment: .leading) {
                                Text("Welcome to Efta")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(config.primaryColor)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom)
                                
                                Text("When other lenders say no, we often say yes.")
                                    .font(.headline)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom)

                                
                                CustomTextField(placeholder: "Staff Number", text: $pinHandler.staffNumber)
                                
                                CustomTextField(placeholder: "Phone Number", text: $pinHandler.phoneNumber)
                                
                                
                                                            }
                       
                       
                        
                        if isLoading {
                                ProgressView()
                                } else {

                                    Button("Continue") {
                                        sendStaffDetails()
                                    }
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .frame(width:geometry.size.width * 0.8)
                                    .frame(height:30)
                                    .padding()
                                    .background(config.primaryColor)
                                    .cornerRadius(10)
                                
                                }

                        
                    }
                    .padding()
                }
                //.padding(.bottom, keyboardHeight) // Move below keyboard
                .padding(.bottom,modalMove)
                .padding(.top,-10)
            }
            
            .offset(y: isVisible ? 0 : geometry.size.height)// Adjust offset
            .animation(.easeInOut(duration: isVisible ? 0.3 : 0)) // Apply animation duration conditionally
            .gesture(
                DragGesture()
                    .updating($dragState) { value, state, _ in
                        state = DragState()
                    }
                    .onEnded { value in
                        let screenHeight = geometry.size.height
                        let threshold = screenHeight * 0.2 // Adjust threshold as needed
                        if value.translation.height > threshold {
                            isVisible = false
                        }
                    }
            )
            .edgesIgnoringSafeArea(.all)
            .background(
                          NavigationLink(destination: Verification(), isActive: $navigationActive) { EmptyView() }
                      )
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            self.keyboardHeight = keyboardFrame.height
            modalMove = 200
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            self.keyboardHeight = 0
            modalMove = 0
        }
    }
 
       
    private var modalHeight: CGFloat {
        UIScreen.main.bounds.height * 0.5
    }
    
    private struct DragState {
        // No need for any member here
    }
    
    private func sendStaffDetails() {
          isLoading = true
        NetworkManager.shared.sendStaffDetails(staffNumber: pinHandler.staffNumber, phoneNumber: pinHandler.phoneNumber) { success, error in
              isLoading = false
              if success {
                  navigationActive = true
              } else {
                  // Handle error, show an alert or message to the user
                  print(error?.localizedDescription ?? "Unknown error")
              }
          }
     }
}

struct ModalViewStatement: View {
    @Binding var isVisible: Bool
    @GestureState private var dragState = DragState()
    @State private var keyboardHeight: CGFloat = 0
    @EnvironmentObject var pinHandler: PinHandler
    @State private var isLoading = false
    @State private var navigationActive = false
    @EnvironmentObject var config: AppConfig
    @State private var modalMove: CGFloat = 0

    @EnvironmentObject var onboardingData: OnboardingData
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: geometry.size.width, height: modalHeight)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)

                    
                    VStack(spacing: 16) {
                        // Title
                        HStack {
                       
                                    Capsule()
                                        .fill(Color.gray.opacity(0.8))
                                        .frame(width: 30, height: 6)
                                
                        }
                        
                      
                            VStack(alignment: .leading) {
                                Text("Get Statement")
                                    .fontWeight(.bold)
                                    .foregroundColor(config.primaryColor)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom)
                                
                                Text("Kindly fill in the details below to generate  statement")
                                    .font(.caption)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom)

                                
                                QuestionWithDropdownStatement(question: "Type Of ID", options: ["Driving License", "Passport","National ID "], selectedOption: $onboardingData.IDtype)
                                QuestionWithDateStatement(question: "Start Date")
                                QuestionWithDateStatement(question: "End Date")

                                
                                
                                                            }
                       
                       
                        
                        if isLoading {
                                ProgressView()
                                } else {

                                    Button("Generate Statment") {
                                        sendStaffDetails()
                                    }
                                    .foregroundColor(.white)
                                    .frame(width:geometry.size.width * 0.8)
                                    .frame(height:30)
                                    .padding()
                                    .background(config.primaryColor)
                                
                                }

                        
                    }
                    .padding()
                }
                //.padding(.bottom, keyboardHeight) // Move below keyboard
                .padding(.bottom,modalMove)
                .padding(.top,-10)
            }
            
            .offset(y: isVisible ? 0 : geometry.size.height)// Adjust offset
            .animation(.easeInOut(duration: isVisible ? 0.3 : 0)) // Apply animation duration conditionally
            .gesture(
                DragGesture()
                    .updating($dragState) { value, state, _ in
                        state = DragState()
                    }
                    .onEnded { value in
                        let screenHeight = geometry.size.height
                        let threshold = screenHeight * 0.2 // Adjust threshold as needed
                        if value.translation.height > threshold {
                            isVisible = false
                        }
                    }
            )
            .edgesIgnoringSafeArea(.all)
            .background(
                          NavigationLink(destination: Verification(), isActive: $navigationActive) { EmptyView() }
                      )
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            self.keyboardHeight = keyboardFrame.height
            modalMove = 200
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            self.keyboardHeight = 0
            modalMove = 0
        }
    }
 
       
    private var modalHeight: CGFloat {
        UIScreen.main.bounds.height * 0.6
    }
    
    private struct DragState {
        // No need for any member here
    }
    
    private func sendStaffDetails() {
          isLoading = true
        NetworkManager.shared.sendStaffDetails(staffNumber: pinHandler.staffNumber, phoneNumber: pinHandler.phoneNumber) { success, error in
              isLoading = false
              if success {
                  navigationActive = true
              } else {
                  // Handle error, show an alert or message to the user
                  print(error?.localizedDescription ?? "Unknown error")
              }
          }
     }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
      
            TextField(placeholder, text: $text)
                .textFieldStyle(CustomTextFieldStyle())

    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 16) // Add horizontal padding to the placeholder text
            .frame(height: 50)
            .background(Color(hex: "#F2F2F7")) // Set background color with opacity
            .cornerRadius(8)
            //.foregroundColor(.red) // changed to red to see if anything changes
            
    }
}


#Preview {
    ModalView(isVisible: .constant(true))
                .environmentObject(AppConfig(region: .efken))
                .environmentObject(PinHandler())}
