import SwiftUI

struct TextInfo: View {
    private var data: LocalizedStringKey
    private var verbatim: String
    private var alignment: TextAlignment
    private var color: Color
    
    public init(text: LocalizedStringKey, alignment: TextAlignment = .leading, color: Color = .text) {
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
                .font(.custom("Montserrat-Light", size: 12))
                .foregroundColor(color)
        } else {
            Text(verbatim: verbatim)
                .multilineTextAlignment(alignment)
                .font(.custom("Montserrat-Light", size: 12))
                .foregroundColor(color)
        }
    }
}

#Preview {
    VStack{
        TextInfo(text: "This is a info text")
        Divider()
        TextInfo(text: "This is a long info, with large text to check the multiline, including extra text to make check")
    }
    .background(Color.background)
}
