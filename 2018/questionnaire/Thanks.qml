import QtQuick 2.0

Item {
	id: root
	width: 1050
	height: 1680

	signal next();

	TitleText {
		y: 310
		anchors.horizontalCenter: parent.horizontalCenter
		text: "fin"
		font.pixelSize: 80
		anchors.horizontalCenterOffset: 1
	}

	BodyText {
		y: 579
		width: 1000
		text: "Au 19ème siècle, la coiffe donnait des indications sur le statut de la femme qui la portait : en couple, célibataire... Aujourd'hui, le chapeau et la coiffure donnent d'autres informations, et le statut se retrouve... sur facebook, par exemple !"
		anchors.verticalCenter: parent.verticalCenter
		anchors.horizontalCenterOffset: -9
		anchors.horizontalCenter: parent.horizontalCenter
	}

	SuiteButton {
		text: "Début"
	}
}
