import QtQuick 2.0

Text {
	FontLoader { id: fauneFont; source: "qrc:///Faune-TextRegular.otf" }

	text: "sample title"
	horizontalAlignment: Text.AlignHCenter
	color: "white"
	font {
		family: fauneFont.name
		pixelSize: 50
	}
	wrapMode: Text.Wrap
}
