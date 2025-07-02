//
//  CardBack.swift
//  FlashCards
//
//  Created by Yin Bob on 2025/7/2.
//

import SwiftUI

struct CardBack: View {
    @Binding var degree: Double
    let textContent: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.blue.opacity(0.7), lineWidth: 3)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.blue.opacity(0.1))
                )
                .shadow(radius: 5)
                .padding()
            
            VStack(spacing: 20) {
                Text("答案")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.blue)
                
                Text(textContent)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25)
                    .lineLimit(5)
            }
        }
        .rotation3DEffect(
            Angle(degrees: degree),
            axis: (x: 0.0, y: 1.0, z: 0.0),
            perspective: 0.3
        )
    }
}

//#Preview {
//    CardBack(degree: 0.0, textContent: "Answer string goes here")
//}
