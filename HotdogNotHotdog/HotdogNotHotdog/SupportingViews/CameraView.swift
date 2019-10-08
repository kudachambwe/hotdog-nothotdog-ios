//
//  CameraView.swift
//  HotdogNotHotdog
//
//  Created by Kudakwashe Chambwe on 08/10/2019.
//  Copyright © 2019 Bouvet Norge AS. All rights reserved.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    @ObservedObject var cameraState: CameraState
    var coordinator: Coordinator!
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> UIImagePickerController {
        return UIImagePickerController()
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraView>) {
        uiViewController.mediaTypes = ["public.image"]
        uiViewController.delegate = context.coordinator
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            uiViewController.sourceType = .camera
        } else {
            uiViewController.sourceType = .photoLibrary
        }
    }
    
    func makeCoordinator() -> CameraView.Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraView
        
        init(_ cameraView: CameraView) {
            parent = cameraView
        }
        
        // If user cancels ImagePicker:
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.cameraState.hotDogPhoto = nil
            withAnimation {
                parent.cameraState.isTakingPhoto = false
            }
        }
        
        // Logic for picking the image in ImagePicker:
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
            if let image = info[.originalImage] as? UIImage {
                parent.cameraState.hotDogPhoto = image
            } else {
                parent.cameraState.hotDogPhoto = nil
            }
            
            // Close the ImagePicker in the end -- with animation.
            withAnimation {
             parent.cameraState.isTakingPhoto = false
            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(cameraState: CameraState())
    }
}
