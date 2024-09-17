//
//  AuthManager.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 12.09.2024.
//

import Foundation
import FirebaseAuth

enum AuthSuccess {
    case success(User)
}

enum AuthError : Error {
    case failure(String)
}

protocol AuthManager {
    func signUpUser(email: String, password: String, completion: @escaping (Result<AuthSuccess, AuthError>) -> Void) async throws
    func signInUser(email: String, password: String, completion: @escaping (Result<AuthSuccess, AuthError>) -> Void) async throws
    func logout() async throws
}

final class AuthManagerImpl : AuthManager {
    func signUpUser(email: String, password: String, completion: @escaping (Result<AuthSuccess, AuthError>) -> Void) async throws  {
        do {
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            
            completion(.success(.success(authDataResult.user)))
        } catch let error as NSError {
            switch error.code {
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                completion(.failure(.failure("Email is already in use.")))
            case AuthErrorCode.invalidEmail.rawValue:
                completion(.failure(.failure("Invalid email address.")))
            case AuthErrorCode.weakPassword.rawValue:
                completion(.failure(.failure("Password is too weak.")))
            case AuthErrorCode.networkError.rawValue:
                completion(.failure(.failure("Network error. Please try again later.")))
            case AuthErrorCode.wrongPassword.rawValue:
                completion(.failure(.failure("Incorrect Password.")))
            default:
                completion(.failure(.failure(error.localizedDescription)))
            }
        }
    }
    
    func signInUser(email: String, password: String, completion: @escaping (Result<AuthSuccess, AuthError>) -> Void) async throws  {
        
        do {
            let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
            completion(.success(.success(authDataResult.user)))
        } catch let error as NSError {
            print(error)
            switch error.code {
            case AuthErrorCode.emailAlreadyInUse.rawValue:
                completion(.failure(.failure("Email is already in use.")))
            case AuthErrorCode.invalidEmail.rawValue:
                completion(.failure(.failure("Invalid email address.")))
            case AuthErrorCode.weakPassword.rawValue:
                completion(.failure(.failure("Password is too weak.")))
            case AuthErrorCode.networkError.rawValue:
                completion(.failure(.failure("Network error. Please try again later.")))
            case AuthErrorCode.wrongPassword.rawValue:
                completion(.failure(.failure("Incorrect Password.")))
            case AuthErrorCode.userDisabled.rawValue:
                completion(.failure(.failure("User does not exist.")))
            default:
                completion(.failure(.failure(error.localizedDescription)))
            }
        }
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
}
