#ifndef __M_UTILS__
#define __M_UTILS__
/**
 * @file   utils.h
 * @author Adenilson Cavalcanti
 * @date   Thu Dec  9 11:00:08 2010
 *
 * @brief  Some utils for setting device orientation, etc.
 *
 */

class QMetaObject;
class QStringList;

namespace Utils {

typedef enum { PORTRAIT, LANDSCAPE, AUTO } Orientation;
typedef enum { LINUX, SYMBIAN, WINDOWS } Environment;


static const char PropertyPrefix[] = "db_";

void setOrientation(const Orientation &arg = PORTRAIT);

void extractObjectProperties(const QMetaObject *object,
			     QStringList *list,
			     bool cleanup = false,
			     const char *prefix = PropertyPrefix);

int environment();

};

#endif
