//
//  ItemToBasketView.swift
//  Spacca Napoli
//
//  Created by Marcin Głodzik on 25/04/2024.
//

import SwiftUI

struct ItemToBasketView: View {
    let id = UUID()
    let imageName: String
    let offset: CGPoint
    @State private var animate = false
    
    var body: some View {
        GeometryReader { screen in
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 80)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .scaleEffect(animate ? CGSize(width: 0.1, height: 0.1) : CGSize(width: 1.0, height: 1.0))
                .rotationEffect(.degrees(animate ? ((offset.x < screen.size.width / 2) ? 90 : -90) : 0))
                .position(x: animate ? screen.size.width / 2 : offset.x , y: animate ? screen.size.height - 50 : (offset.y - 80))
                .animation(.easeIn(duration: 0.4), value: animate)
            
                .onAppear {
                    animate = true
                }
                .allowsHitTesting(false)
        }
    }
}

#Preview {
    ItemToBasketView(imageName: "MARGHERITA", offset: CGPoint(x: 100, y: 200))
}
