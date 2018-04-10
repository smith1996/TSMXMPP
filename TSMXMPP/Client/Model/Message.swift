//
//  Message.swift
//  TSMXMPP
//
//  Created by Smith Huamani on 10/04/18.
//  Copyright © 2018 Smith Huamani. All rights reserved.
//

import Foundation

public struct Message {
    
    let id: String
    let text: String
    let time: String
    let files: [File]?
    
}
