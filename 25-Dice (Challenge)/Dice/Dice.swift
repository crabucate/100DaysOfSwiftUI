//
//  Dice.swift
//  Dice
//
//  Created by Felix Leitenberger on 12.04.21.
//

import SwiftUI

struct Dice: View {
    var number: Int
    var size: CGFloat

    var body: some View {
        Image(systemName: "die.face.\(number)")
            .font(.system(size: size))
        }
    }


struct Dice_Previews: PreviewProvider {
    static var previews: some View {
        Dice(number: 5, size: 100)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
