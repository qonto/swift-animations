//
//  Picker.swift
//  MeetupAnimation
//
//  Created by charles on 23/04/2019.
//  Copyright © 2019 charles. All rights reserved.
//

import UIKit

protocol SliderDelegate: class {
    func sliderValueChanged(_ sender: Slider)
}

class Slider: UIView {
    let width: CGFloat = 44
    let border: CGFloat = 10
    /// speed value to change progress from 0 to 1 in second
    let speed: CGFloat = 3.0

    override var bounds: CGRect {
        didSet {
            needRedraw = true
        }
    }

    private var needRedraw: Bool = true
    private var isAnimated: Bool {
        return progress != target
    }

    var delegate: SliderDelegate?

    var progress: CGFloat = 0.5 {
        didSet {
            delegate?.sliderValueChanged(self)
        }
    }
    private var target: CGFloat = 0.5

    private lazy var lineLayer: AnimatedLayer = {
        let layer = AnimatedLayer()
        layer.fillColor     =   UIColor.clear.cgColor
        layer.strokeColor   = UIColor.pastelPurple.cgColor
        layer.lineCap = .round
        layer.lineWidth = 2.0
        return layer
    }()

    private lazy var shadowButtonLayer: AnimatedLayer = {
        let layer = AnimatedLayer()
        layer.fillColor = UIColor.purple.withAlphaComponent(0.4).cgColor
        layer.lineWidth = 0.0
        return layer
    }()

    private lazy var buttonLayer: AnimatedLayer = {
        let layer = AnimatedLayer()
        layer.fillColor = UIColor.purple.cgColor
        layer.lineWidth = 0.0
        return layer
    }()

    private var displayLink: CADisplayLink?
    private var userMovesCursor = false


    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupInterface()
        setupRunLoop()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupInterface() {
        layer.addSublayer(lineLayer)
        layer.addSublayer(shadowButtonLayer)
        layer.addSublayer(buttonLayer)
    }

    private func setupRunLoop() {
        displayLink = CADisplayLink(target: self, selector: #selector(runLoop))
        displayLink?.add(to: .main, forMode: RunLoop.Mode.common)
    }

    // MARK: - Actions

    func slide(to value: CGFloat, animated: Bool = true) {
        guard 0 <= value && value <= 1 else {
            fatalError("value need be on [0..1] or value = \(value)")
        }

        if animated {
            target = value
        } else {
            progress = value
            needRedraw = true
        }
    }

    // MARK: - Run Loop

    @objc
    private func runLoop() {
        guard isAnimated || needRedraw else { return }

        if needRedraw { needRedraw = false }

        updateProgress()

        drawLine()
        drawShadowButton()
        drawButton()
    }

    var beginAnimation: CFTimeInterval?
    var initialProgress: CGFloat?

    private func updateProgress() {
        guard isAnimated else {return }
        guard let timestamp = displayLink?.timestamp else { return }

        if beginAnimation == nil {
            beginAnimation = timestamp
            initialProgress = progress
        }

        if let begin = beginAnimation, let initialProgress = initialProgress {
            let time = CGFloat(timestamp - begin)

            let sign: CGFloat = target > initialProgress ? 1.0 : -1.0
            let newProgress = initialProgress + sign * speed * time

            if reachTarget(newProgress) {
                progress = target
                beginAnimation = nil
            } else {
                progress = newProgress
            }
        }
    }

    private func reachTarget(_ newProgress: CGFloat) -> Bool {
        guard let initialProgress = initialProgress else { return false }

        if target > initialProgress {
            if newProgress >= target {
                return true
            }
        } else {
            if newProgress <= target {
                return true
            }
        }

        return false
    }

    // MARK: - Draw

    private func drawLine() {
        let radius = max(min(frame.width, frame.height) - 2 * border, 0)

        let center = CGPoint(x: border + radius, y: border + radius)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: .pi, endAngle: 1.5 * .pi, clockwise: true)

        lineLayer.path = path.cgPath
    }

    private func drawShadowButton() {
        let radius = max(min(frame.width, frame.height) - 2 * border, 0)

        // Anchor points

        let origin = CGPoint(x: border, y: border + radius)

        let topRadius = radius + 0.4 * width
        let botRadius = radius - 0.4 * width
        let angle = progress * 0.5 * .pi + .pi
        let top = CGPoint(x: origin.x + radius + topRadius * cos(angle), y: origin.y + topRadius * sin(angle))
        let bot = CGPoint(x: origin.x + radius + botRadius * cos(angle), y: origin.y + botRadius * sin(angle))

        // Generate Path

        let path = UIBezierPath()

        path.move(to: origin)

        let ratio = 0.2 + (0.5 - 0.2) * progress

        let cpOriginBotOffsetX = progress * 0.2 * bounds.width
        let cpOriginBotOffsetY = progress * 0.5 * bounds.width
        let cpOriginBot = CGPoint(x: origin.x + cpOriginBotOffsetX, y: origin.y - cpOriginBotOffsetY)

        let offsetCpBotX = progress * ratio * bounds.width
        let offsetCpBotY = (1 - progress) * ratio * bounds.width
        let cpBot = CGPoint(x: bot.x - offsetCpBotX, y: bot.y + offsetCpBotY)
        path.addCurve(to: bot, controlPoint1: cpOriginBot, controlPoint2: cpBot)

        path.addLine(to: top)

        let cpOriginTopOffsetX = progress * 0.2 * bounds.width
        let cpOriginTopOffsetY = progress * 0.5 * bounds.width
        let cpOriginTop = CGPoint(x: origin.x - cpOriginTopOffsetX, y: origin.y - cpOriginTopOffsetY)

        let offsetCpTopX = progress * ratio * bounds.width
        let offsetCpTopY = (1 - progress) * ratio * bounds.width
        let cpTop = CGPoint(x: top.x - offsetCpTopX, y: top.y + offsetCpTopY)

        path.addCurve(to: origin, controlPoint1: cpTop, controlPoint2: cpOriginTop)

        shadowButtonLayer.path = path.cgPath
    }

    private func drawButton() {
        let center = calculateCenter(avancement: progress, border: 10, width: width)

        let rect = CGRect(x: center.x, y: center.y, width: width, height: width)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: width/2)

        buttonLayer.path = path.cgPath
    }

    // MARK: - Gesture Recognizer

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        guard touches.count == 1 else { return }

        let location = touch.location(in: self)

        let center = calculateCenter(avancement: progress, border: 10, width: width)

        let rect = CGRect(x: center.x, y: center.y, width: width, height: width)

        if rect.contains(location) {
            userMovesCursor = true
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard   let touch = touches.first,
                touches.count == 1,
                userMovesCursor
        else {
            userMovesCursor = false
            return
        }

        let point = touch.location(in: self)

        let radius = max(min(frame.width, frame.height) - 2 * border, 0)
        let center = CGPoint(x: border + radius, y: border + radius)

        let distance = sqrt(pow(point.x - center.x, 2) + pow(point.y - center.y, 2))
        let y = center.y - point.y

        if radius - 22 <= distance && distance <= radius + 22 {
            var angle = acos(y / distance)
            if angle.isNaN { angle = 0 }

            target = 1 - min(max(angle / (.pi/2), 0), 1)
        } else {
            userMovesCursor = false
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        userMovesCursor = false
    }

    // MARK: - Maths

    private func calculateCenter(avancement: CGFloat, border: CGFloat, width: CGFloat) -> CGPoint {
        let radius = max(min(frame.width, frame.height) - 2 * border, 0)

        let angle: CGFloat = .pi + avancement * 0.5 * .pi

        let circleCenter = CGPoint(x: border + radius, y: border + radius)

        let x = circleCenter.x + radius * cos(angle)
        let y = circleCenter.y + radius * sin(angle)

        let center = CGPoint(x: x - width/2, y: y - width/2)

        return center
    }
}
