//
//  TextTitle.swift
//  WeatherApp
//
//  Created by Alejandro Fernandez Ruiz on 12/11/24.
//

import SwiftUI

struct TextTitle: View {
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
                .font(.custom("Montserrat-SemiBold", size: 28))
                .foregroundColor(color)
        } else {
            Text(verbatim: verbatim)
                .multilineTextAlignment(alignment)
                .font(.custom("Montserrat-SemiBold", size: 28))
                .foregroundColor(color)
        }

    }
}

#Preview {
    VStack{
        TextTitle(text: "This is a title")
        Divider()
        TextTitle(text: "This is a long title, with large text to check the multiline")
    }
    .background(Color.background)
}
