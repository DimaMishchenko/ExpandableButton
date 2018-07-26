# ExpandableButton
[![Swift 4.1](https://img.shields.io/badge/Swift-4.1-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Packagist](https://img.shields.io/packagist/l/doctrine/orm.svg)](LICENSE)

![](button.gif)

## Requirements
- iOS 9.0+

## Installation
### [CocoaPods](http://www.cocoapods.org):
- Add the following line to your [`Podfile`](http://guides.cocoapods.org/using/the-podfile.html):
``` ruby
pod ''
```
- Add `use_frameworks!` to your [`Podfile`](http://guides.cocoapods.org/using/the-podfile.html).
- Run `pod install`.
- Add to files:
``` swift
import 
```

## Usage
With `image` and `action`:
``` swift
// create items with images and actions
let items = [
    ExpandableButtonItem(
        image: UIImage(named: "delete"), 
        action: {_ in
            print("delete")
        }
    ),
    ExpandableButtonItem(
        image: UIImage(named: "edit"),
        action: {_ in
            print("edit")
        }
    ),
    ExpandableButtonItem(
        image: UIImage(named: "share"), 
        action: { _ in
           print("share")
        }
    )
]
             
// create ExpandableButton
let buttonView = ExpandableButtonView(items: items)
buttonView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
buttonView.backgroundColor = .white
view.addSubview(buttonView)
```
[![Image from Gyazo](https://i.gyazo.com/b032ec076475bdc30a1454e6e840084f.gif)](https://gyazo.com/b032ec076475bdc30a1454e6e840084f)

With `image`, `highlightedImage`, `imageEdgeInsets`:
``` swift
let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
// create items with image, highlighted image, image insets.        
let items = [
    ExpandableButtonItem(
        image: UIImage(named: "delete"),
        highlightedImage: UIImage(named: "delete")!.alpha(0.5),
        imageEdgeInsets: insets,
        action: {_ in
            print("delete")
        }
    )
    ...
]
```
[![Image from Gyazo](https://i.gyazo.com/e2dc4b0eb69636f1816b3caabc71b63a.gif)](https://gyazo.com/e2dc4b0eb69636f1816b3caabc71b63a)

`arrowWidth`, `separatorWidth` and `cornerRadius`:
``` swift
buttonView.arrowWidth = 2
buttonView.separatorWidth = 2
buttonView.layer.cornerRadius = 30
```
[![Image from Gyazo](https://i.gyazo.com/09283ee08763550e0ed2a4167dc71614.gif)](https://gyazo.com/09283ee08763550e0ed2a4167dc71614)

Custom icons for `open` and `close` actions, `closeOpenImagesInsets`: 
``` swift
// custom open and close images
buttonView.openImage = UIImage(named: "open")
buttonView.closeImage = UIImage(named: "close")
buttonView.closeOpenImagesInsets = insets
```
[![Image from Gyazo](https://i.gyazo.com/37c2f79fe0b55f884a6436270ca4125d.gif)](https://gyazo.com/37c2f79fe0b55f884a6436270ca4125d)

With `attributedTitle`, `highlightedAttributedTitle` and custom item `width`:
``` swift
// with attributed string, highlighted attributed string, custom width.
let items = [
    ExpandableButtonItem(
        attributedTitle: NSAttributedString(
            string: "Attributed Text",
            attributes: [.foregroundColor: UIColor.red]
        ),
        highlightedAttributedTitle: NSAttributedString(
            string: "Attributed Text",
            attributes: [.foregroundColor: UIColor.green]
        ),
        width: 160
    )
]
```
[![Image from Gyazo](https://i.gyazo.com/2fb02285aba755b147997cd4645f8063.gif)](https://gyazo.com/2fb02285aba755b147997cd4645f8063)

With `attributedTitle` under `image` (using `contentEdgeInsets`, `titleEdgeInsets`, `imageEdgeInsets`, `titleAlignment`, `imageContentMode`):
``` swift 
let attributedTitle =  NSAttributedString(
    string: "Share",
    attributes: [.foregroundColor: UIColor.black,
                 .font: UIFont.systemFont(ofSize: 12)]
)

let highlightedAttributedTitle =  NSAttributedString(
    string: "Share",
    attributes: [.foregroundColor: UIColor.lightGray,
                 .font: UIFont.systemFont(ofSize: 12)]
)

let items = [
    ExpandableButtonItem(
        image: #imageLiteral(resourceName: "share"),
        highlightedImage: #imageLiteral(resourceName: "share").alpha(0.5),
        attributedTitle: attributedTitle,
        highlightedAttributedTitle: highlightedAttributedTitle,
        contentEdgeInsets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6),
        titleEdgeInsets: UIEdgeInsets(top: 24, left: -200, bottom: 0, right: 0),
        imageEdgeInsets: UIEdgeInsets(top: 6, left: 0, bottom: 24, right: 0),
        titleAlignment: .center,
        imageContentMode: .scaleAspectFit
    )
]
```
[![Image from Gyazo](https://i.gyazo.com/209a3f10d0efc2351b3b81d06c4f6a5d.gif)](https://gyazo.com/209a3f10d0efc2351b3b81d06c4f6a5d)

You can also `open()` and `close()`:
``` swift
let buttonView = ExpandableButtonView(items: items)

buttonView.open() 
buttonView.close()
```

## All options
### [`ExpandableButtonView`](ExpandableButton/ExpandableButtonView.swift)
| Name                    | Type           | Default value                            | Description                                     |
| :---                    | :---           | :---                                     | :---                                            |
| `state`                 | `State`        | `.closed`                                | Current state. Could be `.opened`, `.closed` or `.animating`. |
| `animationDuration`     | `TimeInterval` | `0.2`                                    | Opening, closing and arrow animation duration.  | 
| `closeOnAction`         | `Bool`         | `false`                                  | If `true` call `close()` after any item action. |
| `isHapticFeedback`      | `Bool`         | `true`                                   | Turn on haptic feedback (Taptic engine)         |
| `arrowInsets`           | `UIEdgeInsets` | `top: 8, left: 12, bottom: 8, right: 12` | Arrow insets.                                   |
| `arrowWidth`            | `CGFloat`      | `1`                                      | Arrow line width.                               |
| `arrowColor`            | `UIColor`      | `UIColor.black`                          | Arrow color.                                    |
| `closeOpenImagesInsets` | `UIEdgeInsets` | `.zero`                                  | Insets for custom close and open images.        |
| `closeImage`            | `UIImage?`     | `nil`                                    | Custom close image.                             |
| `openImage`             | `UIImage?`     | `nil`                                    | Custom open image.                              |
| `isSeparatorHidden`     | `Bool`         | `false`                                  | If `true` hide separator view.                  |
| `separatorColor`        | `UIColor`      | `UIColor.black`                          | Separator color.                                |
| `separatorTopOffset`    | `CGFloat`      | `8`                                      | Separator view top offset.                      |
| `separatorBottomOffset` | `CGFloat`      | `8`                                      | Separator view bottom offset.                   |
| `separatorWidth`        | `CGFloat`      | `1`                                      | Separator view width.                           |

### [`ExpandableButtonItem`](ExpandableButton/ExpandableButtonItem.swift)
| Name                         | Type                             | Default value     | Description                                      |
| :---                         | :---                             | :---              | :---                                             |
| `image`                      | `UIImage?`                       | `nil`             | Image for `.normal` state.                       |
| `highlightedImage`           | `UIImage?`                       | `nil`             | Image for `.highlighted` state.                  | 
| `attributedTitle`            | `NSAttributedString?`            | `nil`             | Attributed string for `.normal` state.           |
| `highlightedAttributedTitle` | `NSAttributedString?`            | `nil`             | Attributed string for `.highlighted` state.      |
| `contentEdgeInsets`          | `UIEdgeInsets`                   | `.zero`           | `contentEdgeInsets` for `UIButton`               |
| `titleEdgeInsets`            | `UIEdgeInsets`                   | `.zero`           | `titleEdgeInsets` for `UIButton`.                |
| `imageEdgeInsets`            | `UIEdgeInsets`                   | `.zero`           | `imageEdgeInsets` for `UIButton`.                |
| `width`                      | `CGFloat?`                       | `nil`             | `UIButton` width for current item. If `nil` will be equal to arrow button width. |
| `titleAlignment`             | `NSTextAlignment`                | `.center`         | `titleAlignment` for `titleLabel` in `UIButton`. |
| `imageContentMode`           | `UIViewContentMode`              | `.scaleAspectFit` | `imageContentMode` for `imageView` in `UIButton`.|
| `action`                     | `(ExpandableButtonItem) -> Void` | `{_ in}`          | Action closure. Calls on `.touchUpInside`        |
| `identifier`                 | `String`                         | `""`              | Identifier for `ExpandableButtonItem`.           |

You can also use [`ArrowButton`](ExpandableButton/ArrowButton.swift) (button which can drow left and right arrow using core graphics, just call `showLeftArrow()` or `showRightArrow()`) and [`ActionButton`](ExpandableButton/ActionButton.swift) (simple `UIButton` but with `actionBlock` propertie which calls on `.touchUpInside`) in your projects.

## License
**ExpandableButton** is under MIT license. See the [LICENSE](LICENSE) file for more info.
