import QtQuick 2.0

Item {
	id: page
	width: 1050
	height: 1680

	signal next()

	property int targetCoiffe: 1


	TitleText {
		anchors.centerIn: parent
		width: 800
		font.pixelSize: 80
		text: "Vous pouvez maintenant prendre votre coiffe"
	}

	SuiteButton {
	}

	Component.onCompleted: {
		controler.light = targetCoiffe
	}

	Component.onDestruction: {
		controler.light = 0
	}
}
