import SwiftUI

public struct TonalButton: View {
    private let text: LocalizedStringKey
    private let verbatim: String
    private let enabled: Bool
    private let bundle: Bundle?
    private let onClick: (() -> Void)?

    public init(_ text: LocalizedStringKey, enabled: Bool = true, bundle: Bundle? = nil, onClick: (() -> Void)?) {
        self.init(text: text, verbatim: "", enabled: enabled, bundle: bundle, onClick: onClick)
    }

    public init(verbatim: String, enabled: Bool = true, onClick: (() -> Void)?) {
        self.init(text: "", verbatim: verbatim, enabled: enabled, onClick: onClick)
    }

    private init(text: LocalizedStringKey, verbatim: String, enabled: Bool = true, bundle: Bundle? = nil, onClick: (() -> Void)?) {
        self.text = text
        self.verbatim = verbatim
        self.enabled = enabled
        self.bundle = bundle
        self.onClick = onClick
    }

    public var body: some View {
        if verbatim.isEmpty {
            makeButtonWithLocalized()
        } else {
            makeButtonWithVerbatim()
        }
    }

    // MARK: Private methods

    private func makeButtonWithLocalized() -> some View {
        GenericButton(
            text,
            color: Color.buttonTonalBackground,
            contentColor: Color.buttonTonallForeground,
            enabled: enabled,
            bundle: bundle
        ) {
            onClick?()
        }
    }

    private func makeButtonWithVerbatim() -> some View {
        GenericButton(
            verbatim: verbatim,
            color: Color.buttonTonalBackground,
            contentColor: Color.buttonTonallForeground,
            enabled: enabled
        ) {
            onClick?()
        }
    }
}

#Preview {
    VStack {
        Spacer()
        TonalButton("Button") {}
        Spacer()
    }
    .background(Color.background)
}
