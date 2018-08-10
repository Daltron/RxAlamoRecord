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

private typealias U = AlamoRecord.URLProtocol
private typealias E = AlamoRecordError

public extension Reactive {
    
    /**
       Creates request data for the AlamoRecordObject.all() request that is to be executed.
     */
    public static func all<U, E>() -> AllRequestData<U, E, Base> where Base: AlamoRecordObject<U, E> {
        return AllRequestData()
    }
    
    /**
     Creates request data for the AlamoRecordObject.find(id: Any) request that is to be executed.
     */
    public static func find<U, E>(id: Any) -> FindRequestData<U, E, Base> where Base: AlamoRecordObject<U, E> {
        return FindRequestData(id: id)
    }
    
    /**
        Creates request data for the AlamoRecordObject.create() request that is to be executed.
     */
    public static func create<U, E>() -> CreateRequestData<U, E, Base> where Base: AlamoRecordObject<U, E> {
        return CreateRequestData()
    }
    
    /**
        Creates request data for the AlamoRecordObject.update(id: Any) request that is to be executed.
     */
    public static func update<U, E>(id: Any) -> UpdateRequestData<U, E, Base> where Base: AlamoRecordObject<U, E> {
        return UpdateRequestData(id: id, type: Base.self)
    }
    
    /**
        Creates request data for the alamoRecordObject.update(id: Any) request that is to be executed.
     */
    public func update<U, E>() -> UpdateRequestData<U, E, Base> where Base: AlamoRecordObject<U, E> {
        return UpdateRequestData(id: base.id, type: Base.self)
    }
    
    /**
        Creates request data for the AlamoRecordObject.destroy(id: Any) request that is to be executed.
     */
    public static func destroy<U, E>(id: Any) -> DestroyRequestData<U, E, Base> where Base: AlamoRecordObject<U, E> {
        return DestroyRequestData(id: id, type: Base.self)
    }
    
    /**
        Creates request data for the alamoRecordObject.destroy(id: Any) request that is to be executed.
     */
    public func destroy<U, E>() -> DestroyRequestData<U, E, Base> where Base: AlamoRecordObject<U, E> {
        return DestroyRequestData(id: base.id, type: Base.self)
    }

}
