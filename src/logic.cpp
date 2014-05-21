#include "logic.h"
#include <QFile>
#include <QFileInfo>
#include <QString>

Logic::Logic(QObject *parent) : QObject(parent) {}

void Logic::removeImage(const QString &image) const
{
    QFile file(image);
    if (file.exists()) {
        file.remove();
    }
}

void Logic::removeAllImages(const QList<QString> &images) const
{
    for (const auto &image : images) {
        QFile file(image);
        if (file.exists()) {
            file.remove();
        }
    }
}
