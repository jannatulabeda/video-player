//
//  VideoListViewController.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {

    // MARK : - @IBOutlet
    @IBOutlet weak var tableViewVideoList: UITableView!
    
    // MARK : - Variables
    var videoList = [VideoCellVM]()
    var isLandscape = false
    var isVideoClosed = true
    
    // MARK : - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        APIRequest.shared.getPlayList { playList in
            Helper.shared.log(object: playList)
            self.videoList = playList!
            DispatchQueue.main.async {
                self.tableViewVideoList.reloadData()
            }
        }
    }
    
    // Setup table view
    func setupTableView() {
        tableViewVideoList.register(UINib(nibName: "VideoListTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoListTableViewCell")
        tableViewVideoList.register(UINib(nibName: "VideoListLandscapeTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoListLandscapeTableViewCell")
        tableViewVideoList.rowHeight = UITableView.automaticDimension
        tableViewVideoList.estimatedRowHeight = 600
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            isLandscape = true
        } else {
            isLandscape = false
        }
        tableViewVideoList.reloadData()
    }
}

// MARK : - UITableViewDataSource, UITableViewDelegate
extension VideoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        if !isLandscape {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell", for: indexPath) as! VideoListTableViewCell
            if videoList.count > 0 {
                let _videoCellVM = videoList[indexPath.row]
                cell.setupData(videoCellVM: _videoCellVM)
                
                // Cell play button pressed
                cell.pressedVideoPlayer = {
                    if self.isVideoClosed {
                        let storyboard = UIStoryboard(name: "VideoPlayer", bundle: nil)
                        if let controller = storyboard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController{
                            self.isVideoClosed = false
                            controller.videoURL =  _videoCellVM.videoURL!
                            controller.closeVideoPlayer = {
                                self.isVideoClosed = true
                            }
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                    }
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoListLandscapeTableViewCell", for: indexPath) as! VideoListLandscapeTableViewCell
            if videoList.count > 0 {
                let _videoCellVM = videoList[indexPath.row]
                cell.setupData(videoCellVM: _videoCellVM)
                
                // Cell play button pressed
                cell.pressedVideoPlayer = {
                    if self.isVideoClosed {
                        let storyboard = UIStoryboard(name: "VideoPlayer", bundle: nil)
                        if let controller = storyboard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController{
                            self.isVideoClosed = false
                            controller.videoURL =  _videoCellVM.videoURL!
                            controller.closeVideoPlayer = {
                                self.isVideoClosed = true
                            }
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                    }
                }
            }
            return cell
        }
    }
}
