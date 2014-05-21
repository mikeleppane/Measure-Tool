# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-measuretool

CONFIG += sailfishapp c++11

SOURCES += src/harbour-measuretool.cpp \
    src/logic.cpp

OTHER_FILES += qml/harbour-measuretool.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-measuretool.changes.in \
    rpm/harbour-measuretool.spec \
    rpm/harbour-measuretool.yaml \
    translations/*.ts \
    harbour-measuretool.desktop \
    qml/pages/MainPage.qml \
    qml/pages/content/Marker.qml \
    qml/pages/scripts/MeasuretoolDB.js \
    qml/pages/AboutPage.qml \
    qml/pages/OptionsPage.qml \
    qml/pages/scripts/Calculations.js \
    qml/pages/scripts/Vars.js \
    qml/pages/ImagePage.qml

# to disable building translations every time, comment out the
# following CONFIG line
#CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-measuretool-de.ts

HEADERS += \
    src/logic.h

RESOURCES += \
    MyResource.qrc
