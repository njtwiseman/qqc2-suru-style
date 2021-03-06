/****************************************************************************
**
** Copyright (C) 2017, 2018 Stefano Verzegnassi <stefano@ubports.com>
** Copyright (C) 2017 The Qt Company Ltd.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
****************************************************************************/

import QtQuick 2.9
import QtQuick.Templates 2.2 as T
import QtQuick.Controls.Suru 2.2

T.ProgressBar {
    id: control

    implicitWidth: Math.max(background ? background.implicitWidth : 0,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(background ? background.implicitHeight : 0,
                             contentItem.implicitHeight + topPadding + bottomPadding)

    opacity: control.enabled ? 1.0 : 0.5

    contentItem: Item {
        id: contentItem
        clip: true

        Rectangle {
            id: thumb
            implicitWidth: (control.indeterminate ? 0.25 : control.position) * contentItem.width
            implicitHeight: control.Suru.units.dp(3)
            color: control.Suru.highlightColor

            SequentialAnimation {
                running: control.indeterminate
                loops: Animation.Infinite

                XAnimator {
                    target: thumb
                    from: -thumb.width;
                    to: contentItem.width
                    duration: control.Suru.animations.SleepyDuration
                    easing: control.Suru.animations.EasingInOut
                }

                XAnimator {
                    target: thumb
                    from: contentItem.width
                    to: -thumb.width
                    duration: control.Suru.animations.SleepyDuration
                    easing: control.Suru.animations.EasingInOut
                }
            }
        }
    }

    background: Rectangle {
        implicitWidth: control.Suru.units.gu(32)
        implicitHeight: control.Suru.units.dp(3)

        x: control.leftPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: control.availableWidth
        height: control.Suru.units.dp(3)
        color: control.Suru.neutralColor
    }
}
