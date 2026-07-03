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

	readonly property var players: Mpris.players.values

	readonly property MprisPlayer activePlayer: root.pickPlayer(root.players)

	readonly property string trackTitle: activePlayer.trackTitle
	readonly property string trackArtist: activePlayer.trackArtist
	readonly property string trackAlbum: activePlayer.trackAlbum
	readonly property string trackArtUrl: activePlayer.trackArtUrl

	readonly property bool playing: activePlayer.isPlaying

	readonly property string playingIcon: {
		if (!activePlayer) return ""
		if (playing) return String.fromCodePoint(0xf03e5) // Pause icon
		if (!playing) return String.fromCodePoint(0xf040c) // Play icon
	}
	readonly property string playerText: {
		if (!activePlayer) return ""
		if (trackArtist) return `${playingIcon} ${trackTitle} - ${trackArtist}`

		return `${playingIcon} ${trackTitle}`
	}

	Text {
		text: root.playerText
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
