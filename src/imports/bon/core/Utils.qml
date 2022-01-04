pragma Singleton
import QtQuick
import "../lib/BigEval.min.js" as BigEval

QtObject {
    property var icons: loadIcons(Qt.resolvedUrl("../fonts/mdicons/MaterialIconsRound.codepoints"));

    function loadIcons(url) {
        var request = new XMLHttpRequest();
        request.open("GET", url, false);
        request.send(null);
        var codepointsText = request.responseText;
        var lines = codepointsText.split("\n");
        var tmpCodepoints = {};
        lines.forEach(function (line) {
            var split = line.split(" ");
            var name = split[0];
            var codepoint = split[1];
            if (name.length > 0 && codepoint.length > 0) {
                var character = String.fromCodePoint("0x" + codepoint);
                tmpCodepoints[name] = character;
            }
        });

        return tmpCodepoints;
    }

    property var bigEval: new BigEval.BigEval();
}
