import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1
import Qt.labs.platform 1.0

Item {
	id: page
	width: 1050
	height: 1680

	signal next();

	Rectangle {
		id: imgrect
		width: 800
		height: 800
		anchors.centerIn: parent

		Image {
			id: image
			width: parent.width * 0.9
			height: parent.height * 0.9
			fillMode: Image.PreserveAspectCrop
			anchors.centerIn: parent

			source: StandardPaths.locate(StandardPaths.PicturesLocation, "msx_booth/photo.jpg")
		}
	}

	SuiteButton { }
}
