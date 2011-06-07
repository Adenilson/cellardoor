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

void setOrientation(const Orientation &arg = PORTRAIT);

void extractObjectProperties(const QMetaObject *object,
			     QStringList *list,
			     const char *prefix = "db_");

};

#endif
