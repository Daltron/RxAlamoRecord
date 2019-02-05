//
//  RequestManagerUploadRequestData.swift
//  RxAlamoRecord
//
//  Created by Dalton Hinterscher on 2/4/19.
//

import Alamofire
import AlamoRecord
import ObjectMapper
import RxSwift

public class RequestManagerUploadRequestData<U: AlamoRecordURL, E: AlamoRecordError, IDType>: RequestManagerRequestData<U, E, IDType> {

    private var multipartFormData: ((MultipartFormData) -> Void)!
    private var dataEntries: [UploadRequestData] = []
    
    public func execute<T: Mappable>() -> Observable<T> {
        
        let requestManager = self.requestManager
        let data = self.data
        let dataEntries = self.dataEntries
        
        self.multipartFormData = { (data: MultipartFormData) in
            for entry in dataEntries {
                if let fileName = entry.fileName, let mimeType = entry.mimeType {
                    data.append(entry.data, withName: entry.name, fileName: fileName, mimeType: mimeType)
                } else {
                    data.append(entry.data, withName: entry.name)
                }
            }
        }
    
        return Observable.create { [weak self] observer in
      
            guard let self = self else { return Disposables.create() }
            
            requestManager.upload(url: data.url, keyPath: data.keyPath, headers: data.headers, multipartFormData: self.multipartFormData, success: { (object: T) in
                observer.onNext(object)
                observer.onCompleted()
            }, failure: { (error: E) in
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
