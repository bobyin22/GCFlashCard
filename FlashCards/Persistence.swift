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
        ("Concrete", "混凝土"),
                ("Cement", "水泥"),
                ("Aggregate", "骨料 / 碎石"),
                ("Sand", "沙子"),
                ("Gravel", "礫石 / 碎石子"),
                ("Rebar", "鋼筋"),
                ("Wire Mesh", "鋼絲網"),
                ("Formwork / Forms", "模板"),
                ("Lumber", "木材 / 木料"),
                ("Plywood", "膠合板 / 夾板"),
                ("OSB (Oriented Strand Board)", "定向刨花板"),
                ("Drywall / Gypsum Board", "石膏板 / 乾牆"),
                ("Stud", "立柱 / 骨架材"),
                ("Joist", "擱柵 / 樓面樑"),
                ("Rafter", "椽子 / 屋頂樑"),
                ("Beam", "樑"),
                ("Column", "柱子"),
                ("Truss", "桁架"),
                ("Sheathing", "護層板 / 鋪層板"),
                ("Vapor Barrier", "防潮層 / 蒸汽屏障"),
                ("Insulation", "絕緣材料 / 保溫材料"),
                ("Fiberglass Insulation", "玻璃纖維絕緣材"),
                ("Foam Board Insulation", "泡沫板絕緣材"),
                ("Roofing Shingles", "屋頂瓦片 (瀝青瓦)"),
                ("Roofing Felt", "屋頂油氈 / 防水氈"),
                ("Underlayment", "底層墊層 (屋頂/地板)"),
                ("Flashing", "泛水板 / 擋水板"),
                ("Gutter", "排水槽 / 天溝"),
                ("Downspout", "落水管"),
                ("Siding", "外牆板 / 壁板"),
                ("Brick", "磚"),
                ("Stone", "石頭"),
                ("Mortar", "砂漿 / 灰漿"),
                ("Stucco", "灰泥 / 批盪"),
                ("Veneer", "飾面 / 貼面"),
                ("Tile", "瓷磚 / 瓦片"),
                ("Grout", "填縫劑"),
                ("Adhesive", "黏合劑"),
                ("Caulk / Sealant", "填縫膠 / 密封膠"),
                ("Paint", "油漆"),
                ("Primer", "底漆"),
                ("Stain", "木材染色劑"),
                ("Varnish", "清漆"),
                ("Epoxy", "環氧樹脂"),
                ("Flooring", "地板材料"),
                ("Hardwood Flooring", "實木地板"),
                ("Laminate Flooring", "複合地板 / 層壓地板"),
                ("Vinyl Flooring", "塑膠地板 / 乙烯基地板"),
                ("Carpet", "地毯"),
                ("Ceramic Tile", "陶瓷磚"),
                ("Porcelain Tile", "拋光磚 / 瓷質磚"),
                ("Natural Stone Tile", "天然石材磚"),
                ("Cabinetry / Cabinets", "櫥櫃 / 櫃子"),
                ("Countertop", "檯面"),
                ("Granite", "花崗岩"),
                ("Quartz", "石英石"),
                ("Marble", "大理石"),
                ("Laminate Countertop", "層壓板檯面"),
                ("Fixture", "固定裝置 / 燈具 / 衛浴設備"),
                ("Plumbing Fixtures", "衛浴設備"),
                ("Electrical Fixtures", "電氣燈具"),
                ("Faucet", "水龍頭"),
                ("Sink", "水槽"),
                ("Toilet", "馬桶"),
                ("Shower Head", "淋浴噴頭"),
                ("Bathtub", "浴缸"),
                ("Light Fixture", "燈具"),
                ("Outlet", "插座"),
                ("Switch", "開關"),
                ("Circuit Breaker", "斷路器"),
                ("Wiring / Wire", "電線 / 接線"),
                ("Conduit", "導線管 / 電線管"),
                ("Junction Box", "接線盒"),
                ("HVAC Ductwork", "空調風管"),
                ("HVAC Unit", "空調機組"),
                ("Vent", "通風口 / 排氣口"),
                ("Grille", "格柵"),
                ("Pipe", "管道"),
                ("Copper Pipe", "銅管"),
                ("PEX Pipe", "PEX 管"),
                ("PVC Pipe", "PVC 管"),
                ("Drain Pipe", "排水管"),
                ("Vent Pipe", "通氣管"),
                ("Water Heater", "熱水器"),
                ("Pump", "泵"),
                ("Valve", "閥門"),
                ("Connector", "連接件"),
                ("Fastener", "緊固件"),
                ("Nail", "釘子"),
                ("Screw", "螺絲"),
                ("Bolt", "螺栓"),
                ("Nut", "螺帽"),
                ("Washer", "墊圈"),
                ("Anchor", "錨栓 / 固定栓"),
                ("Hinge", "鉸鏈"),
                ("Door Hardware", "門五金"),
                ("Window Hardware", "窗五金"),
                ("Lockset", "門鎖組"),
                ("Weatherstripping", "擋風條 / 密封條"),
                ("Gasket", "墊片 / 密封墊"),
                ("Sealant", "密封劑"),
                ("Primer", "底漆"),
                ("Acoustic Panel", "吸音板"),
                ("Acoustic Insulation", "隔音棉 / 隔音材料"),
                ("Soundproofing", "隔音材料 / 隔音處理"),
                ("Rebar Chair", "鋼筋墊塊 / 鋼筋馬凳"),
                ("Waterproofing Membrane", "防水膜"),
                ("Dampproofing", "防潮層"),
                ("Geotextile", "土工布"),
                ("Weep Hole", "排水孔 / 洩水孔"),
                ("Expansion Joint", "伸縮縫"),
                ("Control Joint", "控制縫"),
                ("Vapor Retarder", "防潮緩衝層"),
                ("Fire Stop", "防火阻斷"),
                ("Fire Caulk", "防火填縫劑"),
                ("Access Panel", "檢修口 / 檢修門"),
                ("Wall Board", "牆板 (泛指板材)"),
                ("Paneling", "鑲板"),
                ("Molding / Trim", "線腳 / 裝飾條"),
                ("Baseboard", "踢腳板 / 地腳線"),
                ("Crown Molding", "天花線腳 / 皇冠線腳"),
                ("Window Sill", "窗台板"),
                ("Threshold", "門檻"),
                ("Header", "門窗過樑 / 楣樑"),
                ("Sill Plate", "基礎墊板 / 地樑板"),
                ("Top Plate", "頂板 / 壓頂板"),
                ("Bottom Plate", "底板 / 地腳板"),
                ("Furring Strip", "木條 / 襯條"),
                ("Blocking", "堵木 / 墊木"),
                ("Lath", "板條 / 網板"),
                ("Plaster", "灰泥 / 石膏 (用於批盪)"),
                ("Cement Board", "水泥板"),
                ("Backer Board", "墊底板 (瓷磚下用)"),
                ("Acoustic Ceiling Tile", "吸音天花板"),
                ("Suspended Ceiling Grid", "吊頂網格 / 龍骨架"),
                ("Insulated Glass Unit (IGU)", "中空玻璃 / 雙層玻璃"),
                ("Low-E Glass", "低輻射玻璃"),
                ("Tempered Glass", "鋼化玻璃"),
                ("Laminated Glass", "夾層玻璃"),
                ("Sealant Gun", "密封槍 / 填縫槍"),
                ("Leveling Compound", "找平劑"),
                ("Primer (Concrete)", "底漆 (混凝土用)"),
                ("Curing Compound", "養護劑 (混凝土用)"),
                ("Compacted Fill", "壓實回填土"),
                ("Vapor Barrier Tape", "防潮膜膠帶"),
                ("Waterproofing Primer", "防水底漆"),
                ("Roof Drain", "屋頂排水口"),
                ("Scupper", "出水口 (屋頂或牆邊)"),
                ("Parapet Wall", "女兒牆 / 欄牆"),
                ("Coping", "壓頂石 / 女兒牆蓋板"),
                ("Chimney", "煙囪"),
                ("Fireplace", "壁爐"),
                ("Mantel", "壁爐架"),
                ("Duct Tape", "膠帶 / 風管膠帶"),
                ("Construction Adhesive", "建築黏合劑"),
                ("Wood Preservative", "木材防腐劑"),
                ("Termite Barrier", "白蟻屏障"),
                ("Radon Mitigation System", "氡氣緩解系統"),
                ("Footing", "基礎 / 基腳"),
                ("Pier", "墩 / 樁基礎"),
                ("Slab-on-Grade", "地坪式基礎"),
                ("Crawl Space", "爬行空間 / 地下淺空間"),
                ("Basement", "地下室")
    ]

    @MainActor
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for (question, answer) in defaultFlashCards {
            let newItem = Item(context: viewContext)
            newItem.question = question
            newItem.answer = answer
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        // 如果是新安裝，添加預設數據
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        if let count = try? container.viewContext.count(for: fetchRequest), count == 0 {
            for (question, answer) in Self.defaultFlashCards {
                let newItem = Item(context: container.viewContext)
                newItem.question = question
                newItem.answer = answer
            }
            try? container.viewContext.save()
        }
    }
}
