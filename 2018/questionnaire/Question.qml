import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.1


Item {
	id: page
	width: 1050
	height: 1680

	property alias txtTitle: title.text

	property alias txtA: respA.text
	property int respAVal: 0
	property int weightA: 1

	property alias txtB: respB.text
	property int respBVal: 1
	property int weightB: 1

	property alias txtC: respC.text
	property int respCVal: 2
	property int weightC: 1

	signal resp(var val, var weight);

	Column {
		anchors.fill: parent
		spacing: 50

		topPadding: 100

		TitleText {
			id: title
			anchors.horizontalCenter: parent.horizontalCenter
			//y: 164
			width: 854
			text: "La dentelle vous en pensez quoi"
		}

		Response {
			id: respA
			//y: 1200
			width: 1000
			color: "red"
			text: "Lorem ipsum dolor sit amet"
			anchors.horizontalCenter: parent.horizontalCenter
			onClicked: resp(page.respAVal, page.weightA)
		}
		Response {
			id: respB
			//y: 900
			width: 1000
			color: "yellow"
			text: "Lorem ipsum dolor sit amet"
			anchors.horizontalCenterOffset: 0
			anchors.horizontalCenter: parent.horizontalCenter
			onClicked: resp(page.respBVal, page.weightB)
		}
		Response {
			id: respC
			//y: 600
			width: 1000
			color: "green"
			text: "Lorem ipsum dolor sit amet"
			anchors.horizontalCenterOffset: 0
			anchors.horizontalCenter: parent.horizontalCenter
			onClicked: resp(page.respCVal, page.weightC)
		}


		Connections {
			target: controler
			onButton1Pressed: resp(page.respAVal, page.weightA)
			onButton2Pressed: resp(page.respBVal, page.weightB)
			onButton3Pressed: resp(page.respCVal, page.weightC)
		}

	}

	BodyText {
		width: 1000
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 20
		color: "#BBBBBB"
		font.pixelSize: 30
		text: "APPUYEZ SUR LE BOUTTON DE LA COULEUR CORRESPONDANTE"
	}
}
