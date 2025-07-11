//
//  QuestionListView.swift
//  FlashCards
//
//  Created by Yin Bob on 2025/7/2.
//

import SwiftUI
import CoreData

struct QuestionListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let category: String
    
    @FetchRequest private var items: FetchedResults<Item>
    
    init(category: String) {
        self.category = category
        _items = FetchRequest<Item>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Item.sortIndex, ascending: true)],
            predicate: NSPredicate(format: "category == %@", category)
        )
    }
    
    var body: some View {
        List {
            if items.isEmpty {
                Text("尚無題目")
                    .foregroundColor(.gray)
                    .italic()
            } else {
                ForEach(items) { item in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.question ?? "")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(item.answer?.components(separatedBy: "\n\n").first ?? "")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .listStyle(.insetGrouped)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddQuestionView(category: category)) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    QuestionListView(category: "Business Organization")
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
