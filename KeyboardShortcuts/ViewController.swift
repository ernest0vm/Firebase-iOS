//
//  ViewController.swift
//  KeyboardShortcuts
//
//  Created by Ernesto Valdez on 9/3/19.
//  Copyright © 2019 Ernesto Valdez. All rights reserved.
//

import UIKit
import Photos
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var lblAllKeys: UILabel!
    @IBOutlet weak var txtShortcutName: UITextField!
    @IBOutlet weak var txtKeys: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    var DBReference: DatabaseReference!
    var STReference: StorageReference!
    var picker = UIImagePickerController()
    var shortcut = Shortcut()
    var imageLocalURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        DBReference = Database.database().reference()
        STReference = Storage.storage().reference()
    }
    
    @IBAction func onBtnAddKeyClick(_ sender: UIButton, forEvent event: UIEvent) {
        
        let key: NSString = txtKeys.text! as NSString
        
        shortcut.Keys.append(key)
        lblAllKeys.text = lblAllKeys.text! + txtKeys.text! + " "
        txtKeys.text = ""
        
    }
    
    @IBAction func onBtnSaveShortcutClicked(_ sender: UIButton, forEvent event: UIEvent) {
        
        let name:NSString = txtShortcutName.text! as NSString
        shortcut.ShortcutName = name
        
        if imageLocalURL != nil {
            // File located on disk
            let localFile = URL(string: imageLocalURL!)!
            
            let getName = imageLocalURL?.components(separatedBy: "/")
            
            // Create a reference to the file you want to upload
            let imageRef = STReference.child("images").child(getName!.last!)
            
            // Upload the file to the path "images/image-name.jpg"
            let uploadTask = imageRef.putFile(from: localFile, metadata: nil) { metadata, error in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
                // You can also access to download URL after upload.
                imageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    
                self.shortcut.imageUri = "\(downloadURL)" as NSString
                
                //Save shortcut with image
                self.saveShortcutOnFirebase()
                }
            }
            
            // Add a progress observer to an upload task
            uploadTask.observe(.progress) { snapshot in
                // Upload reported progress
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                    / Double(snapshot.progress!.totalUnitCount)
            }
            
            uploadTask.observe(.success) { snapshot in
                // Upload completed successfully
            }
            
            uploadTask.observe(.failure) { snapshot in
                if let error = snapshot.error as NSError? {
                    switch (StorageErrorCode(rawValue: error.code)!) {
                    case .objectNotFound:
                        // File doesn't exist
                        break
                    case .unauthorized:
                        // User doesn't have permission to access file
                        break
                    case .cancelled:
                        // User canceled the upload
                        break
                    case .unknown:
                        // Unknown error occurred, inspect the server response
                        break
                    default:
                        // A separate error occurred. This is a good place to retry the upload.
                        break
                    }
                }
            }
            
        } else {
            //Save shortcut without image
            saveShortcutOnFirebase()
        }
        
    }
    
    @IBAction func onBtnOpenGalleryClicked(_ sender: UIButton, forEvent event: UIEvent) {
        openGallery()
    }
    
    @IBAction func onBtnOpenCameraClicked(_ sender: UIButton, forEvent event: UIEvent) {
        openCamera()
    }
    
    func saveShortcutOnFirebase(){
        
        print(shortcut.ToString())
        
        //add new object in database
        DBReference.child("root").childByAutoId().setValue(shortcut.ToDictionary())
        
        //clear all data
        txtShortcutName.text = ""
        lblAllKeys.text = ""
        shortcut.Keys = []
        imageView.image = nil
    }
    
    func openGallery()
    {
        checkPermission()
        picker.allowsEditing = false
        picker.mediaTypes = ["public.image"]
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if (UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            present(picker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageURL = info[.imageURL] as? NSURL{
            imageLocalURL = "\(imageURL)"
        }
        
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        @unknown default:
            print("Unknown state of the permission.")
        }
    }
    
}


