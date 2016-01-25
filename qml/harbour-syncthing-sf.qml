/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

import org.nemomobile.dbus 2.0
import SyncConnector 1.0

ApplicationWindow
{
    SyncConnector {
        id: sc
        Component.onCompleted: {
            console.log("Folders", sc.folders);
            console.log("Files", sc.files);
        }
    }
    DBusInterface {
        id: syncthing_service

        service: "org.freedesktop.systemd1"
        path: "/org/freedesktop/systemd1/unit/syncthing_2eservice"
        iface: "org.freedesktop.systemd1.Unit"

        property string state: getProperty("ActiveState")

        function toggle() {
            syncthing_service.call(
            syncthing_service.state != "active" ? "Start" : "Stop"
            , ["replace"])
            syncthing_service.state = syncthing_service.getProperty("ActiveState")
        }
        Component.onCompleted: console.log(state)

    }
    DBusInterface {
        id: connmans_wifi

        service: "net.connman"
        path: "/net/connman/technology/wifi"
        iface: "net.connman.Technology"

        property var props: getProperty("GetProperties")

        Component.onCompleted: console.log(props)

    }

    //    Item {
    //        id:sc
    //        property string status: "dummy"
    //        property ListModel folders: foldersLM
    //        property ListModel files: filesLM
    //        ListModel {
    //            id: foldersLM
    //            ListElement {name: "folder1"; path: "path/top"}
    //            ListElement {name: "folder1"; path: "path/top"}
    //        }
    //        ListModel {
    //            id: filesLM
    //            ListElement {name: "file1"; path: "path/top"}
    //            ListElement {name: "file2"; path: "path/top"}
    //        }
    //        Component.onCompleted: {
    //            console.log("Folders", sc.folders);
    //            console.log("Files", sc.files);
    //        }
    //    }

    id: app
    property string sTstatus: sc.status

    initialPage: Component { FirstPage { id: fp } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All
}

