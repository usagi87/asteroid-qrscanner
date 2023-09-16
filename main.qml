/*
 * Copyright (C) 2020 Chandler Swift <chandler@chandlerswift.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.9
import org.asteroid.controls 1.0
import Qt.labs.folderlistmodel 2.1
import QRCode 1.0

Application {
    id: app
	
    centerColor: folderModel.count > 0 ? "#31bee7" : "#31bee7"
    outerColor:  folderModel.count > 0 ? "#052442": "#052442"

	property var qrtext:""

QRCode {
	id:qrcode
}

FolderListModel {
        id: folderModel
        folder: "file:///home/ceres/Pictures"
        nameFilters: ["*.jpg"]
        sortField: FolderListModel.Time
        sortReversed: false
        showDirs: false
}

LayerStack {
   	id: layerStack
		firstPage: folderPage 
}
	
    
    
Component {
	id: photoDelegate
    Item {
    	id:rootM
    	width: app.width
        height: app.height
		Image {
        	anchors.verticalCenter:parent.verticalCenter
        	anchors.horizontalCenter:parent.horizontalCenter
            source: fileUrl
            width: 300
            height: 300
            fillMode: Image.Stretch
		}
		Label {
        	text: fileName
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: Dims.h(33)
            font.pixelSize: Dims.l(6)
            font.bold: true
	    }
		IconButton {
        	iconName: "ios-checkmark-circle-outline"
            anchors {
            	horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height * 0.05
            }
            
            onClicked:{
            	qrtext = qrcode.readQRCodeTest("/home/ceres/Pictures/" + fileName);
            	layerStack.push(qrCodePage)
            } 
		}
	}

}

Component {
	id:folderPage
	Item{
		id:rootM
		ListView {
            id: lv
            anchors.fill: parent
            model: folderModel
            delegate: photoDelegate
            orientation: ListView.Horizontal
            snapMode: ListView.SnapToItem
            highlightRangeMode: ListView.StrictlyEnforceRange
            //onCurrentIndexChanged: inEditMode = false
		}
	}
}


Component {
	id:qrCodePage	  	
	Item {
		id:rootM
		
		Rectangle {
			id:textLine
        	width : 300
        	height: 300
        	border.color : "Black"
			border.width : 2
			anchors.verticalCenter : parent.verticalCenter
			anchors.horizontalCenter : parent.horizontalCenter
        }
		
		Flickable {
			id: flickable1
			anchors.verticalCenter : parent.verticalCenter
        	anchors.horizontalCenter : parent.horizontalCenter
			clip: true
        	height: 300
        	width: 300
        	contentWidth: 300
        	contentHeight:300  
        	
        	Text {
        		id: qrcodeTxt
        		//textFormat:Text.MarkdownText
            	text: qrtext
            	anchors.left: parent.left
            	anchors.right: parent.right
            	font.pixelSize: Dims.h(5)
        		wrapMode: Text.Wrap
        		elide: Text.ElideRight
        		maximumLineCount: 100000
           	}		
       	}
		
		IconButton {
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top:flickable1.bottom
			width: Dims.l(20)
    		height: width
			iconName: "ios-checkmark-circle-outline"
			onClicked: { 
				layerStack.pop(rootM)
								
 			}
		}
	}
}


}

