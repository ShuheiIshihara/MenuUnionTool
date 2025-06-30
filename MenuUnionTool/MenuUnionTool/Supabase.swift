//
//  Supabase.swift
//  MenuUnionTool
//
//  Created by 石原脩平 on 2025/02/11.
//

import Foundation
import Supabase

let urlPath = Bundle.main.object(forInfoDictionaryKey: "YOUR_SUPABASE_URL") as? String
let key = Bundle.main.object(forInfoDictionaryKey: "YOUR_SUPABASE_ANON_KEY") as? String

let supabase = SupabaseClient(supabaseURL: URL(string: urlPath!)!, supabaseKey: key!)

struct Instrument: Decodable {
    let meal_id: Int
    let ingredients_id: Int
    let created_at: String
}

// 献立（料理）のデータモデル
struct Meal: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let created_at: String
}

// 食材のデータモデル
struct Ingredient: Decodable, Identifiable {
    let id: Int
    let name: String
    let unit: String
    let created_at: String
}

// 1週間の献立データモデル
struct WeeklyMenu: Identifiable {
    let id = UUID()
    let weekStartDate: Date
    let meals: [DailyMeal]
}

// 1日の献立データモデル
struct DailyMeal: Identifiable {
    let id = UUID()
    let date: Date
    let dayOfWeek: String
    let breakfast: Meal?
    let lunch: Meal?
    let dinner: Meal?
}

// ショッピングリストアイテム
struct ShoppingListItem: Identifiable {
    let id = UUID()
    let ingredient: Ingredient
    let quantity: Double
    let isCompleted: Bool = false
}

//let instruments: [Instrument] = try await supabase
//    .from("meal_menu")
//    .select()
//    .execute()
//    .value
