import SwiftUI

struct Ingredient: Identifiable {
    let id = UUID()
    var name: String
    var quantity: String
    var unit: String
    
    init(name: String = "", quantity: String = "", unit: String = "個") {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
}

struct MenuRegistrationView: View {
    @State private var menuName = ""
    @State private var ingredients: [Ingredient] = [Ingredient()]
    @State private var mealTiming = MealTiming.breakfast
    @State private var category = MenuCategory.japanese
    @State private var calories = ""
    @State private var servings = 1
    @State private var memo = ""
    
    private let units = ["個", "g", "kg", "ml", "l", "本", "枚", "袋", "パック", "缶", "瓶", "束", "房", "切れ", "片", "玉", "丁", "匹", "尾", "羽", "頭", "適量", "少々"]
    
    var body: some View {
        NavigationView {
            Form {
                Section("基本情報") {
                    TextField("メニュー名", text: $menuName)
                }
                
                Section("材料") {
                    ForEach(ingredients.indices, id: \.self) { index in
                        IngredientRow(
                            ingredient: $ingredients[index],
                            units: units,
                            onDelete: ingredients.count > 1 ? {
                                deleteIngredient(at: index)
                            } : nil
                        )
                    }
                    
                    Button(action: addIngredient) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                            Text("材料を追加")
                                .foregroundColor(.blue)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
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
                    .disabled(menuName.isEmpty || ingredients.allSatisfy { $0.name.isEmpty })
                }
            }
        }
    }
    
    private func addIngredient() {
        ingredients.append(Ingredient())
    }
    
    private func deleteIngredient(at index: Int) {
        ingredients.remove(at: index)
    }
}

struct IngredientRow: View {
    @Binding var ingredient: Ingredient
    let units: [String]
    let onDelete: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("材料")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                if let onDelete = onDelete {
                    Button(action: onDelete) {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            TextField("材料名", text: $ingredient.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                TextField("数量", text: $ingredient.quantity)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 80)
                
                Picker("単位", selection: $ingredient.unit) {
                    ForEach(units, id: \.self) { unit in
                        Text(unit).tag(unit)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: 100)
                
                Spacer()
            }
        }
        .padding(.vertical, 4)
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