import QtQuick 2.0

Item {
	id: page
	width: 1050
	height: 1680

	signal next()

	property int targetCoiffe: 1

	property bool coif1OK: controler.capteur1 ^ (targetCoiffe != 1)
	property bool coif2OK: controler.capteur2 ^ (targetCoiffe != 2)
	property bool coif3OK: controler.capteur3 ^ (targetCoiffe != 3)

	property bool coiffAllOff: !controler.capteur1 && !controler.capteur2 && !controler.capteur3
	property bool coiffAllGood: coif1OK && coif2OK && coif3OK

	function onButtonPressed() {
		if (!coiffAllOff && coiffAllGood)
			page.next()
	}

	TitleText {
		anchors.centerIn: parent
		width: 800
		text: "Vous pouvez maintenant prendre votre coiffe"

		Binding on text {
			when: coiffAllOff
			value: "Vous pouvez maintenant prendre votre coiffe"
		}

		Binding on text {
			when: !coiffAllOff && coiffAllGood
			value: "Non! j'ai dit la coiffe"
		}

		Binding on text {
			when: !coiffAllOff && coiffAllGood
			value: "merci"
		}

	}

	SuiteButton {
		visible: !coiffAllOff && coiffAllGood
	}
}
