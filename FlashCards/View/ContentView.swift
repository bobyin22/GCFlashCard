//
//  ContentView.swift
//  FlashCards
//
//  Created by Yin Bob on 2025/7/2.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    DisclosureGroup {
                        NavigationLink(destination: CategoryView(category: "Business Organization", title: "1. Business Organization")) {
                            Text("1. Business Organization")
                                .font(.system(.body, design: .rounded))
                        }
                        NavigationLink(destination: CategoryView(category: "Business Finances", title: "2. Business Finances")) {
                            Text("2. Business Finances")
                                .font(.system(.body, design: .rounded))
                        }
                        NavigationLink(destination: CategoryView(category: "Employer Requirement", title: "3. Employer Requirement")) {
                            Text("3. Employer Requirement")
                                .font(.system(.body, design: .rounded))
                        }
                        NavigationLink(destination: CategoryView(category: "Bonds Insurance and Liens", title: "4. Bonds Insurance and Liens")) {
                            Text("4. Bonds Insurance and Liens")
                                .font(.system(.body, design: .rounded))
                        }
                        NavigationLink(destination: CategoryView(category: "Contract Requirements", title: "5. Contract Requirements and Execution")) {
                            Text("5. Contract Requirements and Execution")
                                .font(.system(.body, design: .rounded))
                        }
                        NavigationLink(destination: CategoryView(category: "Licensing Requirements", title: "6. Licensing Requirements")) {
                            Text("6. Licensing Requirements")
                                .font(.system(.body, design: .rounded))
                        }
                        NavigationLink(destination: CategoryView(category: "Safety", title: "7. Safety")) {
                            Text("7. Safety")
                                .font(.system(.body, design: .rounded))
                        }
                        NavigationLink(destination: CategoryView(category: "Public Works", title: "8. Public Works")) {
                            Text("8. Public Works")
                                .font(.system(.body, design: .rounded))
                        }
                    } label: {
                        Label("Law & Business", systemImage: "building.columns")
                            .font(.headline)
                    }
                }
                
                Section {
                    NavigationLink(destination: CategoryView(category: "Math & Safety Review", title: "Math & Safety Review")) {
                        Label("Math & Safety Review", systemImage: "function")
                    }
                    
                    NavigationLink(destination: CategoryView(category: "B-General Building", title: "B-General Building")) {
                        Label("B-General Building", systemImage: "building.2")
                    }
                }
            }
            .navigationTitle("閃卡學習")
            
            // 預設顯示的視圖
            Text("請選擇一個類別開始學習")
                .font(.title)
                .foregroundColor(.gray)
        }
    }
}

struct CategoryView: View {
    let category: String
    let title: String
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            QuizView(category: category)
                .tabItem {
                    Label("測驗", systemImage: "questionmark.circle")
                }
                .tag(1)

            QuestionListView(category: category)
                .tabItem {
                    Label("題庫", systemImage: "list.dash")
                }
                .tag(0)
            

        }
        .navigationTitle(title)
    }
}

#Preview {
    ContentView()
}
