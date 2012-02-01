#ifndef __QML_PROFILER_HELPER__
#define __QML_PROFILER_HELPER__

#if defined(QMLJSDEBUGGER) && QT_VERSION < 0x040800
#include <qt_private/qdeclarativedebughelper_p.h>
#if !defined(NO_JSDEBUGGER)
#include <jsdebuggeragent.h>
#endif

#if !defined(NO_QMLOBSERVER)
#include <qdeclarativeviewobserver.h>
#endif

// Enable debugging before any QDeclarativeEngine is created
struct QmlJsDebuggingEnabler
{
    QmlJsDebuggingEnabler()
    {
        QDeclarativeDebugHelper::enableDebugging();
    }
};

// Execute code in constructor before first QDeclarativeEngine is instantiated
static QmlJsDebuggingEnabler enableDebuggingHelper;

#endif // QMLJSDEBUGGER

static void startProfiler(QDeclarativeView *parent, QDeclarativeEngine *engine)
{
    // Qt versions prior to 4.8.0 don't have QML/JS debugging services built in
#if defined(QMLJSDEBUGGER) && QT_VERSION < 0x040800
#if !defined(NO_JSDEBUGGER)
    new QmlJSDebugger::JSDebuggerAgent(engine);
#endif
#if !defined(NO_QMLOBSERVER)
    new QmlJSDebugger::QDeclarativeViewObserver(parent, parent);
#endif
#endif
}

#endif
