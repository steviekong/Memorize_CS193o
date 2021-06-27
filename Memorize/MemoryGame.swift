//
//  MemoryGame.swift
//  Memorize
//
//  Created by Sidharth Reji kumar on 26/06/21.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var currentTheme: Theme?
    private(set) var currentScore = 0
    
    private var indexOfFaceUpCard: Int?{
        get { cards.indices.filter({cards[$0].isFaceUp}).onAndOnly }
        set { cards.indices.forEach({cards[$0].isFaceUp = $0 == newValue }) }
    }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id} )
           , !cards[chosenIndex].isFaceUp
           , !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    currentScore += 2
                }
                else {
                    if(cards[chosenIndex].hasBeenSeen){
                        currentScore -= 1
                    }
                }
            }
            else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
            }
            cards[chosenIndex].isFaceUp.toggle()
            cards[chosenIndex].hasBeenSeen = true
            indexOfFaceUpCard = chosenIndex
        }
    }
    
    mutating func newGame(themeList: [Theme]){
        cards = []
        currentScore = 0
        let newTheme = themeList.randomElement()
        currentTheme = newTheme
        if let numPairs = newTheme?.numberOfPairs, let emojiCapacity = newTheme?.emojiList.count {
            var limit = numPairs <= emojiCapacity ? numPairs : emojiCapacity
            var selectedEmojiList: [CardContent] = []
            while limit > 0 {
                let randomEmoji = newTheme?.emojiList.randomElement()
                if let foundEmoji = randomEmoji {
                    if(!selectedEmojiList.contains(foundEmoji)){
                        cards.append(Card(content: foundEmoji , id: 2 * limit))
                        cards.append(Card(content: foundEmoji , id: 2 * limit + 1))
                        selectedEmojiList.append(foundEmoji)
                        limit -= 1
                    }
                }
            }
        }
        cards.shuffle()
    }
    
    init(themeList: [Theme]){
        cards = []
        let newTheme = themeList.randomElement()
        currentTheme = newTheme
        if let numPairs = newTheme?.numberOfPairs, let emojiCapacity = newTheme?.emojiList.count {
            var limit = numPairs <= emojiCapacity ? numPairs : emojiCapacity
            var selectedEmojiList: [CardContent] = []
            while limit > 0 {
                let randomEmoji = newTheme?.emojiList.randomElement()
                if let foundEmoji = randomEmoji {
                    if(!selectedEmojiList.contains(foundEmoji)){
                        cards.append(Card(content: foundEmoji , id: 2 * limit))
                        cards.append(Card(content: foundEmoji , id: 2 * limit + 1))
                        selectedEmojiList.append(foundEmoji)
                        limit -= 1
                    }
                }
            }
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenSeen: Bool = false
        var content: CardContent
        var id: Int
    }
    
    struct Theme {
        var name: String
        var emojiList: [CardContent]
        var numberOfPairs: Int
        var cardColor: Color
    }
}

extension Array {
    var onAndOnly: Element? {
        if self.count == 1 {
            return self.first
        }
        else {
            return nil
        }
    }
}
