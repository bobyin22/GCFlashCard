//
//  QuizView.swift
//  FlashCards
//
//  Created by Yin Bob on 2025/7/2.
//

import SwiftUI

struct QuizView: View {

    @State private var backDegree = 90.0
    @State private var frontDegree = 0.0
    @State private var isFlipped = false
    
    @State private var questionNum = 0
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.question, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    private func validateQuestionNum() {
        if items.isEmpty {
            questionNum = 0
        } else if questionNum >= items.count {
            questionNum = items.count - 1
        }
    }
    
    var body: some View {
        if items.isEmpty {
            VStack {
                Text("沒有閃卡")
                    .font(.title)
                Text("請先新增一些問題")
                    .foregroundColor(.secondary)
            }
        } else {
            VStack {
                ZStack {
                    CardFront(degree: $frontDegree, textContent: items[questionNum].question ?? "沒有問題")
                    CardBack(degree: $backDegree, textContent: items[questionNum].answer ?? "沒有答案")
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        flipCard()
                    }
                }
                
                HStack {
                    if questionNum > 0 {
                        Button(action: {
                            withAnimation {
                                if isFlipped {
                                    flipCard()
                                }
                                questionNum -= 1
                            }
                        }){
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("上一題")
                            }
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("上一題")
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.secondary)
                    }
                    
                    Text("\(questionNum + 1) / \(items.count)")
                        .font(.headline)
                    
                    if questionNum < (items.count - 1) {
                        Button(action: {
                            withAnimation {
                                if isFlipped {
                                    flipCard()
                                }
                                questionNum += 1
                            }
                        }){
                            HStack {
                                Text("下一題")
                                Image(systemName: "chevron.right")
                            }
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        HStack {
                            Text("下一題")
                            Image(systemName: "chevron.right")
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.secondary)
                    }
                }
                .padding()
            }
            .onChange(of: items.count) { _ in
                validateQuestionNum()
            }
        }
    }
    
    private func flipCard() {
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.easeInOut(duration: 0.15)) {
                frontDegree = -90
            }
            withAnimation(.easeInOut(duration: 0.15).delay(0.15)) {
                backDegree = 0
            }
        } else {
            withAnimation(.easeInOut(duration: 0.15)) {
                backDegree = 90
            }
            withAnimation(.easeInOut(duration: 0.15).delay(0.15)) {
                frontDegree = 0
            }
        }
    }
}

#Preview {
    QuizView()
}
