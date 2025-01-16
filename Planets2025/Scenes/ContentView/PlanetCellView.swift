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
            .font(.body)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
    }
}

// Preview for the cell
#Preview {
    ListCellView(text: "Sample Cell Text") // Preview in a fitting size
}
