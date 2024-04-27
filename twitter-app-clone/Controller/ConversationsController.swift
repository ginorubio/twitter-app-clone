//
//  ConversationsController.swift
//  twitter-app-clone
//
//  Created by Gino Franks Rubio Pacheco on 3/12/22.
//

import Foundation
import UIKit

class ConversationsController: UIViewController{
    // MARK: -Properties
    
    // MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    //MARK: -Helpers
    func configureUI(){
        self.view.backgroundColor = .white
        self.navigationItem.title = "Messages"
    }
}
