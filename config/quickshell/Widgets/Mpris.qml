import Quickshell.Services.Mpris

import QtQuick
import QtQuick.Layouts

import "../config.js" as Config

RowLayout {
	id: root

	// Fix this function sometime later
	function pickPlayer(players) {
		for (let i = 0; i < players.length; i++) {
			if (players[i].dbusName == "org.mpris.MediaPlayer2.playerctld") return players [i]
		}

		return players[0]
	}

	property var players: Mpris.players.values

	property MprisPlayer activePlayer: root.pickPlayer(root.players)

	property string trackTitle: activePlayer.trackTitle
	property string trackArtist: activePlayer.trackArtist
	property string trackAlbum: activePlayer.trackAlbum
	property string trackArtUrl: activePlayer.trackArtUrl

	Text {
		text: root.trackTitle + " - " + root.trackArtist
		color: `#${Config.palette.base05}`
		font: Config.font
	}

	// An image looks way too small on a bar, I'm gonna add this back when I do a popup
	// Image {
	// 	source: root.trackArtUrl
	// 	Layout.fillHeight: true
	// 	Layout.preferredWidth: 30
	// }
}
