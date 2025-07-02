//
//  CardFront.swift
//  FlashCards
//
//  Created by Yin Bob on 2025/7/2.
//

import SwiftUI

struct CardFront: View {
    @Binding var degree: Double
    let textContent: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.green.opacity(0.5), lineWidth: 10)
                .padding()

            RoundedRectangle(cornerRadius: 20)
                .fill(.green.opacity(0.1))
                .padding()

            VStack {
                Text("Question:")
                    .font(Font.system(size: 50))

                Text("textContent")
                    .lineLimit(10)
                    .font(Font.system(size: 40))
                    .multilineTextAlignment(.center)
                    .padding(25)
            }
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

//#Preview {
//    CardFront(degree: 0.0, textContent: "Question string goes here")
//}
