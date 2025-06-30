//
//  ShoppingListView.swift
//  MenuUnionTool
//
//  Created by 石原脩平 on 2025/01/13.
//

import SwiftUI

struct ShoppingListView: View {
    @Binding var shoppingList: [ShoppingListItem]
    
    var body: some View {
        List {
            ForEach(shoppingList.indices, id: \.self) { index in
                ShoppingListRow(item: $shoppingList[index])
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct ShoppingListRow: View {
    @Binding var item: ShoppingListItem
    
    var body: some View {
        HStack(spacing: 12) {
            // チェックボックス
            Button(action: {
                item = ShoppingListItem(
                    ingredient: item.ingredient,
                    quantity: item.quantity
//                    isCompleted: !item.isCompleted
                )
            }) {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(item.isCompleted ? .green : .gray)
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle())
            
            // 食材情報
            VStack(alignment: .leading, spacing: 4) {
                Text(item.ingredient.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .strikethrough(item.isCompleted)
                    .foregroundColor(item.isCompleted ? .secondary : .primary)
                
                HStack {
                    Text("\(formatQuantity(item.quantity)) \(item.ingredient.unit)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .onTapGesture {
            item = ShoppingListItem(
                ingredient: item.ingredient,
                quantity: item.quantity
//                isCompleted: !item.isCompleted
            )
        }
    }
    
    private func formatQuantity(_ quantity: Double) -> String {
        if quantity == floor(quantity) {
            return String(Int(quantity))
        } else {
            return String(format: "%.1f", quantity)
        }
    }
}

#Preview {
    let sampleIngredients = [
        Ingredient(id: 1, name: "米", unit: "合", created_at: ""),
        Ingredient(id: 2, name: "卵", unit: "個", created_at: ""),
        Ingredient(id: 3, name: "牛乳", unit: "ml", created_at: "")
    ]
    
    let sampleShoppingList = sampleIngredients.map { ingredient in
        ShoppingListItem(ingredient: ingredient, quantity: Double.random(in: 1...5))
    }
    
    ShoppingListView(shoppingList: .constant(sampleShoppingList))
}
