import QtQuick 2.0
import QtMultimedia 5.9

Item {
	id: camview
	width: 1050
	height: 1680

	property bool active: false

	signal next()

	function reset() {
		txtover.visible = false
		txtover.text = ""
		camview.active = true
		timer.count = 3
	}

	function takePhoto() {
		camera.searchAndLock();
		camera.imageCapture.captureToLocation("msx_booth/photo.jpg")
		camera.unlock();
	}

	function photoTimeout() {
		//if (! camview.active)
		//	return
		txtover.visible = true
		txtover.text = "3"
		timer.count = 2
		timer.repeat = true
		timer.restart()
	}

	Camera {
		id: camera

		imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

		exposure {
			exposureCompensation: -1.0
			exposureMode: Camera.ExposurePortrait
		}

		flash.mode: Camera.FlashRedEyeReduction
		captureMode: Camera.CaptureViewfinder

		imageCapture {
			onImageCaptured: {
				photoPreview.source = preview  // Show the preview in an Image
			}
		}
	}

	VideoOutput {
		source: camera
		anchors.fill: photoPreview
		focus : visible // to receive focus and capture key events when visible
		fillMode: Image.PreserveAspectCrop
	}

	Image {
		id: photoPreview
		width: 1000
		height: 1000
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		fillMode: Image.PreserveAspectCrop

		TitleText {
			id: txtover
			anchors.centerIn: parent
			visible: false
			text: "3"
			color: "white"
			style: Text.Outline
			font {
				pixelSize: 200
			}
		}
	}

	Timer {
		id: timer
		property int count: 666
		interval: 1000;  repeat: true
		running: false
		onTriggered: {
			if (count  === -1) {
				camview.next()
				timer.repeat = false
			} else if (count === 0) {
				txtover.text = "Souriez !"
				camview.takePhoto()
			} else {
				txtover.text = count
			}
			count = count -1
		}
	}

	PushButton {
		id: button
		anchors {
			bottom: parent.bottom
			horizontalCenter: parent.horizontalCenter
		}
		radius: 150
		anchors.bottomMargin: 50
		color: "yellow"
		onClicked: photoTimeout()
	}

	Connections {
		target: controler
		onButton1Pressed: photoTimeout()
		onButton2Pressed: photoTimeout()
		onButton3Pressed: photoTimeout()
	}
}
