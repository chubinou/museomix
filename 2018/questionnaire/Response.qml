import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
	id: root
	width: 1050
	height: button.height + txt.height + 50

	property alias color: button.color
	property alias text: txt.text
	signal clicked()


	PushButton {
		id: button
		anchors {
			horizontalCenter: parent.horizontalCenter
		}
		radius: 100
		color: "red"
		onClicked: root.clicked()
		Text {
			text: "↓"
			anchors.centerIn: parent
			color: "black"
			font.bold: true
			font.pixelSize: 20
		}
	}

	BodyText {
		id: txt
		text: "Lorem ipsum dolor sit amet"
		anchors.top: button.bottom
		anchors.topMargin: 20
		anchors {
			left: parent.left
			right: parent.right
		}
		font {
			pixelSize: 40
		}
	}
}
