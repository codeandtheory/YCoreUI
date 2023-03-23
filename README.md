![Y-CoreUI](https://mpospese.com/wp-content/uploads/2022/08/YCoreUI-hero-compact.jpeg)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fyml-org%2FYCoreUI%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/yml-org/YCoreUI) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fyml-org%2FYCoreUI%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/yml-org/YCoreUI)  
_Core components for iOS to accelerate building user interfaces in code._

  This lightweight framework primarily comprises:
  
  * UIView extensions for declarative Auto Layout
  * Protocols to aid loading string, color, and image assets
  * UIColor extensions for WCAG 2.0 contrast ratio calculations
  * (iOS only) UIScrollView extensions to assist with keyboard avoidance
 
  It also contains miscellaneous other Foundation and UIKit extensions.

Licensing
----------
Y—CoreUI is licensed under the [Apache 2.0 license](LICENSE).

Documentation
----------

Documentation is automatically generated from source code comments and rendered as a static website hosted via GitHub Pages at:  https://yml-org.github.io/YCoreUI/

Usage
----------

### 1. UIView extensions for declarative Auto Layout

To aid in auto layout, Y—CoreUI has several `UIView` extensions that simplify creating layout constraints. These do not use any 3rd party library such as SnapKit, but are simply wrappers around Apple’s own `NSLayoutConstraint` api’s. If you are more comfortable using Apple’s layout constraint api’s natively, then by all means go ahead and use them. But these convenience methods allow for less verbose code that expresses its intent more directly.

All the extensions are to `UIView` and begin with the word `constrain`.

The simplest flavor just creates constraints using attributes just like the original iOS 6 `NSLayoutContraint` api.

```swift
// constrain a button's width to 100
let button = UIButton()
addSubview(button)
button.constrain(.width, constant: 100)

// constrain view to superview
let container = UIView()
addSubview(container)
container.constrain(.leading, to: .leading, of: superview)
container.constrain(.trailing, to: .trailing, of: superview)
container.constrain(.top, to: .top, of: superview)
container.constrain(.bottom, to: .bottom, of: superview)
```

Another flavor creates constraints using anchors just like the anchor api’s first introduced in iOS 9.

```swift
// constrain a button's width to 100
let button = UIButton()
addSubview(button)
button.constrain(.widthAnchor, constant: 100) 

// constrain view to superview
let container = UIView()
addSubview(container)
container.constrain(.leadingAnchor, to: leadingAnchor)
container.constrain(.trailingAnchor, to: trailingAnchor)
container.constrain(.topAnchor, to: topAnchor)
container.constrain(.bottomAnchor, to: bottomAnchor)
```

There are overrides to handle the common use case of placing one view below another or to the trailing side of another:

```swift
// constrain button2.leadingAnchor to button1.trailingAnchor
button2.constrain(after: button1, offset: insets.leading)

// constrain label2.topAnchor to label1.bottomAnchor
label2.constrain(below: label1, offset: gap)
```

But where these extensions really shine are the `constrainEdges` methods that create up to four constraints with a single method call.

```swift
// constrain 2 buttons across in a view
let button1 = UIButton()
let button2 = UIButton()
let insets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
addSubview(button1)
addSubview(button2)

button1.constrainEdges(.notTrailing, with: insets)
button2.constrainEdges(.notLeading, with: insets)
button2.constrain(after: button1, offset: insets.leading)
button1.constrain(.widthAnchor, to: button2.widthAnchor)

// constrain view to superview
let container = UIView()
addSubview(container)
container.constrainEdges()
```

There’s also a `constrainEdgesToMargins` variant that sets constraints between the recipient’s edges and the layout margins of the specified view (typically the recipient’s superview). This is very handy for avoiding safe areas such as the region occupied by the navigation bar or by the FaceID notch.

```swift
// constrain 2 buttons across in a view using margins
let button1 = UIButton()
let button2 = UIButton()
let spacing: CGFloat = 16
addSubview(button1)
addSubview(button2)

button1.constrainEdgesToMargins(.notTrailing)
button2.constrainEdgesToMargins(.notLeading)
button2.constrain(after: button1, offset: spacing)
button1.constrain(.widthAnchor, to: button2.widthAnchor)

// constrain view to superview margins
let container = UIView()
addSubview(container)
container.constrainEdgesToMargins()
```

#### Constrain size

There are three convenience methods for constraining the size of a view.

```swift
// constrain a button's size to 44 x 44 (3 different ways)
let button = UIButton()
addSubview(button)

button.constrainSize(CGSize(width: 44, height: 44))
button.constrainSize(width: 44, height: 44)
button.constrainSize(44)
```

#### Constrain center

There is an Auto Layout convenience method for centering views.

```swift
// center a container view to its superview
let container = UIView()
addSubview(container)

container.constrainCenter()

// center a button horizontally
let button = UIButton()
addSubview(button)

button.constrainCenter(.x)

// align a button and a label vertically by their centers
let button = UIButton()
let label = UILabel()
addSubview(button)
addSubview(label)

button.constrainCenter(.y, to: label)
```

#### Constrain aspect ratio

There is an Auto Layout convenience method for constraining aspect ratio:

```swift
// constrain to a 16:9 aspect ratio
mediaPlayer.constrainAspectRatio(16.0 / 9)

// constrain to a 1:1 aspect ratio
profileImage.constrainAspectRatio(1)
```

### 2. Protocols to aid loading string, color, and image assets

We have extensions that accelerate loading strings, colors, and images (and make it easy to unit test them).

#### `Localizable`

Easily load localized string resources from any string-based `Enum`. All you need to do is declare conformance to `Localizable` and you gain access to a `localized: String` property.

```swift
// Conform your Enum to Localizable
enum SettingConstants: String, Localizable, CaseIterable {
    case title = "Settings_Title"
    case color = "Settings_Color"
}

// Then access the localized string
label.text = SettingsConstants.title.localized
```

Unit testing is then easy:

```swift
func test_Setting_Constants_loadsLocalizedString() {
    SettingConstants.allCases.forEach {
        // Given a localized string constant
        let string = $0.localized
        // it should not be empty
        XCTAssertFalse(string.isEmpty)
        // and it should not equal its key
        XCTAssertNotEqual($0.rawValue, string)
    }
}
```

The protocol also allows you to specify the bundle containing the localized strings and the optional table name.

#### `Colorable`

Easily load color assets from any string-based `Enum`. All you need to do is declare conformance to `Colorable` and you gain access to a `color: Color` property. You can even define a `fallbackColor` instead of `nil` or `.clear` so that UI elements won’t be invisible in the event of a failure (but they’re bright pink by default to catch your eye).

```swift
// Conform your Enum to Colorable
enum PrimaryColors: String, CaseIterable, Colorable {
        case primary50
        case primary100
}

// Then access the color
label.textColor = PrimaryColors.primary50.color
```

Unit testing is easy:

```swift
func test_PrimaryColors_loadsColor() {
    PrimaryColors.allCases.forEach {
        XCTAssertNotNil($0.loadColor())
    }
}
```

The protocol also allows you to specify the bundle containing the color assets, the optional namespace, and the fallback color.

#### `ImageAsset`

Easily load image assets from any string-based `Enum`. All you need to do is declare conformance to `ImageAsset` and you gain access to an `image: UIImage` property. You can even define a `fallbackImage` instead of `nil` so that UI elements won’t be invisible in the event of a failure (but it’s a bright pink square by default to catch your eye).

```swift
// Conform your Enum to ImageAsset
enum Flags: String, ImageAsset {
    case unitedStates = "flag_us"
    case india = "flag_in"
}

let flag: Flags = .india
// Then access the image
let image: UIImage = flag.image
```

If you add `CaseIterable` to your enum, then it becomes super simple to write unit tests to make sure they’re working properly (and you can add, update, modify the enum cases without needing to update your unit test).

```swift
enum Icons: String, CaseIterable, ImageAsset {
    case value1
    case value2
    ...
    case valueLast
}

func test_iconsEnum_loadsImage() {
    Icons.allCases.forEach {
        XCTAssertNotNil($0.loadImage())
    }
}
```

The protocol also allows you to specify the bundle containing the image assets, the optional namespace, and the fallback image.

#### `SystemImage`

Easily load system images (SF Symbols) from any string-based `Enum`. All you need to do is declare conformance to `SystemImage` and you gain access to an `image: UIImage` property. Like `ImageAsset` above, you can define a `fallbackImage`.

Why bother doing this when it just wraps `UIImage(systemName:)`? Because
1. `UIImage(systemName:)` returns `UIImage?` while `SystemImage.image` returns `UIImage`.
2. By default `SystemImage.image` returns images that scale with Dynamic Type.
3. Organizing your system images into enums encourages better architecture (and helps avoid stringly-typed errors).
4. Easier to unit test.

```swift
// Conform your Enum to SystemImage
enum Checkbox: String, SystemImage {
    case checked = "checkmark.square"
    case unchecked = "square"
}

// Then access the image
button.setImage(Checkbox.unchecked.image, for: .normal)
button.setImage(Checkbox.checked.image, for: .selected)
```

If you add `CaseIterable` to your enum, then it becomes super simple to write unit tests to make sure they’re working properly (and you can add, update, modify the enum cases without needing to update your unit test).

```swift
enum Checkbox: String, CaseIterable, SystemImage {
    case checked = "checkmark.square"
    case unchecked = "square"
}

func test_checkboxEnum_loadsImage() {
    Checkbox.allCases.forEach {
        XCTAssertNotNil($0.loadImage())
    }
}
```

### 3. UIColor extensions for WCAG 2.0 contrast ratio calculations

Y—CoreUI contains a number of extensions to make working with colors easier. The most useful of them may be WCAG 2.0 contrast calculations. Given any two colors (representing foreground and background colors), you can calculate the contrast ration between them and evaluate whether that passes particular WCAG 2.0 standards (AA or AAA). You can even write unit tests to quickly check all color pairs in your app across all color modes. That could look like this:

```swift
final class ColorsTests: XCTestCase {
    typealias ColorInputs = (foreground: UIColor, background: UIColor, context: WCAGContext)

    // These pairs should pass WCAG 2.0 AA
    let colorPairs: [ColorInputs] = [
        // label on system background
        (.label, .systemBackground, .normalText),
        // label on secondary background
        (.label, .secondarySystemBackground, .normalText),
        // label on tertiary background
        (.label, .tertiarySystemBackground, .normalText),
        // secondary label on system background
        (.secondaryLabel, .systemBackground, .normalText),
        // secondary label on secondary background
        (.secondaryLabel, .secondarySystemBackground, .normalText),
        // secondary label on tertiary background
        (.secondaryLabel, .tertiarySystemBackground, .normalText),
        // tertiary label on system background
        (.tertiaryLabel, .systemBackground, .normalText),
        // tertiary label on secondary background
        (.tertiaryLabel, .secondarySystemBackground, .normalText),
        // tertiary label on tertiary background
        (.tertiaryLabel, .tertiarySystemBackground, .normalText),

        // system red on system background (fails)
        // (.systemRed, .systemBackground, .normalText),
    ]

    let allColorSpaces: [UITraitCollection] = [
        // Light Mode
        UITraitCollection(userInterfaceStyle: .light),
        // Light Mode, Increased Contrast
        UITraitCollection(traitsFrom: [
            UITraitCollection(userInterfaceStyle: .light),
            UITraitCollection(accessibilityContrast: .high)
        ]),
        // Dark Mode
        UITraitCollection(userInterfaceStyle: .dark),
        // Dark Mode, Increased Contrast
        UITraitCollection(traitsFrom: [
            UITraitCollection(userInterfaceStyle: .dark),
            UITraitCollection(accessibilityContrast: .high)
        ])
    ]

    func testColorContrast() {
        // test across all color modes we support
        for traits in allColorSpaces {
            // test each color pair
            colorPairs.forEach {
                let color1 = $0.foreground.resolvedColor(with: traits)
                let color2 = $0.background.resolvedColor(with: traits)

                XCTAssertTrue(
                    color1.isSufficientContrast(to: color2, context: $0.context, level: .AA),
                    String(
                        format: "#%@ vs #%@ ratio = %.02f under %@ Mode%@",
                        color1.rgbDisplayString(),
                        color2.rgbDisplayString(),
                        color1.contrastRatio(to: color2),
                        traits.userInterfaceStyle == .dark ? "Dark" : "Light",
                        traits.accessibilityContrast == .high ? " Increased Contrast" : ""
                    )
                )
            }
        }
    }
}
```

### 4. UIScrollView extensions to assist with keyboard avoidance

#### FormViewController

 `FormViewController` is a view controller with a scrollable content area that will automatically avoid the keyboard for you. It is a good choice for views that have inputs (e.g. login or onboarding). Even for views without inputs, it is still quite useful for managing the creation of a `UIScrollView` and a `contentView` set within it, so that you can focus on your content and not have to code a scrollView for every view. 

#### UIScrollview Extensions

Want to have a scrollview that avoids the keyboard, but you can’t use `FormViewController`? Most of its functionality is a simple extension to `UIScrollView`. You can add keyboard avoidance to any scroll view like so:

```swift
scrollView.registerKeyboardNotifications()
```
<aside>
💡 Almost every full-screen view in your app that contains any text should be a vertical scroll view because of the vagaries of localization, Dynamic Type, potentially small screen sizes, and landscape mode support.
</aside>

Installation
----------

You can add Y-CoreUI to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Add Packages...**
2. Enter "[https://github.com/yml-org/YCoreUI](https://github.com/yml-org/YCoreUI)" into the package repository URL text field
3. Click **Add Package**

Contributing to Y-CoreUI
----------

### Requirements

#### SwiftLint (linter)
```
brew install swiftlint
```

#### Jazzy (documentation)
```
sudo gem install jazzy
```

### Setup

Clone the repo and open `Package.swift` in Xcode.

### Versioning strategy

We utilize [semantic versioning](https://semver.org).

```
{major}.{minor}.{patch}
```

e.g.

```
1.0.5
```

### Branching strategy

We utilize a simplified branching strategy for our frameworks.

* main (and development) branch is `main`
* both feature (and bugfix) branches branch off of `main`
* feature (and bugfix) branches are merged back into `main` as they are completed and approved.
* `main` gets tagged with an updated version # for each release
 
### Branch naming conventions:

```
feature/{ticket-number}-{short-description}
bugfix/{ticket-number}-{short-description}
```
e.g.
```
feature/CM-44-button
bugfix/CM-236-textview-color
```

### Pull Requests

Prior to submitting a pull request you should:

1. Compile and ensure there are no warnings and no errors.
2. Run all unit tests and confirm that everything passes.
3. Check unit test coverage and confirm that all new / modified code is fully covered.
4. Run `swiftlint` from the command line and confirm that there are no violations.
5. Run `jazzy` from the command line and confirm that you have 100% documentation coverage.
6. Consider using `git rebase -i HEAD~{commit-count}` to squash your last {commit-count} commits together into functional chunks.
7. If HEAD of the parent branch (typically `main`) has been updated since you created your branch, use `git rebase main` to rebase your branch.
    * _Never_ merge the parent branch into your branch.
    * _Always_ rebase your branch off of the parent branch.

When submitting a pull request:

* Use the [provided pull request template](.github/pull_request_template.md) and populate the Introduction, Purpose, and Scope fields at a minimum.
* If you're submitting before and after screenshots, movies, or GIF's, enter them in a two-column table so that they can be viewed side-by-side.

When merging a pull request:

* Make sure the branch is rebased (not merged) off of the latest HEAD from the parent branch. This keeps our git history easy to read and understand.
* Make sure the branch is deleted upon merge (should be automatic).

### Releasing new versions
* Tag the corresponding commit with the new version (e.g. `1.0.5`)
* Push the local tag to remote

Generating Documentation (via Jazzy)
----------

You can generate your own local set of documentation directly from the source code using the following command from Terminal:
```
jazzy
```
This generates a set of documentation under `/docs`. The default configuration is set in the default config file `.jazzy.yaml` file.

To view additional documentation options type:
```
jazzy --help
```
A GitHub Action automatically runs each time a commit is pushed to `main` that runs Jazzy to generate the documentation for our GitHub page at: https://yml-org.github.io/YCoreUI/
