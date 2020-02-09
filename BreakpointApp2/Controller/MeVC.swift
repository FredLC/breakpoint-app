//
//  MeVC.swift
//  BreakpointApp2
//
//  Created by Fred Lefevre on 2019-12-16.
//  Copyright © 2019 Fred Lefevre. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class MeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var messagesArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImage)))
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllMessages(fromCurrentUser: Auth.auth().currentUser!.uid) { (returnedMessages) in
            self.messagesArray = returnedMessages
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLabel.text = Auth.auth().currentUser?.email
        DataService.instance.getProfilePictureUrl(forUID: Auth.auth().currentUser!.uid) { (returnedImageUrl) in
            let imageString = returnedImageUrl
            let imageUrl = URL(string: imageString)
            let placeholder = UIImage(named: "defaultProfileImage")
            self.profileImage.kf.setImage(with: imageUrl, placeholder: placeholder)
        }
    }
    
    @objc func handleSelectProfileImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImage.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        guard let data = profileImage.image?.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        let imageName = UUID().uuidString
        let imageReference = Storage.storage().reference().child(imageName)
        
        imageReference.putData(data, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            
            imageReference.downloadURL(completion: { (url, error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                    return
                }
                
                guard let url = url else { return }
                let urlString = url.absoluteString
                let dataReference = Firestore.firestore().collection("imagesCollection").document()
                let documentId = dataReference.documentID
                let data = [
                    "uid": documentId,
                    "imageUrl": urlString
                ]
                
                dataReference.setData(data, completion: { (error) in
                    if error != nil {
                        print(error?.localizedDescription as Any)
                        return
                    }
                    print("Successfully saved image to database")
                    DataService.instance.REF_USERS.child(Auth.auth().currentUser!.uid).updateChildValues(["profileImageUrl": urlString])
                })
            })
        }
        
    }

    @IBAction func logoutButtonPressed(_ sender: Any) {
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            do {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
        logoutPopup.addAction(logoutAction)
        present(logoutPopup, animated: true, completion: nil)
    }
    
    
}

extension MeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "meVCPostCell", for: indexPath) as? MeVCPostCell else { return UITableViewCell() }
        let message = messagesArray[indexPath.row]
        guard let email = Auth.auth().currentUser?.email else { return UITableViewCell() }
        cell.configureCell(email: email, post: message.content)
        return cell
    }
    
    
}
