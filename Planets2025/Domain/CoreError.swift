//
//  Result.swift
//  Planets2025
//
//  Created by Esraa Ragab on 16/01/2025.
//

import Foundation

struct CoreError: Error {
    var localizedDescription: String {
        return message
    }
    
    var message = ""
}
