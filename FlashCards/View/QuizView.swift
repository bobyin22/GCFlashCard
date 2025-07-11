//
//  QuizView.swift
//  FlashCards
//
//  Created by Yin Bob on 2025/7/2.
//

import SwiftUI
import CoreData

struct QuizView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest private var items: FetchedResults<Item>
    
    @State private var questionNum = 0
    @State private var showingAnswer = false
    @State private var correctCount = 0
    @State private var wrongCount = 0
    @State private var showingScore = false
    @State private var dragState = CGSize.zero
    @State private var cardRotation: Double = 0
    @State private var isAnimatingNextCard = false
    
    private let swipeThreshold: CGFloat = 100.0
    private let rotationFactor: Double = 35.0
    
    init(category: String) {
        _items = FetchRequest<Item>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Item.sortIndex, ascending: true)],
            predicate: NSPredicate(format: "category == %@", category)
        )
    }
    
    var body: some View {
        VStack {
            if items.isEmpty {
                Text("這個類別還沒有題目")
                    .font(.title)
                    .foregroundColor(.gray)
            } else {
                // 進度和分數顯示
                VStack(spacing: 10) {
                    HStack {
                        Spacer()
                        
                        VStack(alignment: .center) {
                            Text("進度：\(questionNum + 1) / \(items.count)")
                                .font(.headline)
                            Text("正確：\(correctCount) 錯誤：\(wrongCount)")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Button(action: shuffleCards) {
                            Image(systemName: "shuffle")
                                .font(.title2)
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    
                    // 卡片視圖
                    GeometryReader { geometry in
                        ZStack {
                            ForEach(Array(items.enumerated().reversed()), id: \.1) { index, item in
                                if index >= questionNum && index <= questionNum + 1 {
                                    let isTopCard = index == questionNum
                                    
                                    ZStack {
                                        if showingAnswer {
                                            CardBack(text: item.answer ?? "")
                                        } else {
                                            CardFront(text: item.question ?? "")
                                        }
                                    }
                                    .offset(x: isTopCard ? dragState.width : 0, y: isTopCard ? 0 : 20)
                                    .scaleEffect(isTopCard ? 1 : 0.95)
                                    .rotationEffect(.degrees(isTopCard ? Double(dragState.width) / rotationFactor : 0))
                                    .gesture(isTopCard && !isAnimatingNextCard ? dragGesture : nil)
                                    .animation(.easeInOut(duration: 0.2), value: dragState)
                                    .animation(.easeInOut(duration: 0.2), value: questionNum)
                                    .onTapGesture {
                                        withAnimation {
                                            showingAnswer.toggle()
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }
        .alert("測驗結束", isPresented: $showingScore) {
            Button("重新開始", action: resetQuiz)
        } message: {
            Text("正確：\(correctCount)\n錯誤：\(wrongCount)\n正確率：\(String(format: "%.1f", Double(correctCount) / Double(correctCount + wrongCount) * 100))%")
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                dragState = gesture.translation
                cardRotation = Double(gesture.translation.width) / rotationFactor
            }
            .onEnded { gesture in
                if abs(dragState.width) > swipeThreshold {
                    // 向右滑動表示記住了，向左滑動表示沒記住
                    if dragState.width > 0 {
                        correctCount += 1
                    } else {
                        wrongCount += 1
                    }
                    
                    isAnimatingNextCard = true
                    
                    // 執行滑出動畫
                    withAnimation(.easeOut(duration: 0.2)) {
                        dragState.width = dragState.width > 0 ? 1000 : -1000
                    }
                    
                    // 等待滑出動畫完成後再切換到下一題
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        questionNum += 1
                        showingAnswer = false

                        dragState = .zero
                        cardRotation = 0
                        isAnimatingNextCard = false
                    }
                } else {
                    withAnimation(.easeOut(duration: 0.2)) {
                        dragState = .zero
                        cardRotation = 0
                    }
                }
            }
    }
    
    private func nextQuestion() {
        if questionNum < items.count - 1 {
            questionNum += 1
        } else {
            showingScore = true
        }
    }
    
    private func resetQuiz() {
        withAnimation {
            questionNum = 0
            correctCount = 0
            wrongCount = 0
            showingAnswer = false
            dragState = .zero
            cardRotation = 0
            isAnimatingNextCard = false
        }
    }
    
    private func shuffleCards() {
        withAnimation {
            // 更新所有卡片的排序索引
            let shuffledIndices = Array(0..<items.count).shuffled()
            for (index, item) in items.enumerated() {
                item.sortIndex = Int32(shuffledIndices[index])
            }
            
            // 保存更改
            do {
                try viewContext.save()
            } catch {
                print("Error shuffling cards: \(error)")
            }
            
            // 重置測驗狀態
            resetQuiz()
        }
    }
}

#Preview {
    QuizView(category: "Law & Business")
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
