//
//  Persistence.swift
//  FlashCards
//
//  Created by Yin Bob on 2025/7/2.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // 預設的閃卡數據
    static let defaultFlashCards = [
        // Business Organization
        ("Business Organization", "What skills do contractors need?", "承包商不僅需要施工技能，還要具備業務、規劃與指導能力。\n\n關鍵詞：\n- 施工技能\n- 業務能力\n- 規劃能力\n- 指導能力"),
        ("Business Organization", "What is an organization?", "組織是一群有特定目的與結構的人；商業組織是為了實現商業目標。\n\n關鍵詞：\n- 特定目的\n- 組織結構\n- 商業目標"),
        ("Business Organization", "What's the difference between profit and nonprofit organizations?", "有些組織為利潤導向，有些則為公益（非營利）。\n\n關鍵詞：\n- 利潤導向\n- 非營利\n- 公益目的"),
        ("Business Organization", "What is the purpose of a business plan?", "商業計劃定義成功策略，是企業發展的路線圖。\n\n關鍵詞：\n- 成功策略\n- 發展路線圖\n- 企業規劃"),
        ("Business Organization", "What should a business plan include?", "包含法律結構、服務內容、市場分析、策略與財務。\n\n關鍵詞：\n- 法律結構\n- 服務內容\n- 市場分析\n- 策略\n- 財務"),
        ("Business Organization", "What is the role of a service plan?", "聚焦目標市場，建立客戶關係。\n\n關鍵詞：\n- 目標市場\n- 客戶關係\n- 服務規劃"),
        
        // Business Finances
        ("Business Finances", "Balance Sheet", "資產負債表"),
        ("Business Finances", "Income Statement", "損益表"),
        ("Business Finances", "Cash Flow", "現金流量"),
        ("Business Finances", "Working Capital", "營運資金"),
        
        // Employer Requirement
        ("Employer Requirement", "Workers Compensation", "工傷賠償"),
        ("Employer Requirement", "Payroll Tax", "薪資稅"),
        ("Employer Requirement", "OSHA Requirements", "職業安全衛生要求"),
        ("Employer Requirement", "Employee Benefits", "員工福利"),
        
        // Bonds Insurance and Liens
        ("Bonds Insurance and Liens", "Performance Bond", "履約保證金"),
        ("Bonds Insurance and Liens", "Payment Bond", "付款保證金"),
        ("Bonds Insurance and Liens", "Liability Insurance", "責任保險"),
        ("Bonds Insurance and Liens", "Mechanics Lien", "機械留置權"),
        
        // Contract Requirements
        ("Contract Requirements", "Bid Requirements", "投標要求"),
        ("Contract Requirements", "Contract Terms", "合約條款"),
        ("Contract Requirements", "Change Orders", "變更單"),
        ("Contract Requirements", "Breach of Contract", "違約"),
        
        // Licensing Requirements
        ("Licensing Requirements", "Contractor License", "承包商執照"),
        ("Licensing Requirements", "License Renewal", "執照更新"),
        ("Licensing Requirements", "Bond Requirements", "保證金要求"),
        ("Licensing Requirements", "Insurance Requirements", "保險要求"),
        
        // Safety
        ("Safety", "Safety Program", "安全計劃"),
        ("Safety", "PPE Requirements", "個人防護設備要求"),
        ("Safety", "Fall Protection", "防墜保護"),
        ("Safety", "Hazard Communication", "危害通識"),
        
        // Public Works
        ("Public Works", "Prevailing Wage", "現行工資"),
        ("Public Works", "Certified Payroll", "認證薪資"),
        ("Public Works", "Bid Process", "投標程序"),
        ("Public Works", "Project Requirements", "項目要求"),
        
        // Math & Safety Review
        ("Math & Safety Review", "Basic Math", "基礎數學"),
        ("Math & Safety Review", "Algebra", "代數"),
        ("Math & Safety Review", "Geometry", "幾何"),
        ("Math & Safety Review", "Trigonometry", "三角函數"),
        ("Math & Safety Review", "Safety Procedures", "安全程序"),
        ("Math & Safety Review", "Safety Equipment", "安全設備"),
        ("Math & Safety Review", "First Aid", "急救"),
        ("Math & Safety Review", "Emergency Response", "緊急應變"),
        
        // B-General Building
        ("B-General Building", "Concrete", "混凝土"),
        ("B-General Building", "Cement", "水泥"),
        ("B-General Building", "Aggregate", "骨料 / 碎石"),
        ("B-General Building", "Sand", "沙子"),
        ("B-General Building", "Gravel", "礫石 / 碎石子"),
        ("B-General Building", "Rebar", "鋼筋"),
        ("B-General Building", "Wire Mesh", "鋼絲網"),
        ("B-General Building", "Formwork / Forms", "模板")
    ]

    @MainActor
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for (index, (category, question, answer)) in defaultFlashCards.enumerated() {
            let newItem = Item(context: viewContext)
            newItem.category = category
            newItem.question = question
            newItem.answer = answer
            newItem.sortIndex = Int32(index)
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FlashCards")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        // 如果是新安裝，添加預設數據
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        if let count = try? container.viewContext.count(for: fetchRequest), count == 0 {
            for (index, (category, question, answer)) in Self.defaultFlashCards.enumerated() {
                let newItem = Item(context: container.viewContext)
                newItem.category = category
                newItem.question = question
                newItem.answer = answer
                newItem.sortIndex = Int32(index)  // 添加排序索引
            }
            do {
                try container.viewContext.save()
            } catch {
                print("Error saving default data: \(error)")
            }
        }
    }
}
