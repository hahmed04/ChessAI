import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(Color.black, lineWidth: 5)
                .frame(width: 320, height: 320) // 8 * 40 (since each cell is 40x40)
            
            VStack(spacing: 0) {
                ForEach(0..<8) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<8) { column in
                            Button(action: {
                                // Handle button tap
                            }) {
                                Rectangle()
                                    .fill((row + column) % 2 == 0 ? Color.white : Color.black)
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    ContentView()
}
