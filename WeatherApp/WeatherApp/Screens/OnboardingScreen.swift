import SwiftUI

struct OnboardingScreen: View {
    @Environment(\.app)
    private var app

    @State private var currentPage: Int = 0

    // Define your pages here
    private let pages: [OnboardingPageView.Model] = [
        OnboardingPageView.Model(
            image: "onboarding1",
            title: String(localized: "onboarding_1_info")
        ),
        OnboardingPageView.Model(
            image: "onboarding2",
            title: String(localized: "onboarding_2_info")
        ),
        OnboardingPageView.Model(
            image: "onboarding3",
            title: String(localized: "onboarding_3_info")
        )
    ]

    private var isLastPage: Bool {
        currentPage == pages.count - 1
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    OnboardingPageView(model: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page)

            VStack(spacing: 12) {
                GenericButton(isLastPage ? "global_done" : "global_continue") {
                    if isLastPage {
                        app.navigation.push(to: .apikey)
                    } else {
                        withAnimation {
                            currentPage += 1
                        }
                    }
                }

                TonalButton("global_skip") {
                    app.navigation.push(to: .apikey)
                }
                .isHidden(isLastPage)
            }
            .padding(.horizontal,36)
            .padding(.vertical, 18)
        }
        .background(Color.background)
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(.black)
            UIPageControl.appearance().pageIndicatorTintColor =
            UIColor(.black)
        }
        .onDisappear {
            UIPageControl.appearance().currentPageIndicatorTintColor = nil
            UIPageControl.appearance().pageIndicatorTintColor = nil
        }
    }
}

#Preview {
    OnboardingScreen()
}
