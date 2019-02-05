/*
 
 The MIT License (MIT)
 Copyright (c) 2018 Dalton Hinterscher
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

import AlamoRecord
import RxSwift
import ObjectMapper

public class RequestManagerMapObjectsRequestData<U: AlamoRecordURL, E: AlamoRecordError, IDType>: RequestManagerRequestData<U, E, IDType> {

    public func execute<T: Mappable>() -> Observable<[T]> {
        let data = self.data
        
        return Observable.create { observer in
            
            data.requestManager.mapObjects(data.method,
                                           url: data.url,
                                           parameters: data.parameters,
                                           keyPath: data.keyPath,
                                           encoding: data.encoding,
                                           headers: data.headers,
                                           success: { (objects: [T]) in
                observer.onNext(objects)
                observer.onCompleted()
            }, failure: { (error: E) in
                observer.onError(error)
            })
            
            return Disposables.create()
        }
    }
}
