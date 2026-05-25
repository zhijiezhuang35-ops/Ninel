import UIKit

func threadEcho(topicFolder: String, noteFile: String) -> UIImage {
    let dialogPath = Bundle.main.path(forResource: noteFile, ofType: "png", inDirectory: topicFolder)
    let notebookPath = Bundle.main.path(forResource: noteFile, ofType: "png")

    return UIImage(contentsOfFile: dialogPath ?? notebookPath ?? "") ?? UIImage()
}

func journalPicture(topicFolder: String, noteFile: String) -> UIImage {
    threadEcho(topicFolder: topicFolder, noteFile: noteFile)
}
