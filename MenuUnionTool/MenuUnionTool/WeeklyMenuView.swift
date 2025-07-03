//
//  WeeklyMenuView.swift
//  MenuUnionTool
//
//  Created by 石原脩平 on 2025/01/13.
//

import SwiftUI

struct WeeklyMenuView: View {
    let weeklyMenu: WeeklyMenu?
    
    var body: some View {
        ScrollView {
            if let menu = weeklyMenu {
                VStack(alignment: .leading, spacing: 20) {
                    Text("今週の献立")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    BulletListView(meals: menu.meals)
                }
                .padding()
            } else {
                VStack {
                    ProgressView()
                    Text("献立を読み込み中...")
                        .padding()
                }
            }
        }
    }
}

struct BulletListView: View {
    let meals: [DailyMeal]
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 8) {
            ForEach(meals) { dailyMeal in
                VStack(alignment: .leading, spacing: 4) {
                    // 曜日表示
                    Text("\(dailyMeal.dayOfWeek):")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    // 朝食・昼食・夕食を箇条書きで表示
                    if let breakfast = dailyMeal.breakfast {
                        BulletPoint(mealType: "朝食", mealName: breakfast.name)
                    }
                    if let lunch = dailyMeal.lunch {
                        BulletPoint(mealType: "昼食", mealName: lunch.name)
                    }
                    if let dinner = dailyMeal.dinner {
                        BulletPoint(mealType: "夕食", mealName: dinner.name)
                    }
                }
                .padding(.bottom, 8)
            }
        }
        .padding(.horizontal)
    }
}

struct BulletPoint: View {
    let mealType: String
    let mealName: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.title3)
                .foregroundColor(.blue)
            
            HStack(spacing: 4) {
                Text(mealType + ":")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                
                Text(mealName)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
        .padding(.leading, 16)
    }
}


#Preview {
    let sampleMeals = [
        DailyMeal(
            date: Date(),
            dayOfWeek: "月曜日",
            breakfast: Meal(id: 1, name: "トースト", description: nil, created_at: ""),
            lunch: Meal(id: 2, name: "カレーライス", description: nil, created_at: ""),
            dinner: Meal(id: 3, name: "焼き魚定食", description: nil, created_at: "")
        ),
        DailyMeal(
            date: Date(),
            dayOfWeek: "火曜日",
            breakfast: Meal(id: 4, name: "おにぎり", description: nil, created_at: ""),
            lunch: Meal(id: 5, name: "うどん", description: nil, created_at: ""),
            dinner: Meal(id: 6, name: "鶏の唐揚げ", description: nil, created_at: "")
        )
    ]
    
    let sampleMenu = WeeklyMenu(weekStartDate: Date(), meals: sampleMeals)
    
    WeeklyMenuView(weeklyMenu: sampleMenu)
}