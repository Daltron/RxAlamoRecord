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

import Alamofire
import AlamoRecord
import RxSwift

public class AllRequestData<Url: AlamoRecordURL,
    ARError: AlamoRecordError,
    IDType: Codable,
    Object: AlamoRecordObject<Url, ARError, IDType>>: AlamoRecordObjectRequestData<Url, ARError, IDType, Object> {

    /**
        Executes the request immediately.
     */
    public func execute() -> Observable<[Object]> {
        
        return Observable.create { observer in
            
            Object.all(success: { (objects: [Object]) in
                observer.onNext(objects)
                observer.onCompleted()
            }, failure: { (error: ARError) in
                observer.onError(error)
            })
            
            return Disposables.create()
        }
    }
}
