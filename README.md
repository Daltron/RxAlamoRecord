![RxAlamoRecord](/Users/Dalton/Documents/Development/iOS/RxAlamoRecord/RxAlamoRecord/Assets/rx_alamorecord.png)

[![Version](https://img.shields.io/cocoapods/v/RxAlamoRecord.svg?style=flat)](http://cocoapods.org/pods/RxAlamoRecord)
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift-4.1-4BC51D.svg?style=flat" alt="Language: Swift" /></a>
[![Platform](https://img.shields.io/cocoapods/p/RxAlamoRecord.svg?style=flat)](http://cocoapods.org/pods/RxAlamoRecord)
[![License](https://img.shields.io/cocoapods/l/RxAlamoRecord.svg?style=flat)](http://cocoapods.org/pods/RxAlamoRecord)

## Written in Swift 4.1

RxAlamoRecord combines the power of the [AlamoRecord](https://github.com/tunespeak/AlamoRecord) and [RxSwift](https://github.com/ReactiveX/RxSwift) libraries to create a networking layer that makes interacting with API's easier than ever reactively.


## Requirements

- iOS 9.0+ / macOS 10.11+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 9.0+
- Swift 4.1+

## Installation

AlamoRecord is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxAlamoRecord'
```

## Getting Started

RxAlamoRecord can not be used without first understanding the basic principles of [AlamoRecord](https://github.com/tunespeak/AlamoRecord) and [RxSwift](https://github.com/ReactiveX/RxSwift). It is suggested you have a basic understanding of how both libraries work before proceeding.

#### Purpose

RxAlamoRecord gives you the power to bind your API reponses directly to `AlamoRecordRelay` and `Action` objects. [Action](https://github.com/RxSwiftCommunity/Action) is a powerful extension library created by the [RxSwiftCommunity](https://github.com/RxSwiftCommunity)

#### `AlamoRecordRelay`

This object behaves exactly the same as a [BehaviorRelay](https://github.com/ReactiveX/RxSwift/blob/4431b623751ac5525e8a8c2d6e82f29b983af07c/RxCocoa/Traits/BehaviorRelay.swift) except that an `AlamoRecordRelay` can emit an error. It is required to use an instance of an `AlamoRecordRelay` when binding via RxAlamoRecord or else your app will crash if the API request returns an error or fails.

#####To help simplify the examples, assume these variables are included in each one:

```swift
let posts = AlamoRecordRelay<[Post]>(value: [])
let post = AlamoRecordRelay<Post?>(value: nil)

lazy var failureAction: Action<ApplicationError, Swift.Never> = {
	return Action { [weak self] error in
   		// Do something with the error
    	return Observable.empty()
    }
}()

```

### Getting all instances of `Post` 

`GET` [https://jsonplaceholder.typicode.com/posts](https://jsonplaceholder.typicode.com/posts)

```swift
Post.rx
	.all() 
	.execute()
   	.bind(to: posts, failure: failureAction)
   	.disposed(by: disposeBag)
```

### Creating an instance of `Post`

`POST` [https://jsonplaceholder.typicode.com/posts](https://jsonplaceholder.typicode.com/posts)

```swift
Post.rx
	.create()
	.withParameters(["userId": userId, "title": title, "body": body]) 
	.execute()
   	.bind(to: post, failure: failureAction)
   	.disposed(by: disposeBag)
```

### Finding an instance of `Post`

`GET` [https://jsonplaceholder.typicode.com/posts/1](https://jsonplaceholder.typicode.com/posts/1)

```swift
Post.rx
	.find(id: 1)
	.execute()
   	.bind(to: post, failure: failureAction)
   	.disposed(by: disposeBag)
```

### Updating an instance of `Post`

`PUT` [https://jsonplaceholder.typicode.com/posts/1](https://jsonplaceholder.typicode.com/posts/1)

```swift
post.value?
	.rx
	.update()
	.withParameters(["userId": userId, "title": title, "body": body])
	.execute()
	.bind(to: post, failure: failureAction)
	.disposed(by: disposeBag)
```
This can also be done at the class level:

```swift
Post.rx
	.update(id: 1)
	.withParameters(["userId": userId, "title": title, "body": body])
	.execute()
	.bind(to: post, failure: failureAction)
	.disposed(by: disposeBag)
```

### Destroying an instance of `Post`

`DELETE` [https://jsonplaceholder.typicode.com/posts/1](https://jsonplaceholder.typicode.com/posts/1)

```swift

lazy var destroyedAction: Action<Void, Swift.Never> = {
	return Action { [weak self] in
		// The post is now destroyed
		return Observable.empty()
	}
}()

post.value?
	.rx
	.destroy()
	.execute()
	.bind(to: destroyedAction, failure: failureAction)
	.disposed(by: disposeBag)
```
This can also be done at the class level:

```swift
Post.rx
    .destroy(id: 1)
    .execute()
    .bind(to: destroyedAction, failure: failureAction)
    .disposed(by: disposeBag)
```

### Assigning default value on failure

It is also possible to assign a default value to an AlamoRecordRelay/Action object if an API request fails:

```swift
let postTitle = AlamoRecordRelay<String?>(value: nil)

Post.rx
	.find(id: 1)
	.execute()
	.map { $0.title }
	.bind(to: postTitle, valueOnFailure: "Default Title")
	.disposed(by: disposeBag)
```

```swift
lazy var postTitleAction: Action<String, Swift.Never> = {
	return Action { [weak self] title in
		// Do something with the title
		return Observable.empty()
	}
}()

Post.rx
	.find(id: 1)
	.execute()
	.map { $0.title }
	.bind(to: postTitleAction, valueOnFailure: "Default Title")
	.disposed(by: disposeBag)
```

#### Download the example project to see just how easy creating an application with a reactive networking layer is when using RxAlamoRecord!

## Author

Dalton Hinterscher, daltonhint4@gmail.com

## Credits

Reactive Logo used in header image designed by [ReactiveX](https://github.com/ReactiveX) group

## License

RxAlamoRecord is available under the MIT license. See the LICENSE file for more info.