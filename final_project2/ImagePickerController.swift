//
//  ImagePickerController.swift
//  final_project2
//
//  Created by 林湘羚 on 2021/1/4.
//

import SwiftUI

struct ImagePickerController: UIViewControllerRepresentable {
    @Binding var showSelectPhoto: Bool
    @Binding var selectImage: Image
    
    func makeCoordinator() -> Coordinator {
        Coordinator(imagePickerController: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        internal init(imagePickerController:ImagePickerController) {
            self.imagePickerController = imagePickerController
        }
        
        let imagePickerController: ImagePickerController
        
        func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey :Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                imagePickerController.selectImage = Image(uiImage:uiImage)
            }
            imagePickerController.showSelectPhoto = false
        }
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = context.coordinator
        return controller
    }
}

//public protocol UIImagePickerControllerDelegate : NSObjectProtocol {
//
//    @available(iOS 2.0, *)
//    optional func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any])
//    @available(iOS 2.0, *)
//    optional func imagePickerControllerDidCancel(_ picker:UIImagePickerController)
//}

