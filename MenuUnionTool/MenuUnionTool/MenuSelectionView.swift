//
//  MenuSelectionView.swift
//  MenuUnionTool
//
//  Created by 石原脩平 on 2025/01/13.
//

import SwiftUI

struct MenuSelectionView: View {
    @Binding var weeklyMenu: WeeklyMenu?
    @State private var editingMenu: WeeklyMenu?
    
    var body: some View {
        NavigationView {
            ScrollView {
                if let menu = editingMenu {
                    LazyVStack(spacing: 20) {
                        ForEach(menu.meals.indices, id: \.self) { index in
                            DayMenuSelector(
                                dailyMeal: Binding(
                                    get: { editingMenu!.meals[index] },
                                    set: { editingMenu!.meals[index] = $0 }
                                ),
                                availableMeals: MealCategory.sampleMeals
                            )
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
            .navigationTitle("献立選択")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("保存") {
                        saveMenu()
                    }
                    .disabled(editingMenu == nil)
                }
            }
        }
        .onAppear {
            initializeEditingMenu()
        }
    }
    
    private func initializeEditingMenu() {
        if let currentMenu = weeklyMenu {
            editingMenu = currentMenu
        } else {
            // 新しい週間メニューを作成
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
                    breakfast: nil,
                    lunch: nil,
                    dinner: nil
                )
                dailyMeals.append(dailyMeal)
            }
            
            editingMenu = WeeklyMenu(weekStartDate: startOfWeek, meals: dailyMeals)
        }
    }
    
    private func saveMenu() {
        weeklyMenu = editingMenu
    }
}

struct DayMenuSelector: View {
    @Binding var dailyMeal: DailyMeal
    let availableMeals: MealCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 曜日ヘッダー
            HStack {
                Text(dailyMeal.dayOfWeek)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(dateFormatter.string(from: dailyMeal.date))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // 食事選択セクション
            VStack(spacing: 12) {
                MealSelector(
                    title: "朝食",
                    selectedMeal: dailyMeal.breakfast,
                    availableMeals: availableMeals.breakfast
                ) { meal in
                    dailyMeal.breakfast = meal
                }
                
                MealSelector(
                    title: "昼食",
                    selectedMeal: dailyMeal.lunch,
                    availableMeals: availableMeals.lunch
                ) { meal in
                    dailyMeal.lunch = meal
                }
                
                MealSelector(
                    title: "夕食",
                    selectedMeal: dailyMeal.dinner,
                    availableMeals: availableMeals.dinner
                ) { meal in
                    dailyMeal.dinner = meal
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter
    }
}

struct MealSelector: View {
    let title: String
    let selectedMeal: Meal?
    let availableMeals: [Meal]
    let onMealSelected: (Meal?) -> Void
    
    @State private var showingMealPicker = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Button(action: {
                showingMealPicker = true
            }) {
                HStack {
                    Text(selectedMeal?.name ?? "選択してください")
                        .foregroundColor(selectedMeal != nil ? .primary : .secondary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemBackground))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .sheet(isPresented: $showingMealPicker) {
            MealPickerView(
                title: title,
                meals: availableMeals,
                selectedMeal: selectedMeal,
                onMealSelected: onMealSelected
            )
        }
    }
}

struct MealPickerView: View {
    let title: String
    let meals: [Meal]
    let selectedMeal: Meal?
    let onMealSelected: (Meal?) -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                // 選択をクリアするオプション
                Button(action: {
                    onMealSelected(nil)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Text("選択なし")
                            .foregroundColor(.red)
                        
                        Spacer()
                        
                        if selectedMeal == nil {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                // 利用可能な料理リスト
                ForEach(meals) { meal in
                    Button(action: {
                        onMealSelected(meal)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(meal.name)
                                    .foregroundColor(.primary)
                                    .fontWeight(.medium)
                                
                                if let description = meal.description {
                                    Text(description)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            Spacer()
                            
                            if selectedMeal?.id == meal.id {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .navigationTitle("\(title)を選択")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("キャンセル") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    let sampleMeals = [
        DailyMeal(
            date: Date(),
            dayOfWeek: "月曜日",
            breakfast: nil,
            lunch: nil,
            dinner: nil
        )
    ]
    
    let sampleMenu = WeeklyMenu(weekStartDate: Date(), meals: sampleMeals)
    
    MenuSelectionView(weeklyMenu: .constant(sampleMenu))
}
