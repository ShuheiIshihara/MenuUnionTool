//
//  ContentView.swift
//  MenuUnionTool
//
//  Created by 石原脩平 on 2025/01/13.
//

import SwiftUI

struct ContentView: View {
    @State private var weeklyMenu: WeeklyMenu?
    @State private var shoppingList: [ShoppingListItem] = []
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // タブセレクター
                Picker("表示モード", selection: $selectedTab) {
                    Text("献立").tag(0)
                    Text("買い物リスト").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // タブに応じてコンテンツを切り替え
                if selectedTab == 0 {
                    WeeklyMenuView(weeklyMenu: weeklyMenu)
                } else {
                    ShoppingListView(shoppingList: $shoppingList)
                }
                
                Spacer()
            }
            .navigationTitle("MenuUnion")
        }
        .task {
            await loadWeeklyMenu()
            generateShoppingList()
        }
    }
    
    private func loadWeeklyMenu() async {
        // サンプルデータを生成（後でSupabaseから取得するように変更）
        let today = Date()
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: today)?.start ?? today
        
        var dailyMeals: [DailyMeal] = []
        
        for i in 0..<7 {
            let date = calendar.date(byAdding: .day, value: i, to: startOfWeek) ?? startOfWeek
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            dayFormatter.locale = Locale(identifier: "ja_JP")
            
            let dailyMeal = DailyMeal(
                date: date,
                dayOfWeek: dayFormatter.string(from: date),
                breakfast: Meal(id: i*3+1, name: "朝食メニュー\(i+1)", description: nil, created_at: ""),
                lunch: Meal(id: i*3+2, name: "昼食メニュー\(i+1)", description: nil, created_at: ""),
                dinner: Meal(id: i*3+3, name: "夕食メニュー\(i+1)", description: nil, created_at: "")
            )
            dailyMeals.append(dailyMeal)
        }
        
        weeklyMenu = WeeklyMenu(weekStartDate: startOfWeek, meals: dailyMeals)
    }
    
    private func generateShoppingList() {
        // サンプル食材リストを生成
        let sampleIngredients = [
            Ingredient(id: 1, name: "米", unit: "合", created_at: ""),
            Ingredient(id: 2, name: "卵", unit: "個", created_at: ""),
            Ingredient(id: 3, name: "牛乳", unit: "ml", created_at: ""),
            Ingredient(id: 4, name: "玉ねぎ", unit: "個", created_at: ""),
            Ingredient(id: 5, name: "にんじん", unit: "本", created_at: "")
        ]
        
        shoppingList = sampleIngredients.map { ingredient in
            ShoppingListItem(ingredient: ingredient, quantity: Double.random(in: 1...5))
        }
    }
}

#Preview {
    ContentView()
}
