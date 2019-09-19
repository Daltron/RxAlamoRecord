//
//  UploadRequestData.swift
//  RxAlamoRecord
//
//  Created by Dalton Hinterscher on 2/4/19.
//

import Alamofire
import AlamoRecord
import RxSwift

public class UploadRequestData {

    let name: String
    let data: Data
    let fileName: String?
    let mimeType: String?

    public init(name: String, data: Data, fileName: String? = nil, mimeType: String? = nil) {
        self.name = name
        self.data = data
        self.fileName = fileName
        self.mimeType = mimeType
    }

}
