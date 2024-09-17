//
//  SignInView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 12.09.2024.
//

import SwiftUI

struct SignInView: View {
    @State var emailController = ""
    @State var passwordController = ""
    @State private var navigationValue: Bool = false
    @EnvironmentObject var authViewModel : AuthViewModelImpl
    @EnvironmentObject var appLoadingManager : AppLoadingManager
    
    func signIn() async {
        guard ValidationHelper().isValid(values: [emailController, passwordController]) else {return}
        await authViewModel.signIn(email: emailController, password: passwordController)
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack(alignment: .center) {
                    AuthHeadlineView()
                        .padding()
                    CustomTextFieldView(placeholder: "Email", text: $emailController, isSecure: false)
                        .padding(.horizontal)
                    CustomTextFieldView(placeholder: "Password", text: $passwordController, isSecure: true)
                        .padding(.horizontal)
                    ExpandedButtonView(text: "Sign In", action: {
                        Task {
                            await signIn()
                        }
                    })
                    AuthLinkButtonView(text: "sign up",action: {
                        navigationValue = true
                    }).padding()
                    NavigationLink(destination: SignUpView().navigationBarBackButtonHidden(), isActive: $navigationValue) {
                        EmptyView()
                    }
                }
            }
            if appLoadingManager.loading {
                Color.black.opacity(0.4) // Полупрозрачный фон для блокировки взаимодействия
                    .ignoresSafeArea() // Игнорируем границы экрана
                VStack {
                    ProgressView("Loading...") // Прогресс-бар
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            }
        }
        
    }
}

#Preview {
    SignInView()
}
