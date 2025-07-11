//
//  CardFront.swift
//  FlashCards
//
//  Created by Yin Bob on 2025/7/2.
//

import SwiftUI

struct CardFront: View {
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(radius: 10)
            
            VStack {
                Spacer()
                
                Text(text)
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding()
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text("點擊查看答案")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
        }
        .frame(width: 320, height: 420)
    }
}

#Preview {
    CardFront(text: "What is the purpose of a business plan?")
}
