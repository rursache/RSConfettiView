# RSConfettiView
A Swift UIView with animated confetti to present success states

## Installation
- Swift Package Manager (SPM) - `https://github.com/rursache/RSConfettiView`
- Copy `RSConfettiView.swift` (from `Sources/`) in your project

## How to use
1. One time use
```swift
import RSConfettiView

func showConfetti() {
  RSConfettiView.showConfetti(inView: UIView, type: .confetti, intensity: Float, duration: Double, confettiBlocksUI: Bool) {
    // completition handler
  }
}
```

2. Storyboard view / Programatic mode
```swift
import RSConfettiView

@IBOutlet private weak var confettiView: RSConfettiView!

func showConfetti() {
  self.confettiView.type = .confetti
  self.confettiView.intensity = 10 // optional customization
  self.confettiView.startConfetti()
}

func hideConfetti() {
  self.confettiView.stopConfetti()
}

func confettiIsActive() -> Bool {
  return self.confettiView.isActive()
}
```

## Customization
You can provide a custom image for the confetti particles using `type: .image(UIImage)` at init

## License

RSConfettiView is available under the **MPL-2.0 license**. See the [LICENSE](https://github.com/rursache/RSConfettiView/blob/master/LICENSE) file for more info.
