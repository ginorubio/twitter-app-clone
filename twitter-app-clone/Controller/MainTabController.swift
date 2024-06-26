//
//  MainTabController.swift
//  twitter-app-clone
//
//  Created by Gino Franks Rubio Pacheco on 3/12/22.
//

import Foundation
import UIKit
import Firebase

class MainTabController: UITabBarController{
    // MARK: -Properties
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    // MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        logUserOut()
        view.backgroundColor = .twitterBlue
        authenticateUserAndConfigureUI()
        
    }
    
    //MARK: - API
    
    func fetchUser(){
        UserService.shared.fetchUser()
    }
    func authenticateUserAndConfigureUI(){
        if Auth.auth().currentUser == nil {
            print("DEBUG: User is not logged in..")
            DispatchQueue.main.async {
                let loginVC = LoginController()
                let nav = UINavigationController(rootViewController: loginVC)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }else{
            print("DEBUG: User is logged in..")
            configureUI()
            configureViewControllers()
            fetchUser()
        }
    }
    
    func logUserOut(){
        do{
            try Auth.auth().signOut()
            print("DEBUG: singout successful")
        }catch let error{
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    //MARK: -Selectors
    
    @objc func actionButtonTapped(){
        debugPrint("Taped")
    }
    //MARK: -Helpers
    
    func configureUI(){
        view.addSubview(actionButton)
        actionButton.anchor( bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                             paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56/2
    }
    
    func configureViewControllers(){
        let feed = FeedController()
        let nav1  = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: explore)
        
        let notifications = NotificationsController()
        let nav3 = templateNavigationController(image:  UIImage(named: "like_unselected"), rootViewController: notifications)
        
        let conversations = ConversationsController()
        let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversations)
        
        
        self.viewControllers = [nav1 , nav2, nav3, nav4]
        
    }
    
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.tintColor = .white
        return nav
    }
}
