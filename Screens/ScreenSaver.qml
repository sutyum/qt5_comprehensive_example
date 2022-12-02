import QtQuick 2.15
import QtQuick.Window 2.15

// black background with a small rectangle that shows up in random 
// locations, with animation, looks like a floating rectangle

Rectangle {
   id: root
   color: "black"

   Timer {
       id: timer
       interval: 500
       repeat: true
       running: root.visible
       onTriggered: {
           bounceBox.x = Math.floor(Math.random() * (root.width - bounceBox.width))
           bounceBox.y = Math.floor(Math.random() * (root.height - bounceBox.height))
       }
   }

   Rectangle {
       id: bounceBox
       width: 60; height: 60
       x: (root.width - bounceBox.width) / 2
       y: (root.height - bounceBox.height) / 2
       color: "red"
       Behavior on x {
           NumberAnimation { duration: 750 }
       }
       Behavior on y {
           NumberAnimation { duration: 750 }
       }
   }
}

