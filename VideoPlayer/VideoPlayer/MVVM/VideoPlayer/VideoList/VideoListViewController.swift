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
        tableViewVideoList.rowHeight = UITableView.automaticDimension
        tableViewVideoList.estimatedRowHeight = 600
    }
}

// MARK : - UITableViewDataSource, UITableViewDelegate
extension VideoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell", for: indexPath) as! VideoListTableViewCell
        if videoList.count > 0 {
            let _videoCellVM = videoList[indexPath.row]
            cell.setupData(videoCellVM: _videoCellVM)
            
            // Cell play button pressed
            cell.pressedVideoPlayer = {
                let storyboard = UIStoryboard(name: "VideoPlayer", bundle: nil)
                if let controller = storyboard.instantiateViewController(withIdentifier: "VideoPlayerViewController") as? VideoPlayerViewController{
                    controller.videoURL =  _videoCellVM.videoURL!
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
        }
        return cell
    }
}
