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
                LazyVStack(spacing: 16) {
                    ForEach(menu.meals) { dailyMeal in
                        DailyMenuCard(dailyMeal: dailyMeal)
                    }
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

struct DailyMenuCard: View {
    let dailyMeal: DailyMeal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 日付と曜日のヘッダー
            HStack {
                Text(dailyMeal.dayOfWeek)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(dateFormatter.string(from: dailyMeal.date))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Divider()
            
            // 朝食・昼食・夕食の表示
            VStack(alignment: .leading, spacing: 8) {
                MealRow(title: "朝食", meal: dailyMeal.breakfast)
                MealRow(title: "昼食", meal: dailyMeal.lunch)
                MealRow(title: "夕食", meal: dailyMeal.dinner)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter
    }
}

struct MealRow: View {
    let title: String
    let meal: Meal?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .frame(width: 50, alignment: .leading)
            
            if let meal = meal {
                Text(meal.name)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                Text("未設定")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .italic()
            }
            
            Spacer()
        }
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
        )
    ]
    
    let sampleMenu = WeeklyMenu(weekStartDate: Date(), meals: sampleMeals)
    
    WeeklyMenuView(weeklyMenu: sampleMenu)
}