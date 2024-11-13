import SwiftUI

struct ApiKeyScreen: View {
    @Environment(\.app)
    private var app

    @State var apiKey: String = ""
    @State var enableButton: Bool = false
    @State var errorText: LocalizedStringKey = ""

    var body: some View {
        VStack {
            TextHeader(text: "powered_by")
                .padding(.top, 24)
            Image(.openweather)
                .resizable()
                .scaledToFit()
                .padding(30)

            Group {
                TextBody(text: "api_key_body")
                    .padding(.vertical, 12)

                BasicTextField(
                    textValue: $apiKey,
                    hint: "api_key_field_hint",
                    title: "api_key_field_title",
                    errorSubtitle: errorText
                ) {
                    if apiKey.isEmpty {
                        enableButton = false
                    } else {
                        enableButton = true
                    }
                }
                .padding(.vertical, 12)

                Spacer()

                GenericButton("api_key_button", enabled: enableButton) {
                    validateTextField()
                }
                .padding(.vertical, 12)
            }
            .padding(.horizontal,36)

        }
        .background(Color.background)
    }

    private func validateTextField() {
        if apiKey.count == 32 {
            Task {
                await app.repository.setApiKey(apiKey)
                app.navigation.push(to: .home)
            }
        } else {
            errorText = "api_key_error"
        }
    }
}

#Preview {
    ApiKeyScreen()
}
