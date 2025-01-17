//
//  PlanetCellView.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import SwiftUI

struct ListCellView: View {
    let text: String // The text to display in the cell
    
    var body: some View {
        Text(text)
            .font(.system(size: 20, weight: .semibold, design: .default))
            .foregroundColor(Color.planetCellTitleColor) // Custom text color
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 70, alignment: .leading) // Align text to the left
            .listRowSeparator(.hidden)
    }
}

// Preview for the cell
#Preview {
    ListCellView(text: "Sample Cell Text") // Preview in a fitting size
}
