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

import Action
import Alamofire
import AlamoRecord
import RxSwift
import RxCocoa

public class FindRequestData<U: AlamoRecord.URLProtocol, E: AlamoRecordError, T:AlamoRecordObject<U, E>>: AlamoRecordObjectRequestData<U, E, T> {

    let id: Any
    
    init(id: Any) {
        self.id = id
    }
    
    /**
        Executes the request immediately.
     */
    public func execute() -> Observable<T> {
        
        let id = self.id
        let data = self.data
        
        return Observable.create { observer in
            
            T.find(id: id, parameters: data.parameters, encoding: data.encoding, headers: data.headers, success: { (object: T) in
                observer.onNext(object)
                observer.onCompleted()
            }, failure: { (error: E) in
                
                observer.onError(error)
            })
            
            return Disposables.create()
        }
        
    }

}