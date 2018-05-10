//
//  PlayerMetaViewController.swift
//  BookPlayer
//
//  Created by Florian Pichler on 05.04.18.
//  Copyright © 2018 Tortuga Power. All rights reserved.
//

import UIKit
import MarqueeLabelSwift

class PlayerMetaViewController: PlayerContainerViewController {
    @IBOutlet private weak var authorLabel: BPMarqueeLabel!
    @IBOutlet private weak var titleLabel: BPMarqueeLabel!
    @IBOutlet private weak var chapterLabel: BPMarqueeLabel!

    var book: Book? {
        didSet {
            self.authorLabel.text = self.book?.author
            self.titleLabel.text = self.book?.title

            self.setChapterLabel()
        }
    }

    var chapters: [Chapter]?

    var colors: ArtworkColors? {
        didSet {
            guard let colors = self.colors else {
                return
            }

            self.titleLabel.textColor = colors.primary
            self.authorLabel.textColor = colors.secondary
            self.chapterLabel.textColor = colors.tertiary
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.onPlayback), name: Notification.Name.AudiobookPlayer.bookPlaying, object: nil)
    }

    private func setChapterLabel() {
        guard let chapters = self.book?.chapters, !chapters.isEmpty, let currentChapter = self.book?.currentChapter else {
            self.chapterLabel.text = ""
            self.chapterLabel.isEnabled = false

            return
        }

        self.chapterLabel.isEnabled = true
        self.chapterLabel.text = currentChapter.title != "" ? currentChapter.title : "Chapter \(currentChapter.index) of \(chapters.count)"
    }

    @objc func onPlayback(_ notification: Notification) {
        self.setChapterLabel()
    }
}
