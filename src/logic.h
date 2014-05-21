#ifndef LOGIC_H
#define LOGIC_H

#include <QObject>
#include <QtGlobal>
#include <QtCore/qmath.h>
#include <QtCore/QtMath>
#include <QList>

class QString;

class Logic : public QObject
{
    Q_OBJECT
public:
    explicit Logic(QObject *parent = 0);

    Q_INVOKABLE void removeImage(const QString&) const;
    Q_INVOKABLE void removeAllImages(const QList<QString> &) const;

    Q_INVOKABLE inline qreal calculateDistance(qreal angle, qreal dist) const {
        return qTan(qDegreesToRadians(qAbs(angle))) * dist;}
};

#endif // LOGIC_H
