//
//  FeedController.swift
//  twitter-app-clone
//
//  Created by Gino Franks Rubio Pacheco on 3/12/22.
//

import Foundation
import UIKit

class FeedController: UIViewController{
    // MARK: -Properties
    

    // MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: -Helpers
    func configureUI(){
        self.view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
}
