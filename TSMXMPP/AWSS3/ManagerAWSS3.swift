//
//  ManagerAWSS3.swift
//  TSMXMPP
//
//  Created by Smith Huamani on 10/04/18.
//  Copyright © 2018 Smith Huamani. All rights reserved.
//

import Foundation
import AWSCore
import AWSS3

struct ManagerAWSS3 {
    
    static var sharedInstance = ManagerAWSS3()

    var as3TransferManager: AWSS3TransferManager!
    var as3Bucket: String!
    var as3BucketRoot: String!
    var providerIdentityId: String = ""
    var congnitoReady: Bool = false
    
    func initCognitoIdentifier() {
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: AWSRegionType.USWest2, identityPoolId: "")
        
        let configuration = AWSServiceConfiguration(region: AWSRegionType.EUWest2, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let _ = credentialsProvider.getIdentityId().continueWith { (task: AWSTask) -> Any? in
            
            guard task.error != nil else {
                
                ManagerAWSS3.sharedInstance.providerIdentityId = task.result! as String
                ManagerAWSS3.sharedInstance.congnitoReady = true
                ManagerAWSS3.sharedInstance.as3TransferManager = AWSS3TransferManager.default()
                ManagerAWSS3.sharedInstance.as3Bucket = ""
                ManagerAWSS3.sharedInstance.as3BucketRoot = ""
                return ""
            }
            
            ManagerAWSS3.sharedInstance.initCognitoIdentifier()
            
            return task
        }
        
    }
    
}
