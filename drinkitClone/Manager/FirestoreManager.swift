import SwiftUI
import FirebaseFirestore

enum FirestoreError: Error {
    case failure(String)
}

enum FirestoreSuccess {
    case success([String: Any])
}

protocol FirestoreManager {
    // Add a completion handler that returns a Result type
    func setData(collection: String, document: String, data: [String: Any], completion: @escaping (Result<FirestoreSuccess, FirestoreError>) -> Void)
    func addData(collection: String, document: String, data: [String: Any], completion: @escaping (Result<FirestoreSuccess, FirestoreError>) -> Void)
    func getDocument(collection: String, document: String, completion: @escaping (Result<FirestoreSuccess, FirestoreError>) -> Void)
}

final class FirestoreManagerImpl: FirestoreManager {
    let firestoreDB = Firestore.firestore()
    
    func setData(collection: String, document: String, data: [String: Any], completion: @escaping (Result<FirestoreSuccess, FirestoreError>) -> Void) {
        let docRef = firestoreDB.collection(collection).document(document)
        
        docRef.setData(data) { error in
            if let error = error {
                // If there is an error, return failure
                completion(.failure(.failure("Error adding document: \(error.localizedDescription)")))
            } else {
                // On success, return success along with the data that was set
                completion(.success(.success(data)))
            }
        }
    }
    
    func addData(collection: String,document: String, data: [String: Any], completion: @escaping (Result<FirestoreSuccess, FirestoreError>) -> Void) {
        firestoreDB.collection(collection).document(document).updateData(data) { error in
                if let error = error {
                    completion(.failure(.failure("Error adding document: \(error.localizedDescription)")))
                } else {
                    completion(.success(.success(data)))
                }
            }
        }
    
    func getDocument(collection: String, document: String, completion: @escaping (Result<FirestoreSuccess, FirestoreError>) -> Void) {
            let docRef = firestoreDB.collection(collection).document(document)
            
            docRef.getDocument { (documentSnapshot, error) in
                if let error = error {
                    completion(.failure(.failure("Error fetching document: \(error.localizedDescription)")))
                    return
                }
                
                if let documentSnapshot = documentSnapshot, documentSnapshot.exists, let data = documentSnapshot.data() {
                    completion(.success(.success(data)))
                } else {
                    completion(.failure(.failure("Document does not exist")))
                }
            }
        }
}
