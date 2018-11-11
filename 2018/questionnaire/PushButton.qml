import QtQuick 2.0

Rectangle {
	id: button

	signal clicked()

	width: button.radius
	height: button.radius
	radius: 150
	color: "red"
	MouseArea {
		anchors.fill: parent
		onClicked: button.clicked()
	}
}
