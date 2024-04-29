//
//  RegistrationController.swift
//  twitter-app-clone
//
//  Created by Gino Franks Rubio Pacheco on 25/01/23.
//

import Foundation
import UIKit

class RegistrationController: UIViewController{
    
    //MARK: - Properties
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "plus_photo")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Full Name")
        return tf
    }()
    
    private let usernameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Username")
        return tf
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textfield: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textfield: passwordTextField)
        return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textfield: fullNameTextField)
        return view
    }()
    
    private lazy var usernameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textfield: usernameTextField)
        return view
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account", " Login")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    // MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    //MARK: -Selectors
    @objc func handlePlusPhoto(){
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleRegistration(){
        guard let profileImage = profileImage else {
            print("Debug: Please select a profile image")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = usernameTextField.text else{ return }
        guard let fullname = fullNameTextField.text else { return }
        
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        
        AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
            print("Debug: Successfully sign up")
        }

    }
    
    @objc func handleShowLogin(){
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: -Helpers
    
    func configureUI(){
        self.view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        
        let stack = UIStackView(arrangedSubviews: [ emailContainerView, passwordContainerView, fullnameContainerView, usernameContainerView, registrationButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        self.view.addSubview(stack)
        
        stack.anchor(top: plusPhotoButton.bottomAnchor, 
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingLeft: 32,
                     paddingRight: 32)
        
        
        self.view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor,
                                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        right: view.rightAnchor,
                                        paddingLeft: 40, paddingRight: 40)
        
    }
    
}

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {
            return
        }
        
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 128/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true)
    }
}


@available(iOS 17.0, *)
#Preview {
    return RegistrationController()
    
}
