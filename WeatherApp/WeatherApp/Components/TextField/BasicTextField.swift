import Combine
import SwiftUI


public struct BasicTextField: View {
    @State private var title: LocalizedStringKey
    @Binding private var textValue: String
    private var hint: LocalizedStringKey
    private var errorSubtitle: LocalizedStringKey?
    private var enabled: Bool
    @State private var textAlignment: TextAlignment
    @State private var keyboardType: UIKeyboardType
    @State private var lineLimit: Int?
    private let onValueChange: (() -> Void)?

    public init(
        textValue: Binding<String>,
        hint: LocalizedStringKey = "",
        title: LocalizedStringKey = "",
        errorSubtitle: LocalizedStringKey? = nil,
        enabled: Bool = true,
        textAlignment: TextAlignment = .leading,
        keyboardType: UIKeyboardType = .default,
        lineLimit: Int? = nil,
        onValueChange: (() -> Void)? = nil
    ) {
        self.hint = hint
        self.title = title
        self.errorSubtitle = errorSubtitle
        self.enabled = enabled
        self.textAlignment = textAlignment
        self.keyboardType = keyboardType
        self.lineLimit = lineLimit
        self.onValueChange = onValueChange
        self._textValue = textValue
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextInfo(text: title, color: Color.text)
                .padding(.bottom, 2)


            TextField(text: $textValue) {
                TextBody(text: hint, color: Color.text)
            }
            .onReceive(Just(textValue)) { _ in
                onValueChange?()
            }
            .keyboardType(keyboardType)
            .lineLimit(lineLimit)
            .multilineTextAlignment(textAlignment)
            .textFieldStyle(
                CustomInputTextFieldStyle(isError: errorSubtitle != nil, enabled: enabled)
            )
            .disabled(!enabled)

            if let errorSubtitle = errorSubtitle {
                TextInfo(text: errorSubtitle, color: Color.textError)
                    .padding(.top, 2)
            }
        }
    }
}

struct CustomInputTextFieldStyle: TextFieldStyle {
    @FocusState var isFocused: Bool
    var isError: Bool
    var enabled: Bool

    // MARK: Actived States

    var contentColor: Color {
        Color.text
    }

    var outlineColor: Color {
        if isError {
            return Color.textError
        } else {
            return isFocused ? Color.textFieldOutline : Color.textFieldOutline
        }
    }

    // MARK: Disabled States

    var disabledContentColor: Color {
        Color.buttondisabled
    }

    var disabledOutlineColor: Color {
        Color.text
    }

    // swiftlint:disable identifier_name
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .focused($isFocused)
            .tint(outlineColor)
            .padding(3)
            .background(Color.buttondisabled)
            .foregroundStyle(enabled ? contentColor : disabledContentColor)
            .overlay(
                RoundedRectangle(
                    cornerRadius: 2
                )
                .stroke(
                    enabled ? outlineColor : disabledOutlineColor,
                    lineWidth: isFocused ? 2 : 1
                )
            )
    }
}

#Preview {
    VStack {
        BasicTextField(
            textValue: .constant("6940 8888 8888 8888"),
            hint: "hint",
            title: "Card number",
            errorSubtitle: nil,
            enabled: true
        )
        .padding()
        Divider()

        BasicTextField(
            textValue: .constant("6940 8888 8888 8888"),
            hint: "hint",
            title: "Card number",
            errorSubtitle: "you have an error",
            enabled: false
        )
        .padding()
    }
}
