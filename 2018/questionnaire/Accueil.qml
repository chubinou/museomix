import QtQuick 2.0

Item {
	id: root
	width: 1050
	height: 1680

	signal next();

	TitleText  {
		width: 898
		height: 721
		anchors.centerIn: parent
		font.pixelSize: 80
		text: "Et si vous aviez ete une femme au 19e siecle, voici ce que vous auriez du porter"
	}

	SuiteButton {}
}
