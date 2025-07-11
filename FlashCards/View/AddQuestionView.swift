//
//  AddUestionView.swift
//  FlashCards
//
//  Created by Yin Bob on 2025/7/2.
//

import SwiftUI

struct AddQuestionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    let category: String
    @State private var question = ""
    @State private var answer = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("問題")) {
                    TextField("輸入問題", text: $question)
                }
                
                Section(header: Text("答案")) {
                    TextField("輸入答案", text: $answer)
                }
            }
            .navigationTitle("新增問題")
            .navigationBarItems(
                leading: Button("取消") {
                    dismiss()
                },
                trailing: Button("儲存") {
                    saveItem()
                }
                .disabled(question.isEmpty || answer.isEmpty)
            )
        }
    }
    
    private func saveItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.question = question
            newItem.answer = answer
            newItem.category = category
            
            do {
                try viewContext.save()
                dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    AddQuestionView(category: "Law & Business")
}
