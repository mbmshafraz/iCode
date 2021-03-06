//
//  iCode.h
//  iCode
//
/*
 
 Copyright (c) 2012, Shafraz Buhary
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the Copyright holder  nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 */

#import <Foundation/Foundation.h>
#import "iCTheme.h"
#import "iCAppConfig.h"
#import "UIApplication+iCode.h"
#import "NSString+iCode.h"
#import "NSData+iCode.h"
#import "NSObject+iCode.h"
#import "UIColor+iCode.h"
#import "UIImage+iCode.h"
#import "UIImageView+iCode.h"
#import "UINavigationController+iCode.h"
#import "UITabBar+iCode.h"
#import "UIView+iCode.h"
#import "UIButton+iCode.h"
#import "NSDate+iCode.h"

#define iCCurrentMethodNameWithCommet(comment) NSLog(@"%@ %s",comment,__PRETTY_FUNCTION__)
#define iCCurrentMethodNameWith NSLog(@"%s",__PRETTY_FUNCTION__)

#ifdef DEBUG
#define iCLog(args...) NSLog(@"\n\n===== %s =====\n LINE    : %d \n MESSAGE : %@ \n==== End Log ====\n\n",__PRETTY_FUNCTION__,__LINE__,[NSString stringWithFormat:args])
#else
#define iCLog(args...)
#endif
