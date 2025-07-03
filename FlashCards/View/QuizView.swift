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
    @State private var offset = CGSize.zero
    @State private var cardColor: Color = .clear
    
    @State private var leftScore = 0
    @State private var rightScore = 0
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.question, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    // 計算旋轉角度
    private var rotation: Double {
        return Double(offset.width / 20)
    }
    
    private func validateQuestionNum() {
        if items.isEmpty {
            questionNum = 0
        } else if questionNum >= items.count {
            questionNum = items.count - 1
        }
    }
    
    private func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            // 向左滑動 - 下一題且左邊加分
            if questionNum < items.count - 1 {
                withAnimation(.easeInOut(duration: 0.3)) {
                    offset = CGSize(width: -1000, height: 100)
                    leftScore += 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    questionNum += 1
                    offset = .zero
                    if isFlipped {
                        flipCard()
                    }
                }
            } else {
                withAnimation(.spring()) {
                    offset = .zero
                }
            }
            
        case 150...500:
            // 向右滑動 - 下一題且右邊加分
            if questionNum < items.count - 1 {
                withAnimation(.easeInOut(duration: 0.3)) {
                    offset = CGSize(width: 1000, height: 100)
                    rightScore += 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    questionNum += 1
                    offset = .zero
                    if isFlipped {
                        flipCard()
                    }
                }
            } else {
                withAnimation(.spring()) {
                    offset = .zero
                }
            }
            
        default:
            withAnimation(.spring()) {
                offset = .zero
                cardColor = .clear
            }
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
                Spacer()
                
                ZStack {
                    ZStack {
                        CardFront(degree: $frontDegree, textContent: items[questionNum].question ?? "沒有問題")
                        CardBack(degree: $backDegree, textContent: items[questionNum].answer ?? "沒有答案")
                    }
                    
                    VStack {
                        HStack {
                            Text("\(leftScore)")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.red)
                                .padding()
                            
                            Spacer()
                            
                            Text("\(rightScore)")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.green)
                                .padding()
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .offset(offset)
                .rotationEffect(.degrees(rotation))
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                            // 根據拖動方向改變顏色提示
                            let dragPercentage = gesture.translation.width / UIScreen.main.bounds.width
                            if dragPercentage >= 0.1 {
                                cardColor = .green.opacity(Double(dragPercentage))
                            } else if dragPercentage <= -0.1 {
                                cardColor = .red.opacity(Double(-dragPercentage))
                            } else {
                                cardColor = .clear
                            }
                        }
                        .onEnded { gesture in
                            swipeCard(width: gesture.translation.width)
                        }
                )
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        flipCard()
                    }
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    Text("進度：\(questionNum + 1) / \(items.count)")
                        .font(.headline)
                    
                    Text("總分：\(rightScore)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            .onChange(of: items.count) { _ in
                validateQuestionNum()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        leftScore = 0
                        rightScore = 0
                        questionNum = 0
                    }) {
                        Text("重置")
                    }
                }
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
