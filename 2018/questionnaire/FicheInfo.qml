import QtQuick 2.0

import QtQuick 2.0

Item {
	id: root
	width: 1050
	height: 1680
	property alias titre: titre_id.source
	property alias imageSource: image_id.source
	property alias body: body_id.text

	signal next();

	TitleText  {
		id: titre_id
		anchors.centerIn: parent
		text: "Titre explicatif"
	}

	Image  {
		id: image_id
		width: 600
		height: 600
		fillMode: Image.PreserveAspectFit
	}

	BodyText {
		id: body_id
		text: "Titre explicatif"
	}

	PushButton {
		anchors.horizontalCenter: parent.horizontalCenter
		y: 1478
		radius: 100
		onClicked: root.next()
	}

	Connections {
		target: controler
		onButton1Pressed: root.next()
		onButton2Pressed: root.next()
		onButton3Pressed: root.next()
	}
}
