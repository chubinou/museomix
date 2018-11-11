import QtQuick 2.0

Text {
	FontLoader { id: localFont; source: "qrc:///Leira-Lite.ttf" }

	text: "sample title"
	horizontalAlignment: Text.AlignHCenter
	color: "white"
	font {
		family: localFont.name
		pixelSize: 55
	}
	wrapMode: Text.WordWrap
}
