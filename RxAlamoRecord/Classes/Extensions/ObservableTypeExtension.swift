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
import AlamoRecord
import RxSwift

public extension ObservableType {

    /**
        Creates new subscription and sends elements to an AlamoRecordRelay.
        - parameter to: Target AlamoRecordRelay for sequence elements.
        - parameter failure: Action that will be executed if the API request fails.
     */
    public func bind<Error: AlamoRecordError>(to relay: AlamoRecordRelay<E>?,
                                              failure: Action<Error, Swift.Never>? = nil) -> Disposable {
        return subscribe { e in
            switch e {
            case let .next(element):
                relay?.accept(element)
            case let .error(error):
                failure?.execute(error as? Error ?? Error())
            case .completed:
                break
            }
        }
    }
    
    /**
        Creates new subscription and sends elements to an AlamoRecordRelay.
        - parameter to: Target AlamoRecordRelay for sequence elements.
        - parameter failure: Action that will be executed if the API request fails.
     */
    public func bind<Error: AlamoRecordError>(to relay: AlamoRecordRelay<E?>?,
                                              failure: Action<Error, Swift.Never>? = nil) -> Disposable {
        return self.map { $0 as E? }.bind(to: relay, failure: failure)
    }
    
    /**
        Creates new subscription that only cares about when an API request fails.
        - parameter failure: Action that will be executed if the API request fails.
     */
    public func bind<Error: AlamoRecordError>(failure: Action<Error, Swift.Never>) -> Disposable {
        return subscribe { e in
            switch e {
            case .next(_):
                break
            case let .error(error):
                failure.execute(error as? Error ?? Error())
            case .completed:
                break
            }
        }
    }
    
    /**
        Creates new subscription and sends elements to an Action.
        - parameter to: Target Action for sequence elements.
        - parameter failure: Action that will be executed if the API request fails.
     */
    public func bind<Error: AlamoRecordError>(to action: Action<E, Swift.Never>? = nil,
                                              failure: Action<Error, Swift.Never>? = nil) -> Disposable {
        return subscribe { e in
            switch e {
            case let .next(element):
                action?.execute(element)
            case let .error(error):
                failure?.execute(error as? Error ?? Error())
            case .completed:
                break
            }
        }
    }
    
    /**
        Creates new subscription and sends elements to an AlamoRecordRelay.
        - parameter to: Target AlamoRecordRelay for sequence elements.
        - parameter valueOnFailure: If an API request fails, the AlamoRecordRelay object will be given this.
     */
    public func bind(to relay: AlamoRecordRelay<E>?,
                     valueOnFailure: E) -> Disposable {
        return subscribe { e in
            switch e {
            case let .next(element):
                relay?.accept(element)
            case .error(_):
                relay?.accept(valueOnFailure)
            case .completed:
                break
            }
        }
    }
    
    /**
        Creates new subscription and sends elements to an AlamoRecordRelay.
        - parameter to: Target AlamoRecordRelay for sequence elements.
        - parameter valueOnFailure: If an API request fails, the AlamoRecordRelay object will be given this.
     */
    public func bind(to relay: AlamoRecordRelay<E?>?,
                     valueOnFailure: E) -> Disposable {
        return self.map { $0 as E? }.bind(to: relay, valueOnFailure: valueOnFailure)
    }
    
    /**
        Creates new subscription and sends elements to an AlamoRecordRelay.
        - parameter to: Target Action for sequence elements.
        - parameter valueOnFailure: If an API request fails, the Action object will be given this.
     */
    public func bind(to action: Action<E, Swift.Never>?,
                     valueOnFailure: E) -> Disposable {
        return subscribe { e in
            switch e {
            case let .next(element):
                action?.execute(element)
            case .error(_):
                action?.execute(valueOnFailure)
            case .completed:
                break
            }
        }
    }
}
