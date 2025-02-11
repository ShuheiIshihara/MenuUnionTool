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

//let instruments: [Instrument] = try await supabase
//    .from("meal_menu")
//    .select()
//    .execute()
//    .value
