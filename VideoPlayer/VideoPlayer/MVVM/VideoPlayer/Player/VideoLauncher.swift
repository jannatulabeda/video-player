//
//  VideoLauncher.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    var closeVideoPlayer: (() -> Void)? // Close Button closure : Sends action when video is closed
    var isPlaying = false // Current state of video playing
    var player: AVPlayer? // Video player

    // MARK: - UI Component
    // Controls container view
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    // Activity indicator
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    // Play and pause button
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        
        button.addTarget(self, action: #selector(pausePlayButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // Current time label (Left)
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    // Video length label (Right)
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    // Video close button
    let videoCloseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(videoCloseButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // Video slider
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    // MARK: - Button action
    // Handle tap gesture
    @objc func handleTapGesture() {
        UIView.animate(withDuration: 1.0, delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut, animations: {
                        if self.isPlaying {
                            if self.pausePlayButton.alpha == 1.0 {
                                self.pausePlayButton.alpha = 0.0
                            } else {
                                self.pausePlayButton.alpha = 1.0
                            }
                        } else {
                            self.pausePlayButton.alpha = 1.0
                        }
        }) { (_) in
        }
    }
    
    // Slider change
    @objc func handleSliderChange() {
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
            })
        }
    }
    
    // Pause and play button pressed event
    @objc func pausePlayButtonPressed() {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
        if isPlaying {
            handleTapGesture()
        }
    }
    
    // Video close button pressed event
    @objc func videoCloseButtonPressed() {
        if isPlaying {
            player?.pause()
        }
        isPlaying = !isPlaying
        closeVideoPlayer!()
    }
    
    // MARK : - Methods
    
    // Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, videoLink: String) {
        
        super.init(frame: frame)
        
        setupGradientLayer()
        setupPlayerView(videoLink: videoLink)
        
        // Setup controls container
        controlsContainerView.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        addSubview(controlsContainerView)
        controlsContainerView.backgroundColor = UIColor.clear

        // Setup activity indicator
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        // Setup pausePlayButton
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Setup video length label (left)
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true

        // Setup current time label (right)
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        // Setup slider
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Setup video close button
        controlsContainerView.addSubview(videoCloseButton)
        videoCloseButton.rightAnchor.constraint(equalTo: rightAnchor, constant: 5.0).isActive = true
        videoCloseButton.topAnchor.constraint(equalTo: topAnchor, constant: 5.0).isActive = true
        videoCloseButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        videoCloseButton.widthAnchor.constraint(equalToConstant: 60).isActive = true

        // Setup tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)

        // Self properties
        backgroundColor = .black
    }
    
    // Setup player view
    private func setupPlayerView(videoLink: String) {
        if let url = URL(string: videoLink) {
            player = AVPlayer(url: url)
        
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)

            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                
                let seconds = CMTimeGetSeconds(progressTime)                
                let secondsString = String(format: "%02d", Int(seconds) % 60)
                let minutesString = String(format: "%02d", Int(seconds) / 60)
                
                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                
                // Move the slider
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.videoSlider.value = Float(seconds / durationSeconds)
                }
            })
        }
    }
    
    // Setup gradient layer
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    // Override observeValue method
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
            UIView.animate(withDuration: 1.5, delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut, animations: {
                            self.pausePlayButton.alpha = 0.0
            }) { (_) in
            }
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
}

// MARK: Video Launcher class
class VideoLauncher: NSObject {
    var videoLink = "" // Video link to play
    var closeVideoPlayer: (() -> Void)? // Closure to send close button action
    
    // Show video player
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: keyWindow.frame.height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame, videoLink: videoLink)
            view.addSubview(videoPlayerView)
            keyWindow.addSubview(view)

            videoPlayerView.closeVideoPlayer = {
                view.removeFromSuperview()
                self.closeVideoPlayer!()
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }) { (_) in
            }
        }
    }
}
