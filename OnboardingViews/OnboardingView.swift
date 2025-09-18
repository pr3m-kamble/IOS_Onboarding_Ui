//
//  OnboardingView.swift
//  SwiftUiBootcamp
//
//  Created by Prem kamble on 14/09/25.
//

import SwiftUI

struct OnboardingView: View {
    // Onboadring State
    /*
    0 - Wellcome Screen
     1 - Add name
     2 - Add age
     3 - Add gender
     
     */
    @State var onboardingState: Int = 0
    let transaction: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    // onboarding inputs
    @State var name: String = ""
    @State var age: Double = 50
    @State var gender: String = ""
   
    // for alert
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    // app storage
    @AppStorage("name") var currentUsername: String?
    @AppStorage("age") var currentAge: Int?
    @AppStorage("gender") var currentGender: String?
    @AppStorage("signed_in") var currentUsereSignetIn: Bool = false

    
    var body: some View {
        ZStack{
            // content
            ZStack{
                switch onboardingState {
                case 0:
                    welcomesection
                        .transition(transaction)
                case 1:
                    addNameSection
                        .transition(transaction)
                case 2:
                    addAgeSection
                        .transition(transaction)
                case 3:
                    addGenderSection
                        .transition(transaction)
                   
                default:
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(.green)
                       
                }
            }
            
            // buttons
            VStack{
                Spacer()
                bottomButton
                    }
            .padding(30)
            }
        .alert(isPresented: $showAlert, content: {
            return Alert(title: Text(alertTitle))
        })
        }
      
        
    }
    
    
    


#Preview {
    OnboardingView()
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
//MARK: COMPONENETS
extension OnboardingView {
    private var bottomButton: some View {
        VStack {
            Text(onboardingState == 0 ? "SIGN UP" :
                 onboardingState == 3 ? "FINISH" : "NEXT")
                .font(.headline)
                .foregroundStyle(.black)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(10)
                .onTapGesture {
                    withAnimation(nil) {
                        // state change without animation
                        handleNextButtonPressed()
                    }
                }
        }
    }

    private var welcomesection: some View {
        VStack(spacing: 40){
            Spacer()
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit( )
                .frame(width: 200, height: 200)
                .foregroundStyle(.white)
            Text("Find Your match.")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .overlay(
                    Capsule(style: .continuous)
                        .frame(height:3)
                        .offset(y: 5)
                        .foregroundStyle(.white)
                    , alignment: .bottom
                )
            Text("This is the #1 app for finding your match online! In this app you can find your match based on your preferences. Just search for your match and start chatting!")
                .fontWeight(.medium)
                .foregroundStyle(.white)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(15)
        
    }
    
    private var addNameSection: some View {
        VStack(spacing: 40){
            Spacer()
           
            Text("What's your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            TextField("Your name here...", text: $name)
                .font(.headline)
                .frame(height: 55)
                .padding(.horizontal)
                .background(.white)
                .cornerRadius(10)
                
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(15)
        
        
    }
    
    private var addAgeSection: some View {
        VStack(spacing: 40){
            Spacer()
           
            Text("What's your name?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
          
            Text("\(  String(format: "%.0f", age))")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                
            Slider(value: $age, in: 18...50, step: 1)
                .accentColor(.white)
      
                
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(15)
    }
    
    private var addGenderSection: some View {
        VStack(spacing: 40){
            Spacer()
           
            Text("What's your Gender?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
          
            VStack {
//                Text("Select Gender")
//                    .font(.headline)
//                    .foregroundStyle(.white)

              
//                Picker(selection: $gender,
//                       label:
//                        Text(gender.isEmpty ? "Select Gender" : gender)
//                            .foregroundColor(gender.isEmpty ? .gray : .black) // placeholder gray, selected black
//                            .frame(maxWidth: .infinity, minHeight: 55)
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            .padding(.horizontal)
//                ) {
//                    Text("Male").tag("Male")
//                    Text("Female").tag("Female")
//                    Text("Non-Binary").tag("Non-Binary")
//                }
//                .pickerStyle(MenuPickerStyle())
//                .tint(.white)// iOS 15/16: preferred
                Menu {
                    Button("Male") { gender = "Male" }
                    Button("Female") { gender = "Female" }
                    Button("Non-Binary") { gender = "Non-Binary" }
                } label: {
                    Text(gender.isEmpty ? "Select Gender" : gender)
                        .foregroundColor(gender.isEmpty ? .gray : .black)
                        .frame(maxWidth: .infinity, minHeight: 55)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

            }

                
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(15)
    }
    }


// MARK: FUNCTION
extension OnboardingView {
    
    func handleNextButtonPressed() {
        // check inputes
        switch onboardingState{
        case 1:
            guard name.count >= 3 else {
               showAlerts(title: "Your name must be at least 3 characters long! 😩")
                return
            }
        case 3:
            guard gender.count > 1 else {
                showAlerts(title: "Please select your gender before moving forward 😳")
                 return
            }
        default:
            break
        }
        
        if onboardingState == 3 {
               signIn()
        }
        else{
            withAnimation(.spring()) {
                
                onboardingState += 1
        }
        
       
        }
        
    }
     
    func signIn() {
        
        currentUsername = name
        currentAge = Int(age)
        currentGender = gender
        withAnimation(.spring()){
            currentUsereSignetIn = true
        }
    }
    
    func showAlerts(title: String) {
        alertTitle = title
        
        showAlert.toggle()
    }
    
}
