//
//  RequestManagerUploadRequestData.swift
//  RxAlamoRecord
//
//  Created by Dalton Hinterscher on 2/4/19.
//

import Alamofire
import AlamoRecord
import RxSwift

public class RequestManagerUploadRequestData<Url: AlamoRecordURL,
    ARError: AlamoRecordError,
    IDType: Codable>: RequestManagerRequestData<Url, ARError, IDType> {

    private var multipartFormData: ((MultipartFormData) -> Void)!
    private var dataEntries: [UploadRequestData] = []
    
    public func execute<C: Codable>() -> Observable<C> {
        
        let requestManager = self.requestManager
        let data = self.data
        let dataEntries = self.dataEntries
        
        self.multipartFormData = { (data: MultipartFormData) in
            for entry in dataEntries {
                data.append(entry.data,
                            withName: entry.name,
                            fileName: entry.fileName,
                            mimeType: entry.mimeType)
            }
        }
    
        return Observable.create { observer in
            
            requestManager.upload(url: data.url, keyPath: data.keyPath, headers: data.headers, multipartFormData: self.multipartFormData, success: { (object: C) in
                observer.onNext(object)
                observer.onCompleted()
            }, failure: { (error: ARError) in
                observer.onError(error)
            })
            
            return Disposables.create()
        }
        
    }
    
    public func appendData(_ data: UploadRequestData) -> Self {
        dataEntries.append(data)
        return self
    }
    
}
