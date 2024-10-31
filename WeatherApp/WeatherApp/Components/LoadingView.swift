import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
                .opacity(0.6)
                .zIndex(1)

            ProgressView()
        }
        .ignoresSafeArea()
        .zIndex(.greatestFiniteMagnitude)
        .presentationBackground(.clear)
    }
}

#Preview {
    LoadingView()
}
