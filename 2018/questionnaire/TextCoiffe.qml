import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1


Item {
	id: page
	width: 1050
	height: 1680

	property alias txtTitle: title.text
	property alias txtBody: body.text
	property alias img: image.source

	signal next();


	TitleText {
		id: title
		y: 165
		anchors.horizontalCenter: parent.horizontalCenter
		width: 854
		height: 184
		text: "La dentelle vous en pensez quoi"
		anchors.horizontalCenterOffset: 0
	}

	Image {
		id: image
		y: 404
		width: 320
		height: 320
		anchors.horizontalCenterOffset: 0
		anchors.horizontalCenter: parent.horizontalCenter
		fillMode: Image.PreserveAspectFit
	}

	BodyText {
		id: body
		anchors.horizontalCenter: parent.horizontalCenter
		y: 800
		width: 1000
		height: 457
		text: "à la fin du 19ème siècle, les femmes de la campagne continuaient à travailler le soir. Elle filaient de la dentelle, ce qui n'était pas toujours facile avant l'arrivée de l'électricité pour s'éclairer..."
	}

	SuiteButton { y: 1427; }
}
