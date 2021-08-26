//
//  RSConfettiView
//
//  Created by Radu Ursache.
//  Copyright © 2020 Radu Ursache. All rights reserved.
//

import UIKit
import QuartzCore

class RSConfettiView: UIView {
    enum ConfettiType {
        case confetti
        case image(UIImage)
    }

    private var emitter: CAEmitterLayer!
    var colors: [UIColor]!
	var intensity: Float! {
		didSet {
			if intensity > 1.5 {
				// don't go above 1.5
				print("\nRSConfettiView: You set a very high intensity, consider lowering it to get a better visual result\n")
			}
		}
	}
    var type: ConfettiType!
    private var active: Bool!

	public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

	public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
            UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
            UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
            UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
            UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
        intensity = 0.75
        type = .confetti
        active = false
    }

    public func startConfetti() {
        emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: frame.size.width / 2.0, y: 0)
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterSize = CGSize(width: frame.size.width, height: 1)

        var cells = [CAEmitterCell]()
        for color in colors {
            cells.append(confettiWithColor(color: color))
        }

        emitter.emitterCells = cells
        layer.addSublayer(emitter)
        active = true
    }

	public func stopConfetti() {
        emitter?.birthRate = 0
        active = false
    }

    private func imageForType(type: ConfettiType) -> UIImage? {
		switch type {
        case .confetti:
			return confettiImage()
        case let .image(customImage):
            return customImage
        }
    }

    private func confettiWithColor(color: UIColor) -> CAEmitterCell {
        let confetti = CAEmitterCell()
        confetti.birthRate = 8.5 * intensity
        confetti.lifetime = 14.0 * intensity
        confetti.lifetimeRange = 0
        confetti.color = color.cgColor
        confetti.velocity = CGFloat(350.0 * intensity)
        confetti.velocityRange = CGFloat(80.0 * intensity)
        confetti.emissionLongitude = CGFloat(Double.pi)
        confetti.emissionRange = CGFloat(Double.pi)
        confetti.spin = CGFloat(3.5 * intensity)
        confetti.spinRange = CGFloat(4.0 * intensity)
        confetti.scaleRange = CGFloat(intensity)
        confetti.scaleSpeed = CGFloat(-0.1 * intensity)
        confetti.contents = imageForType(type: type)!.cgImage
        return confetti
    }

    public func isActive() -> Bool {
		return active
    }
}

extension RSConfettiView {
	public static func showConfetti(inView view: UIView, type: ConfettiType = .confetti, intensity: Float = 1, duration: Double = 5, completitionHandler: (() -> Void)? = nil) {
		let confettiView = RSConfettiView(frame: view.bounds)
		confettiView.intensity = intensity
		view.addSubview(confettiView)
		confettiView.startConfetti()
		DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
			UIView.animate(withDuration: 0.6, animations: {
				confettiView.alpha = 0
			}, completion: { done in
				if done {
					confettiView.removeFromSuperview()
					completitionHandler?()
				}
			})
		}
	}
}

extension RSConfettiView {
	private func confettiImage() -> UIImage {
		return UIImage(data: Data(base64Encoded: "iVBORw0KGgoAAAANSUhEUgAAAA8AAAAPCAYAAAA71pVKAAAACXBIWXMAAAWJAAAFiQFtaJ36AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAJZJREFUeNpi/P//PwO5gIlE9Q5AHADngWwmgB2AeMF/BPgAk8OnSQCIJ/zHDhzwaQZpvPAfN5iASzMhjSDwAJfmA/+JAwroGgsIaAAFVgLUdQzozv2AR+MFmCZsod2AR+MBbAGLzHmAJ3AE8Gl2wGOrA660gJw8H2JJjguB+ADOxIolKSJHlQK+pItLwgAabXjTPUCAAQDOH2xaUk7hYgAAAABJRU5ErkJggg==", options: .ignoreUnknownCharacters)!)!
	}
}
