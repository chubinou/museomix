import QtQuick 2.0

PushButton {
	anchors.horizontalCenter: parent.horizontalCenter
	y: 1450
	radius: 150
	onClicked: parent.next()
	color: "yellow"
	property alias text: txt_id.text

	Connections {
		target: controler
		onButton1Pressed: parent.next()
		onButton2Pressed: parent.next()
		onButton3Pressed: parent.next()
	}
	BodyText {
		id: txt_id
		anchors.centerIn: parent
		color: "black"
		text: "suite"
	}
}
