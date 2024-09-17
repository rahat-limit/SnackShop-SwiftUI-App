//
//  SignUpView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 12.09.2024.
//

import SwiftUI

struct SignUpView: View {
    @State var emailController = ""
    @State var passwordController = ""
    @State var confirmPasswordController = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel : AuthViewModelImpl
    @EnvironmentObject var appLoadingManager : AppLoadingManager
    
    func signUp() async {
        guard ValidationHelper().isValid(values: [emailController, passwordController, confirmPasswordController]) else {return}
        
        guard passwordController == confirmPasswordController else {return}
        
        await authViewModel.signUp(email: emailController, password: passwordController)
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack(alignment: .center) {
                    AuthHeadlineView(title: "Sign Up")
                        .padding()
                    CustomTextFieldView(placeholder: "Email", text: $emailController, isSecure: false)
                        .padding(.horizontal)
                    CustomTextFieldView(placeholder: "Password", text: $passwordController, isSecure: true)
                        .padding(.horizontal)
                    CustomTextFieldView(placeholder: "Confirm Password", text: $confirmPasswordController, isSecure: true)
                        .padding(.horizontal)
                    ExpandedButtonView(text: "Sign Up", action: {
                        Task {
                            await signUp()
                        }
                    })
                    AuthLinkButtonView(text: "sign in",action: {
                        dismiss()
                    }).padding()
                    
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
    SignUpView()
}
