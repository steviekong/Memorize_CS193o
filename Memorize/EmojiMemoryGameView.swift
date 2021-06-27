//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Sidharth Reji kumar on 26/06/21.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    let color: Color
    
    var body: some View {
        ZStack(content: {
            let shape = RoundedRectangle(cornerRadius:20)
            if card.isFaceUp {
                shape.fill(Color.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            }
            else if (card.isMatched){
                shape.opacity(0)
            }
            else {
                shape.fill(LinearGradient(
                    gradient: .init(colors: [Color.red, Color.green]),
                    startPoint: .init(x: 0, y: 0),
                    endPoint: .init(x: 1, y: 1)
                  ))
            }
        }).foregroundColor(color)
    }
}

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack{
            HStack{
                if let themeName = game.theme?.name {
                    Text("\(themeName)")
                }
                Spacer()
                Text("Score \(game.getScore)").bold()
            }.padding(20.0)
            Spacer()
            ScrollView{
                LazyVGrid(columns:[GridItem(.adaptive(minimum: 65))]) {
                    if let themeColor = game.theme?.cardColor {
                        ForEach(game.cards, content: {card in
                            CardView(card: card, color: themeColor).aspectRatio(2/3, contentMode: .fill)
                                .onTapGesture(perform: {
                                    game.choose(card)
                                })
                        })
                    }
                }.padding(.horizontal, 20)
            }
            Spacer()
            Button("New Game", action: {
                game.newGame()
            })
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
            EmojiMemoryGameView(game: game)
                .preferredColorScheme(.dark)
            EmojiMemoryGameView(game: game)
                .preferredColorScheme(.light)
        }
    }
}
