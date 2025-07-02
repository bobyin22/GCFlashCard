//
//  ContentView.swift
//  FlashCards
//
//  Created by Yin Bob on 2025/7/2.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            QuestionListView()
                .tabItem {
                    Label("Questions", systemImage: "list.dash")
                }
            QuizView()
                .tabItem {
                    Label("Quiz", systemImage: "questionmark")
                }
        }
    }
}

#Preview {
    ContentView()
}
