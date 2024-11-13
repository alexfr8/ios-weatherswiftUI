import SwiftUI

struct GenericButton: View {
    private let label: TextButton
    private let color: Color
    private let contentColor: Color
    private let enabled: Bool
    private let loading: Bool
    private let onClick: (() -> Void)?

    init(
        _ text: LocalizedStringKey,
        color: Color = Color.buttonbackground,
        contentColor: Color = Color.buttonforeground,
        enabled: Bool = true,
        loading: Bool = false,
        bundle: Bundle? = nil,
        onClick: (() -> Void)? = nil
    ) {
        self.init(
            label: TextButton(text: text),
            color: color,
            contentColor: contentColor,
            enabled: enabled,
            loading: loading,
            onClick: onClick
        )
    }

    init(
        verbatim: String,
        color: Color = Color.buttonbackground,
        contentColor: Color = Color.buttonforeground,
        enabled: Bool = true,
        loading: Bool = false,
        onClick: (() -> Void)? = nil
    ) {
        self.init(
            label: TextButton(verbatim: verbatim),
            color: color,
            contentColor: contentColor,
            enabled: enabled,
            loading: loading,
            onClick: onClick
        )
    }

    private init(
        label: TextButton,
        color: Color,
        contentColor: Color,
        enabled: Bool,
        loading: Bool,
        onClick: (() -> Void)?
    ) {
        self.label = label
        self.color = color
        self.contentColor = contentColor
        self.enabled = enabled
        self.loading = loading
        self.onClick = onClick
    }

    var body: some View {
        Button {
            onClick?()
        } label: {
            if loading {
                ProgressView()
            } else {
                label
            }
        }
        .buttonStyle(
            CustomButtonStyle(
                color: color,
                contentColor: contentColor,
                enabled: enabled
            )
        )
        .disabled(!enabled)
    }
}

struct CustomButtonStyle: ButtonStyle {
    var color: Color
    var contentColor: Color
    var enabled: Bool

    // MARK: Actived States

    var foregroundColor: Color {
        return contentColor
    }

    var backgroundColor: Color {
        return color
    }

    // MARK: Disabled States

    var disabledForegroundColor: Color {
        return Color.buttonforeground
    }

    var disabledBackgroundColor: Color {
        Color.buttondisabled
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(enabled ? foregroundColor : disabledForegroundColor)
            .tint(enabled ? foregroundColor : disabledForegroundColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .padding(.horizontal, 6)
            .background(enabled ? backgroundColor : disabledBackgroundColor)
            .cornerRadius(25)
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


#Preview {
    VStack {
        GenericButton(verbatim:"GenericButton",loading: false) {
            print("GenericButton tapped")
        }

        Divider()

        GenericButton(verbatim: "Loading Button", loading: true) {
            print("Loading")
        }
        Divider()

        GenericButton(verbatim: "Disabled", enabled: false) {
            print("disabled")
        }
    }
}
