import SwiftUI

struct OnboardingPageView: View {
    struct Model {
        let image: String
        let title: String
    }

    let model: Model

    var body: some View {
        VStack {
            Image(model.image)
                .resizable()
                .scaledToFit()
                .padding()

            Text(verbatim: model.title)
        }
        .padding()
    }
}

#Preview {
    OnboardingPageView(model: OnboardingPageView.Model(image: "houseKey", title: "Title"))
}
