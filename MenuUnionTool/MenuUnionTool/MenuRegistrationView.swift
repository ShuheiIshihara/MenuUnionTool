import SwiftUI

struct MenuRegistrationView: View {
    @State private var menuName = ""
    @State private var ingredients = ""
    @State private var mealTiming = MealTiming.breakfast
    @State private var category = MenuCategory.japanese
    @State private var calories = ""
    @State private var servings = 1
    @State private var memo = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("基本情報") {
                    TextField("メニュー名", text: $menuName)
                    
                    TextField("材料（カンマ区切り）", text: $ingredients, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section("詳細情報") {
                    Picker("食べるタイミング", selection: $mealTiming) {
                        ForEach(MealTiming.allCases, id: \.self) { timing in
                            Text(timing.displayName).tag(timing)
                        }
                    }
                    
                    Picker("カテゴリー", selection: $category) {
                        ForEach(MenuCategory.allCases, id: \.self) { category in
                            Text(category.displayName).tag(category)
                        }
                    }
                    
                    HStack {
                        TextField("カロリー", text: $calories)
                            .keyboardType(.numberPad)
                        Text("kcal")
                    }
                    
                    Stepper("人数: \(servings)人", value: $servings, in: 1...10)
                }
                
                Section("メモ") {
                    TextField("メモ", text: $memo, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("メニュー登録")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("キャンセル") {
                        // TODO: キャンセル処理
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("保存") {
                        // TODO: 保存処理
                    }
                    .disabled(menuName.isEmpty)
                }
            }
        }
    }
}

enum MealTiming: String, CaseIterable {
    case breakfast = "breakfast"
    case lunch = "lunch"
    case dinner = "dinner"
    case snack = "snack"
    
    var displayName: String {
        switch self {
        case .breakfast:
            return "朝食"
        case .lunch:
            return "昼食"
        case .dinner:
            return "夕食"
        case .snack:
            return "間食"
        }
    }
}

enum MenuCategory: String, CaseIterable {
    case japanese = "japanese"
    case western = "western"
    case chinese = "chinese"
    case italian = "italian"
    case other = "other"
    
    var displayName: String {
        switch self {
        case .japanese:
            return "和食"
        case .western:
            return "洋食"
        case .chinese:
            return "中華"
        case .italian:
            return "イタリアン"
        case .other:
            return "その他"
        }
    }
}

#Preview {
    MenuRegistrationView()
}