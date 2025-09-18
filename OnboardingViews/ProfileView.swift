import SwiftUI

struct ProfileView: View {
    @AppStorage("name") private var storedName: String = ""
    @AppStorage("age") private var storedAge: Int = 18
    @AppStorage("gender") private var storedGender: String = ""
    @AppStorage("signed_in") private var signedIn: Bool = false

    var body: some View {
        VStack(spacing: 18) {
            Spacer(minLength: 32)

            // Avatar
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [Color.white.opacity(0.15), Color.white.opacity(0.08)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 160, height: 160)
                    .shadow(radius: 8)

                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                    .foregroundColor(.white.opacity(0.95))
            }

            // Details
            VStack(spacing: 6) {
                Text(storedName.isEmpty ? "Your name here" : storedName)
                    .font(.title2).bold()
                    .foregroundColor(.white)

                Text("Age: \(storedAge)")
                    .foregroundColor(.white.opacity(0.9))

                Text("Gender: \(storedGender.isEmpty ? "Unknown" : storedGender)")
                    .foregroundColor(.white.opacity(0.9))
            }
            .padding(.top, 8)

            Spacer()

            // Sign out
            Button {
                withAnimation(.spring()) {
                    signedIn = false
                }
            } label: {
                Text("Sign Out")
                    .font(.headline)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
                    .shadow(radius: 6)
            }

            Spacer(minLength: 24)
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView()
                .previewDisplayName("Profile")
            
                .background(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                            Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
                        ]),
                        center: .center,
                        startRadius: 100,
                        endRadius: UIScreen.main.bounds.height
                    )
                )
        }
    }
}
