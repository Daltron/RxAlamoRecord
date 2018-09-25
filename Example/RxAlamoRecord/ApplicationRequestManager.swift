//
//  ApplicationRequestManager.swift
//  AlamoRecord
//
//  Created by Dalton Hinterscher on 7/3/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import AlamoRecord

class ApplicationRequestManager: RequestManager<ApplicationURL, ApplicationError, Int> {
   
    static var shared = ApplicationRequestManager()
    
    init() {
        super.init(configuration: Configuration())
    }
}
