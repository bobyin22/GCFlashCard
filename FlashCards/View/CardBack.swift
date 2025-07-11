//
//  CardBack.swift
//  FlashCards
//
//  Created by Yin Bob on 2025/7/2.
//

import SwiftUI

struct CardBack: View {
    let text: String
    
    var formattedText: AttributedString {
        var result = AttributedString()
        let lines = text.components(separatedBy: "\n")
        
        for line in lines {
            if line.starts(with: "- ") {
                // 關鍵詞
                var keyword = AttributedString(line.dropFirst(2))
                keyword.foregroundColor = .blue
                keyword.font = .system(.body, design: .rounded, weight: .medium)
                result += keyword + AttributedString("\n")
            } else if line == "關鍵詞：" {
                var header = AttributedString(line)
                header.foregroundColor = .secondary
                header.font = .system(.subheadline, design: .rounded, weight: .medium)
                result += header + AttributedString("\n")
            } else if !line.isEmpty {
                // 一般文字
                var normal = AttributedString(line)
                normal.foregroundColor = .white
                normal.font = .system(.body, design: .rounded)
                result += normal + AttributedString("\n")
            }
        }
        
        return result
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.1, green: 0.1, blue: 0.2))
                .shadow(radius: 10)
            
            VStack {
                Spacer()
                
                ScrollView {
                    Text(formattedText)
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                
                Spacer()
                
                Text("點擊返回問題")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
        }
        .frame(width: 320, height: 420)
    }
}

#Preview {
    CardBack(text: "承包商不僅需要施工技能，還要具備業務、規劃與指導能力。\n\n關鍵詞：\n- 施工技能\n- 業務能力\n- 規劃能力\n- 指導能力")
        .preferredColorScheme(.dark)
}
