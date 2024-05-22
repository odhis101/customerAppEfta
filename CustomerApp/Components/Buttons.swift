//
//  Buttons.swift
//  CustomerApp
//
//  Created by Natasha Odhiambo on 13/05/2024.
//

import SwiftUI

struct CustomNavigationButton<Destination>: View where Destination: View {
    var destination: Destination
    var label: String
    var backgroundColor: Color
    var strokeColor: Color
    var strokeWidth: CGFloat
    var height: CGFloat


    var body: some View {
        NavigationLink(destination: destination) {
            Text(label)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .bold()
                .frame(height: height)
                .background(backgroundColor)
                .cornerRadius(10)
                .overlay(
                                   RoundedRectangle(cornerRadius: 10)
                                       .stroke(strokeColor, lineWidth: strokeWidth)
                               )
                .padding(.horizontal)
                .padding(.vertical)
        }
    }
}

struct previewView : View {
    var body: some View {
        NavigationView {
            VStack {
                CustomNavigationButton(destination: Text("Next View"), label: "Go to Next View", backgroundColor: .green, strokeColor: .red,strokeWidth:1,height:50)
            }
        }
    }
}


#Preview {
    previewView()
}
