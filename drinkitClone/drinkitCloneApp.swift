import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct drinkitCloneApp: App {
    let persistenceController = PersistenceController.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // Use @StateObject to manage view model lifecycle
    @StateObject private var authViewModel = AuthViewModelImpl(firestoreManager: FirestoreManagerImpl(), errorManager: ErrorManager.shared, appLoadingManager: AppLoadingManager.shared)
    @StateObject var appLoadingManager = AppLoadingManager.shared
    @StateObject var errorManager = ErrorManager.shared
    
    
    
    var body: some Scene {
        WindowGroup {
            AuthDividerView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(ProductViewModelImpl())
                .environmentObject(authViewModel)
                .environmentObject(errorManager)
                .environmentObject(appLoadingManager)
        }
    }
}
