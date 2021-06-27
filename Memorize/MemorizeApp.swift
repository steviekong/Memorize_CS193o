//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Sidharth Reji kumar on 26/06/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game:  game)
        }
    }
}
