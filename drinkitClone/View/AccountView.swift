//
//  AccountView.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 11.09.2024.
//

import SwiftUI
import Photos
import _PhotosUI_SwiftUI

struct AccountView: View {
    @EnvironmentObject var authViewModel : AuthViewModelImpl
    @State private var avatarImage: Image?
    @State var signOutButtonClicked = false
    @State private var avatarItem: PhotosPickerItem?
    var body: some View {
        
        NavigationStack {
            VStack {
                
                if let image = authViewModel.userAvatar {
                    AsyncImage(url: URL(string: image)) {img in
                        img.image?.resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    }
                    PhotosPicker(selection: $avatarItem, matching: .images) {
                        Text("Pick an Image")
                            .padding(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 15).stroke()
                            }
                    }
                } else if let selectAvatarImage = avatarImage {
                    avatarImage?
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    PhotosPicker(selection: $avatarItem, matching: .images) {
                        if avatarImage == nil {
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 100, height: 100)
                                .overlay(
                                    Image(systemName: "person")
                                        .foregroundColor(.white)
                                        .font(.system(size: 40))
                                )
                        }
                    }
                    
                }
                Text(authViewModel.myUser?.email ?? "No Name")
                    .font(.title)
                    .fontWeight(.bold)
                ExpandedButtonView(action: {
                    Task {
                        await authViewModel.signOut()
                    }
                })
            }.onChange(of: avatarItem) {
                Task {
                    // Загружаем изображение как `UIImage`
                    if let data = try? await avatarItem?.loadTransferable(type: Data.self), let uiImage = UIImage(data: data) {
                        avatarImage = Image(uiImage: uiImage)
                        authViewModel.changePhoto(image: uiImage)
                    } else {
                        print("Failed to load image.")
                    }
                }
            }
            
            
        }
        
    }
}

#Preview {
    AccountView()
        .environmentObject(AuthViewModelImpl(firestoreManager: FirestoreManagerImpl(), errorManager: ErrorManager.shared, appLoadingManager: AppLoadingManager.shared))
}
