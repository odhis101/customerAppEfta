//
//  Checkbox.swift
//  CustomerApp
//
//  Created by Natasha Odhiambo on 14/05/2024.
//

import SwiftUI

struct TermsAndConditionsCheckbox: View {
    @Binding var isChecked: Bool
    @EnvironmentObject var config: AppConfig

    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(isChecked ? config.primaryColor : .primary)
                
                Text("I agree to the ")
                    .foregroundColor(.primary)
                    .font(.body)
                
                Text("Terms and Conditions")
                    .foregroundColor(config.primaryColor) // Set text color to green
                    .font(.body)
            }
        }
    }
}


#Preview {
    TermsAndConditionsCheckbox(isChecked: .constant(true))
        .environmentObject( AppConfig(region: .efken)) // Provide environment object

    
}
