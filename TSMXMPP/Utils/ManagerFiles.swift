//
//  ManagerFiles.swift
//  TSMXMPP
//
//  Created by Smith Huamani on 10/04/18.
//  Copyright © 2018 Smith Huamani. All rights reserved.
//

import Foundation
import AWSS3

struct ManagerFiles {
    
    func uploadingFiles(arrayData: [FileManager]) {
        
        ManagerAWSS3.sharedInstance.initCognitoIdentifier()
        
        let S3Client = AWSS3.default()
        let putObjectRequest = AWSS3PutObjectRequest()
        putObjectRequest?.bucket = ""
        putObjectRequest?.key = ""
        putObjectRequest?.body = ""
        
    }
    
}
