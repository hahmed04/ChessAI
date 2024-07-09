//
//  DebuggingView.swift
//  ChessAI
//
//  Created by Nathanael Tesfaye on 7/8/24.
//

import Foundation
import SwiftUI

struct PawnImagePreview: View {
    
    
    var body: some View {
        Image("pawn")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)  // Adjust size as needed
            .padding()

    }
}

#if DEBUG
struct PawnImagePreview_Previews: PreviewProvider {
    static var previews: some View {
        PawnImagePreview()
    }
}
#endif
