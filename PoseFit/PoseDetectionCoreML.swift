//
//  PoseDetectionCoreML.swift
//  PoseFit
//
//  Created by Kiss Roland on 05/02/2024.
//


import Foundation
import MLKitPoseDetectionAccurate
import MLKitPoseDetection
import MLKit
import TensorFlowLite

class PoseDetectionCoreML: ObservableObject {
   
       var detectionInterpreter: Interpreter
       var landmarkInterpreter: Interpreter
       @Published var isDisabled = true
       @Published var detectionFailed: Bool = false
       var fpsHistory: [Double] = []
       @Published var averageFPS: Double = 0.0
       var frameCount = 0
       var startTime: CFAbsoluteTime!

       init?() {
           // TensorFlow Lite modellek betöltése
           guard let detectionModelPath = Bundle.main.path(forResource: "pose_detection", ofType: "tflite"),
                 let landmarkModelPath = Bundle.main.path(forResource: "pose_landmark_full", ofType: "tflite") else {
               print("Failed to load the models")
               return nil
           }

           // Interpreterek létrehozása a Core ML delegáttal
           do {
               let coreMLDelegate = CoreMLDelegate()

               detectionInterpreter = try Interpreter(modelPath: detectionModelPath, delegates: [coreMLDelegate!])
               landmarkInterpreter = try Interpreter(modelPath: landmarkModelPath, delegates: [coreMLDelegate!])
               startTime = CFAbsoluteTimeGetCurrent()
           } catch let error {
               print("Failed to create the interpreter with error: \(error.localizedDescription)")
               return nil
           }
       }
    func detectPose(in image: MLImage, width: CGFloat, height: CGFloat, completion: @escaping ([Pose]) -> Void) {
       
        
        let poses: [Pose] = []
        
        DispatchQueue.main.async {
            completion(poses)
        }
    
       
    }
    
   
}
