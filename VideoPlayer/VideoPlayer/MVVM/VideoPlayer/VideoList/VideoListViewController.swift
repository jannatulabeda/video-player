//
//  VideoListViewController.swift
//  VideoPlayer
//
//  Created by Jannatul Abeda on 2019/06/29.
//  Copyright © 2019 Jannatul Abeda. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {

    @IBOutlet weak var tableViewVideoList: UITableView!
    var videoList = [VideoCellVM]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCell()
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
    
    func registerCell() {
        tableViewVideoList.register(UINib(nibName: "VideoListTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoListTableViewCell")
        tableViewVideoList.rowHeight = UITableView.automaticDimension
        tableViewVideoList.estimatedRowHeight = 600
    }
}

extension VideoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell", for: indexPath) as! VideoListTableViewCell
        if videoList.count > 0 {
            let _videoCellVM = videoList[indexPath.row]
            cell.setData(videoCellVM: _videoCellVM)
        }
        return cell
    }
}
