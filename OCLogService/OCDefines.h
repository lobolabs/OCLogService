//
//  OCDefines.h
//  OCLogService
//
//  Created by Dmitry Fantastik on 11/16/13.
//  Copyright (c) 2013 fantastik. All rights reserved.
//

#ifndef OCLogService_OCDefines_h
#define OCLogService_OCDefines_h

#if defined(__has_feature) && defined(__has_attribute)
    #if __has_attribute(unavailable)
        #define ATTR_UNAVAILABLE __attribute__((unavailable))
        #if __has_feature(attribute_unavailable_with_message)
            #define ATTR_UNAVAILABLE_MSG(s) __attribute__((unavailable(s)))
        #else
            #define ATTR_UNAVAILABLE_MSG(s) __attribute__((unavailable))
        #endif
    #else
        #define ATTR_UNAVAILABLE
        #define ATTR_UNAVAILABLE_MSG(s)
    #endif
#elif defined(__GNUC__) && ((__GNUC__ >= 4) || ((__GNUC__ == 3) && (__GNUC_MINOR__ >= 1)))
    #define ATTR_UNAVAILABLE __attribute__((unavailable))
    #if (__GNUC__ >= 5) || ((__GNUC__ == 4) && (__GNUC_MINOR__ >= 5))
        #define ATTR_UNAVAILABLE_MSG(s) __attribute__((unavailable(s)))
    #else
        #define ATTR_UNAVAILABLE_MSG(s) __attribute__((unavailable))
    #endif
#else
    #define ATTR_UNAVAILABLE
    #define ATTR_UNAVAILABLE_MSG(s)
#endif

#endif
