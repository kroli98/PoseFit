//
//  MLKPoseWrapper.swift
//  PoseGym
//
//  Created by Kiss Roland on 02/10/2023.
//

import Foundation
@interface MLKPoseWrapper : NSObject

@property(nonatomic, strong) MLKPose *pose;
@property(nonatomic, strong) NSArray<MLKPoseLandmark *> *mutableLandmarks;

- (instancetype)initWithPose:(MLKPose *)pose;

@end
