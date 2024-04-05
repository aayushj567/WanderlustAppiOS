//
//  AddContactViewController.swift
//  WA5-Komanduri-3452
//
//  Created by Kaushik Komanduri on 2/10/24.
//

import UIKit
import PhotosUI

class AddContactViewController: UIViewController, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    
    let addContactView = AddContactView()
    var selectedType:String? = "Home"
    var isEdit:Bool?=false
    var delegate:ViewController!
    var delegateshow:ShowContactViewController!
    var pickedImage:UIImage?
    var contacts = [Contact]()
    var currentid:Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = addContactView
        if let isedit = isEdit {
            if isedit {
                title = "Edit"
            }else{
                title = "Add Contact"
            }
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        addContactView.buttonSelectType.menu = getMenuTypes()
        addContactView.buttonTakePhoto.menu = getMenuImagePicker()
        addContactView.buttonTakePhoto.setImage(pickedImage?.withRenderingMode(.alwaysOriginal) ?? UIImage(systemName: "photo.fill"), for: .normal)
        addContactView.saveButton.addTarget(self, action: #selector(onAddButtonTapped), for: .touchUpInside)
    }
    
    @objc func onAddButtonTapped(){
        
        let name = addContactView.textFieldName.text
        let email = addContactView.textFieldEmail.text
        let phone = addContactView.textFieldPhone.text
        let city = addContactView.textFieldCity.text
        let address = addContactView.textFieldAddress.text
        let zip = addContactView.textFieldZip.text
        
        
        
        if let unwrappedName = name{
            if let unwrappedEmail = email {
                if let unwrappedPhone = phone {
                    if let unwrappedCity = city{
                        if let unwrappedAddress = address{
                            if let unwrappedZip = zip{
                                //if the message is not empty...
                                if !unwrappedName.isEmpty && !unwrappedEmail.isEmpty && !unwrappedZip.isEmpty && !unwrappedPhone.isEmpty && !unwrappedAddress.isEmpty && !unwrappedCity.isEmpty{
                                    
                                    if !isValidEmail(unwrappedEmail) {
                                        showAlertText(text: "Email not valid")
                                    }
                                    else if !isValidZip(unwrappedZip) {
                                        showAlertText(text: "Zip Code not valid")
                                    }
                                    else if !isValidPhone(unwrappedPhone) {
                                        showAlertText(text: "Phone Number not valid")
                                    }
                                    else {
                                        if let isedit = isEdit {
                                            if isedit {
                                                if let unwrappedId = currentid, let unwrappedType = selectedType{
                                                    delegateshow.delegateOnEditContact(idVal: unwrappedId, newName: unwrappedName, newEmail: unwrappedEmail, newPhone:unwrappedPhone, newAddress:unwrappedAddress, newCity:unwrappedCity, newZip:unwrappedZip, newType: unwrappedType, newImage: pickedImage ?? (UIImage(systemName: "photo.fill"))!)
                                                }
                                            }else{
                                                
                                                let newContact = Contact(id: contacts.count, name: name, email: email, phone:phone, address:address, city:city, zip:zip, type: selectedType, image: pickedImage ?? (UIImage(systemName: "photo.fill"))!)
                                                delegate.delegateOnAddContact(contact: newContact)
                                            }
                                        }
                                        
                                        navigationController?.popViewController(animated: true)
                                    }
                                }else{
                                    showAlertText(text: "One or more fields are empty")
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getMenuTypes() -> UIMenu{
        var menuItems = [UIAction]()
        
        for type in Utilities.types{
            let menuItem = UIAction(title: type,handler: {(_) in
                self.selectedType = type
                self.addContactView.buttonSelectType.setTitle(self.selectedType, for: .normal)
            })
            menuItems.append(menuItem)
        }
        
        return UIMenu(title: "Select type", children: menuItems)
    }
    
    func getMenuImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    
    
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    func showAlertText(text:String){
        let alert = UIAlertController(
            title:"Alert!!!",
            message: "\(text)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title:"OK", style: .default))
        
        self.present(alert, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidZip (_ zip: String) -> Bool {
        if(zip.count == 5){
            if let intvalue = Int(zip){
                if intvalue > 0 && intvalue < 99951 {
                    return true
                }
            }
            return false
        }
        return false
    }
    
    func isValidPhone (_ phone: String) -> Bool {
        if(phone.count == 10){
            if Int(phone) != nil {
                return true
            }
        }
        return false
    }
    
}

extension AddContactViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Utilities.types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        selectedType = Utilities.types[row]
        return Utilities.types[row]
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let uwImage = image as? UIImage{
                            self.addContactView.buttonTakePhoto.setImage(
                                uwImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedImage = uwImage
                        }
                    }
                })
            }
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage{
            self.addContactView.buttonTakePhoto.setImage(
                image.withRenderingMode(.alwaysOriginal),
                for: .normal
            )
            self.pickedImage = image
        }else{
        }
    }
    
}
