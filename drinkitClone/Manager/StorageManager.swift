//
//  StorageManager.swift
//  drinkitClone
//
//  Created by Rakhat Cyanid on 12.09.2024.
//

import SwiftUI
import FirebaseStorage

enum StorageManagerError: Error {
    case faiure(String)
}

class StorageManager {
    //    func fetchImagesFromFirebaseStorage() {
    //        let storage = Storage.storage()
    //        // change "landmarks" by your folder name
    //        let storageRef = storage.reference().child("avatars")
    //        storageRef.listAll { (result, error) in
    //            if let error = error {
    //                    print("Error while listing all files: ", error)
    //            }
    //
    //            if let items = result?.items {
    //                for item in items {
    //
    //                    print("Item in images folder: ", item)
    //                    item.downloadURL { url, error in
    //                        if let url = url {
    //                            self.imageURLs.append(url)
    //                        } else if let error = error {
    //                            print("Error getting download URL: \(error.localizedDescription)")
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
    func setImageToFirebaseStorage(image : UIImage?, path: String?, completion: @escaping (Result<String, StorageManagerError>) -> Void) {
        guard let imageData = image?.jpegData(compressionQuality: 0.8) else {
            return completion(.failure(.faiure("Converting Error appeard")))
        }
        let storage = Storage.storage()
        let storageRef = storage.reference().child("avatars/\(path ?? UUID().uuidString).jpg")
        
        let uploadTask = storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(.failure(.faiure("Error uploading image: \(error.localizedDescription)")))
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    
                    completion(.failure(.faiure("Error getting download URL: \(error.localizedDescription)")))
                } else if let downloadURL = url {
                    print("Download URL: \(downloadURL.absoluteString)")
                    completion(.success(downloadURL.absoluteString))
                    
                }
            }
        }
    }
}
