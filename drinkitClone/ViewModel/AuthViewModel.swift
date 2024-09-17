//
//  AuthViewModel.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 12.09.2024.
//

import Foundation
import FirebaseAuth
import UIKit

protocol AuthViewModel {
    func signIn(email: String, password: String) async
    func signUp(email: String, password: String) async
    func signOut() async
    func getAuthenticatedUser() async -> User?
    func loadAuthenticatedUser() async
    func changePhoto(image: UIImage?) async
}

@MainActor
final class AuthViewModelImpl : ObservableObject, AuthViewModel {
    let authManager = AuthManagerImpl()
    let firestoreManager : FirestoreManagerImpl
    let errorManager : ErrorManager
    let appLoadingManager : AppLoadingManager
    let storageManager = StorageManager()
    
    @Published private(set) var myUser : User?
    @Published private(set) var userAvatar : String?
    
    
    //    private var cancellables = Set<AnyCancellable>()
    init(firestoreManager : FirestoreManagerImpl, errorManager : ErrorManager, appLoadingManager: AppLoadingManager) {
        self.firestoreManager = firestoreManager
        self.errorManager = errorManager
        self.appLoadingManager = appLoadingManager
        Task {
            await loadAuthenticatedUser()
            await getUserAvatar()
        }
    }
    
    
    
    func signIn(email: String, password: String) async {
        do {
            appLoadingManager.startLoading()
            try await authManager.signInUser(email: email, password: password) { result in
                switch result {
                case .failure(.failure(let error)):
                    self.errorManager.showError(error)
                case .success(.success(let user)):
                    self.myUser = user
                }
            }
            appLoadingManager.stopLoading()
        } catch {
            appLoadingManager.stopLoading()
            self.errorManager.showError(error.localizedDescription)
        }
    }
    
    func signUp(email: String, password: String) async {
        do {
            appLoadingManager.startLoading()
            try await authManager.signUpUser(email: email, password: password) { result in
                switch result {
                case .failure(.failure(let error)):
                    self.appLoadingManager.stopLoading()
                    self.errorManager.showError(error)
                case .success(.success(let user)):
                    let data = [
                        "email": user.email,
                        "name": user.displayName
                    ]
                    self.firestoreManager.setData(collection: "users", document: user.uid, data: data as [String : Any]) { status in
                        switch (status) {
                        case .failure(.failure(let error)):
                            self.errorManager.showError(error)
                        case .success(.success(let success)):
                            print(success)
                            self.myUser = user
                        }
                    }
                    self.appLoadingManager.stopLoading()
                }
                
            }
        } catch {
            appLoadingManager.stopLoading()
            self.errorManager.showError(error.localizedDescription)
        }
    }
    
    func signOut() async {
        do {
            appLoadingManager.startLoading()
            myUser = nil
            try authManager.logout()
            appLoadingManager.stopLoading()
        } catch {
            appLoadingManager.stopLoading()
            self.errorManager.showError(error.localizedDescription)
        }
    }
    
    func getAuthenticatedUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func loadAuthenticatedUser() async {
        if let user = getAuthenticatedUser() {
            self.myUser = user
        } else {
            self.errorManager.showError("No authenticated user found.")
        }
    }
    
    func getUserAvatar() async {
        guard myUser != nil else {return}
        self.firestoreManager.getDocument(collection: "users", document: myUser!.uid) {result in
            switch result {
            case .failure(.failure(let error)):
                self.errorManager.showError(error)
            case .success(.success(let data)):
                let img = data["imageUrl"] as? String
                if let image = img {
                    print("imageurl: \(image)")
                    self.userAvatar = image
                }
            }
        }
    }
    
    func changePhoto(image: UIImage?) {
        guard myUser != nil else {return}
        appLoadingManager.startLoading()
        storageManager.setImageToFirebaseStorage(image: image, path: myUser?.uid) { result in
            switch result {
            case .failure(.faiure(let message)):
                self.errorManager.showError(message)
                self.appLoadingManager.stopLoading()
            case .success(let imageUrl):
                let data = [
                    "imageUrl": imageUrl
                ] as [String: Any]
                self.firestoreManager.addData(collection: "users", document: self.myUser?.uid ?? "", data: data) { status in
                    switch (status) {
                        
                    case .failure(.failure(let error)):
                        self.errorManager.showError(error)
                    case .success(.success( _)):
                        self.userAvatar = imageUrl
                    }
                    self.appLoadingManager.stopLoading()
                }
            }
        }
        
    }
}
