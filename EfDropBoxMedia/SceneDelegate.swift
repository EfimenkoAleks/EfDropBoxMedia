//
//  SceneDelegate.swift
//  EfDropBoxMedia
//
//  Created by user on 04.09.2023.
//

import UIKit
import SwiftyDropbox

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let preferences: PreferencesProtocol = Preferences()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = (scene as? UIWindowScene) else { return }
          
        window = UIWindow(windowScene: windowScene)
        
        if (preferences.getAccessToken()) != nil {
            let navigController = UINavigationController()
            var firstCoordinator: ListCoordinatorProtocol = ListCoordinator()
            firstCoordinator.navigationController = navigController
            firstCoordinator.start()
            window?.rootViewController = firstCoordinator.navigationController
        } else {
            let vc: UIViewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: vc)
            window?.rootViewController = navigationController
        }
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        let oauthCompletion: DropboxOAuthCompletion = { [weak self] in
            if let authResult = $0 {
                switch authResult {
                case .success:
                    
                    let navigController = UINavigationController()
                    var firstCoordinator: ListCoordinatorProtocol = ListCoordinator()
                    firstCoordinator.navigationController = navigController
                    firstCoordinator.start()
                    self?.window?.rootViewController = firstCoordinator.navigationController
                    
                    print("Success! User is logged into DropboxClientsManager.")
                case .cancel:
                    print("Authorization flow was manually canceled by user!")
                case .error(_, let description):
                    print("Error: \(String(describing: description))")
                }
            }
        }
        
        for context in URLContexts {
            if DropboxClientsManager.handleRedirectURL(context.url, completion: oauthCompletion) { break }
        }
        let dictToken = DropboxOAuthManager.sharedOAuthManager.getFirstAccessToken()
        preferences.saveAccessToken(dictToken?.accessToken ?? "")
        preferences.saveRefreshToken(dictToken?.refreshToken ?? "")
    }
 
    func getQueryStringParameter(url: String, param: String) -> String {
        guard let url = URLComponents(string: url) else { return "" }
        let parameter: String = url.queryItems?.first(where: { $0.name == param })?.value ?? ""
        return parameter
    }
}
