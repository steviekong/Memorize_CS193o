//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Sidharth Reji kumar on 26/06/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    static let vehiclesEmojiList : [String] = ["✈️", "🚗", "🚜", "🚝" , "🚀" , "🚘" , "🏎", "🚓"]
    static let fruitsEmojiList: [String] = ["🍋", "🍉", "🍒", "🥥", "🍍"]
    
    static let themeList: [MemoryGame<String>.Theme] = [
        MemoryGame.Theme(name: "Vehicles", emojiList: vehiclesEmojiList, numberOfPairs: 4, cardColor: Color.red),
        MemoryGame.Theme(name: "Fruits", emojiList: fruitsEmojiList, numberOfPairs: 5, cardColor: Color.blue)
    ]
    
    @Published private var model: MemoryGame<String> =
        MemoryGame<String>(themeList: themeList)
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var theme: MemoryGame<String>.Theme? {
        return model.currentTheme
    }
    
    var getScore: Int {
        return model.currentScore
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame(){
        model.newGame(themeList: EmojiMemoryGame.themeList)
    }
}
