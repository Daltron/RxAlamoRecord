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

private typealias U = AlamoRecordURL
private typealias E = AlamoRecordError

public extension Reactive {
    
    /**
        Creates request data for the requestManager.makeRequest() request that is to be executed.
        - parameter method: The HTTP method
        - parameter url: The URL that conforms to AlamoRecordURL
     */
    func makeRequest<U, E, IDType>(_ method: Alamofire.HTTPMethod,
                                   url: U) -> RequestManagerMakeRequestData<U, E, IDType> where Base: RequestManager<U, E, IDType> {
        return RequestManagerMakeRequestData(requestManager: base, method: method, url: url)
    }
    
    /**
        Creates request data for the requestManager.mapObject() request that is to be executed.
        - parameter method: The HTTP method
        - parameter url: The URL that conforms to AlamoRecordURL
     */
    func mapObject<U, E, IDType>(_ method: Alamofire.HTTPMethod,
                                url: U) -> RequestManagerMapObjectRequestData<U, E, IDType> where Base: RequestManager<U, E, IDType> {
        return RequestManagerMapObjectRequestData(requestManager: base, method: method, url: url)
    }
    
    /**
        Creates request data for the requestManager.mapObjects() request that is to be executed.
        - parameter method: The HTTP method
        - parameter url: The URL that conforms to AlamoRecordURL
     */
    func mapObjects<U, E, IDType>(_ method: Alamofire.HTTPMethod,
                                 url: U) -> RequestManagerMapObjectsRequestData<U, E, IDType> where Base: RequestManager<U, E, IDType> {
        return RequestManagerMapObjectsRequestData(requestManager: base, method: method, url: url)
    }
    
    /**
     Creates request data for the upload() request that is to be executed.
     - parameter url: The URL that conforms to AlamoRecordURL
     */
    func upload<U, E, IDType>(url: U) -> RequestManagerUploadRequestData<U, E, IDType> where Base: RequestManager<U, E, IDType> {
        return RequestManagerUploadRequestData(requestManager: base, method: .post, url: url)
    }

}
