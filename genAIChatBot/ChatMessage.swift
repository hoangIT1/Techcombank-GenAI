//
//  ChatMessage.swift
//  genAIChatBot
//
//  Created by Mac on 09/09/2024.
//

import SwiftUI

struct ChatMessage: Identifiable {
    var id = UUID().uuidString
    
    var owner: MessageOwner
    var text: String	
    
    init(owner: MessageOwner = .user, _ text: String) {
        self.owner = owner
        self.text = text
    }
}
