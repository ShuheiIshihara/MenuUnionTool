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
    var meals: [DailyMeal]
}

// 1日の献立データモデル
struct DailyMeal: Identifiable {
    let id = UUID()
    let date: Date
    let dayOfWeek: String
    var breakfast: Meal?
    var lunch: Meal?
    var dinner: Meal?
    
    init(date: Date, dayOfWeek: String, breakfast: Meal? = nil, lunch: Meal? = nil, dinner: Meal? = nil) {
        self.date = date
        self.dayOfWeek = dayOfWeek
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
    }
}

// ショッピングリストアイテム
struct ShoppingListItem: Identifiable {
    let id = UUID()
    let ingredient: Ingredient
    let quantity: Double
    let isCompleted: Bool = false
}

// 選択可能な料理のサンプルデータ
struct MealCategory {
    let breakfast: [Meal]
    let lunch: [Meal]
    let dinner: [Meal]
    
    static let sampleMeals = MealCategory(
        breakfast: [
            Meal(id: 1, name: "トースト", description: "バター付きトースト", created_at: ""),
            Meal(id: 2, name: "おにぎり", description: "梅おにぎり", created_at: ""),
            Meal(id: 3, name: "パンケーキ", description: "メープルシロップ付き", created_at: ""),
            Meal(id: 4, name: "シリアル", description: "牛乳とフルーツ付き", created_at: ""),
            Meal(id: 5, name: "卵かけご飯", description: "醤油と海苔付き", created_at: ""),
            Meal(id: 6, name: "ヨーグルト", description: "フルーツとグラノーラ", created_at: "")
        ],
        lunch: [
            Meal(id: 101, name: "カレーライス", description: "野菜カレー", created_at: ""),
            Meal(id: 102, name: "うどん", description: "きつねうどん", created_at: ""),
            Meal(id: 103, name: "サンドイッチ", description: "ハムチーズサンド", created_at: ""),
            Meal(id: 104, name: "チャーハン", description: "卵チャーハン", created_at: ""),
            Meal(id: 105, name: "パスタ", description: "ミートソースパスタ", created_at: ""),
            Meal(id: 106, name: "弁当", description: "のり弁当", created_at: ""),
            Meal(id: 107, name: "ラーメン", description: "醤油ラーメン", created_at: ""),
            Meal(id: 108, name: "そば", description: "ざるそば", created_at: "")
        ],
        dinner: [
            Meal(id: 201, name: "焼き魚定食", description: "鮭の塩焼き定食", created_at: ""),
            Meal(id: 202, name: "鶏の唐揚げ", description: "レモン付き唐揚げ", created_at: ""),
            Meal(id: 203, name: "ハンバーグ", description: "デミグラスソース", created_at: ""),
            Meal(id: 204, name: "生姜焼き", description: "豚肉の生姜焼き", created_at: ""),
            Meal(id: 205, name: "刺身定食", description: "マグロとサーモン", created_at: ""),
            Meal(id: 206, name: "すき焼き", description: "牛肉すき焼き", created_at: ""),
            Meal(id: 207, name: "天ぷら", description: "海老と野菜の天ぷら", created_at: ""),
            Meal(id: 208, name: "麻婆豆腐", description: "辛口麻婆豆腐", created_at: ""),
            Meal(id: 209, name: "ステーキ", description: "牛肉ステーキ", created_at: ""),
            Meal(id: 210, name: "焼肉", description: "BBQセット", created_at: "")
        ]
    )
}

//let instruments: [Instrument] = try await supabase
//    .from("meal_menu")
//    .select()
//    .execute()
//    .value
