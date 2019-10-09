//
//  CameraState.swift
//  HotdogNotHotdog
//
//  Created by Kudakwashe Chambwe on 08/10/2019.
//  Copyright © 2019 Bouvet Norge AS. All rights reserved.
//

import SwiftUI
import Combine
import CoreML
import Vision
import ImageIO

class CameraState: ObservableObject {
    
    // Tells views that the object has changed.
    var objectWillChange = ObservableObjectPublisher()
    
    // Notifies views that object is changing.
    var isTakingPhoto = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    var hotDogPhoto: UIImage? = nil {
        willSet {
            objectWillChange.send()
        } 
        didSet {
            if hotDogPhoto != nil {
                showResult = false
                updateClassification(image: hotDogPhoto!)
            }
        }
    }
    
    var isHotDog = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    var showResult = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    
    // Process classification on the main thread.
    func processClasification(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                return
            }
            
            let classifications = results as! [VNClassificationObservation]
            // In case we get nothing back.
            if classifications.isEmpty {
                withAnimation {
                    self.showResult = false
                    self.isHotDog = false
                }
            } else {
                // String describing what the object is.
                let identifier = classifications[0].identifier
                withAnimation {
                    self.isHotDog = identifier.contains("hotdog")
                    self.showResult = true
                }
            }
        }
    }
    
    // Delays the processing of this until the first time used.
    lazy var classificationRequest: VNRequest = {
        do {
            let model = try VNCoreMLModel(for: Resnet50().model)
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.processClasification(for: request, error: error)
            })
            return request
        } catch {
            fatalError("Error importing model")
        }
    }()
    
    // Function for updating the classificationa above -- in BG thread.
    func updateClassification(image: UIImage) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let handler = VNImageRequestHandler(ciImage: CIImage(image: image)!)
                try handler.perform([self.classificationRequest])
            } catch {
                fatalError("Error updating classification")
            }
        }
    }
    
}
