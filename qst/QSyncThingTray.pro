HEADERS       = window.h \
                syncconnector.h \
                platforms/darwin/macUtils.hpp \
                platforms/windows/winUtils.hpp \
                platforms/linux/posixUtils.hpp \
                processmonitor.hpp \
                platforms.hpp \
                apihandler.hpp \
                startuptab.hpp \
                utilities.hpp \
                syncwebview.h \
                syncwebpage.h
SOURCES       = main.cpp \
                window.cpp \
                syncconnector.cpp \
                processmonitor.cpp \
                startuptab.cpp \
                syncwebview.cpp \
                syncwebpage.cpp
RESOURCES     = \
                qsyncthing.qrc

QT += widgets
QT += network
QT += webenginewidgets

# install
target.path = binary/
INSTALLS += target
CONFIG += c++11
macx {
QMAKE_INFO_PLIST = Info.plist
LIBS += -framework ApplicationServices
}
#QMAKE_CXXFLAGS += /wd4996
ICON = Syncthing.icns
macx {
APP_BINARY_FILES.files = resources/mac/syncthing-inotify
APP_BINARY_FILES.path = Contents/Resources
QMAKE_BUNDLE_DATA += APP_BINARY_FILES
}
