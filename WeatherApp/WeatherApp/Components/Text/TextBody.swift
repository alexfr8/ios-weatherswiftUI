import SwiftUI

struct TextBody: View {
    private var data: LocalizedStringKey
    private var verbatim: String
    private var alignment: TextAlignment
    private var color: Color

    public init(text: LocalizedStringKey, alignment: TextAlignment = .leading, color: Color = .buttonforeground) {
        data = text
        verbatim = ""
        self.alignment = alignment
        self.color = color
    }

    public init(verbatim: String, alignment: TextAlignment = .leading, color: Color = .text) {
        self.verbatim = verbatim
        data = ""
        self.alignment = alignment
        self.color = color
    }

    public var body: some View {
        if verbatim.isEmpty {
            Text(data)
                .multilineTextAlignment(alignment)
                .font(.custom("Montserrat-Regular", size: 14))
                .foregroundColor(color)
        } else {
            Text(verbatim: verbatim)
                .multilineTextAlignment(alignment)
                .font(.custom("Montserrat-Regular", size: 14))
                .foregroundColor(color)
        }
    }
}

#Preview {
    VStack{
        TextBody(text: "This is a body")
        Divider()
        TextBody(text: "This is a long body, with large text to check the multiline, including extra text to make check")
    }
    .background(Color.background)
}
