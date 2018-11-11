import QtQuick 2.0
import QtQuick.Window 2.0
import Qt.labs.folderlistmodel 2.1
import Qt.labs.platform 1.0

Window {
	id: root
	color: "black"

	Component.onCompleted: {
		root.showFullScreen()
	}

	function getRandomArbitrary(rand, min, max) {
	  return ((rand + 1) / 2) * (max - min) + min;
	}

	Repeater {
		id: repeater_id
		model: FolderListModel {
			//folder: StandardPaths.locate(StandardPaths.PicturesLocation, "./msx_galery/", StandardPaths.LocateDirectory)
			folder: "/home/pierre/Pictures/msx_galery"
			onRowCountChanged: {
				fck_refresh.start()
			}
		}


		delegate: Rectangle {
			id: view
			//we need somtehing that looks like random, but is determinist, probably better to use an hash function
			x: getRandomArbitrary(Math.cos(index), 0, root.width - 200)
			y: getRandomArbitrary(Math.cos(index * 15), 0, root.height - 200)
			z: index
			width: 200
			height: 260
			transform: Rotation {
				//origin.x: view.horizontalCenter;
				//origin.y: view.verticalCenter;
				angle: getRandomArbitrary(Math.cos(index * 4), -10, 10)
			}

			Image {
				width: 180
				height: 180
				fillMode: Image.PreserveAspectCrop
				anchors {
					horizontalCenter: parent.horizontalCenter
					top: parent.top
					topMargin: 10
				}
				source: model.fileURL
			}
		}
	}
}
