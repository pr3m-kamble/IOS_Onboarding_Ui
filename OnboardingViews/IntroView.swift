import SwiftUI

struct IntroView: View {
    @AppStorage("signed_in") private var signedIn: Bool = false

    var body: some View {
        ZStack {
            // Background gradient
            RadialGradient(
                gradient: Gradient(colors: [
                    Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                    Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
                ]),
                center: .center,
                startRadius: 100,
                endRadius: UIScreen.main.bounds.height
            )
            .ignoresSafeArea()

            // Switch between onboarding and profile
            if signedIn {
                ProfileView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            } else {
                OnboardingView()
                    .transition(.move(edge: .leading).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: signedIn)
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IntroView()
                .previewDisplayName("Onboarding")
            
        }
    }
}
