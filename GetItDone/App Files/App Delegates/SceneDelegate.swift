//
//  SceneDelegate.swift
//  GetItDone
//
//  Created by waheedCodes on 13/03/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let rootViewController = TasksListViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.topItem?.title = "Get It Done"
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

