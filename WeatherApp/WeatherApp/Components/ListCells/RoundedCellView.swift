import SwiftUI

struct RoundedCellView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    VStack {
        RoundedCellView(text: "The title")
    }
}
