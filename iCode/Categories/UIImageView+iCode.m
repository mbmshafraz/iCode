//
//  UIImageView+iCode.m
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

#import "UIImageView+iCode.h"

@implementation UIImageView (iCode)

- (void)setImageWithoutStrach:(UIImage *)image
{
    
    CGRect frame = self.frame;
    
    CGFloat frameWidth = frame.size.width;
    CGFloat frameHeight = frame.size.height;
    CGFloat imageWidthHeightRasio = image.size.width / image.size.height;
    CGFloat mult = (frameWidth / imageWidthHeightRasio) < frameHeight
    ? (frameWidth / imageWidthHeightRasio) : frameHeight;
    
    frame.size.width = mult * imageWidthHeightRasio;
    frame.size.height = mult;
    
    frame.origin.x = frame.origin.x + (frameWidth - frame.size.width) / 2;
    frame.origin.y = frame.origin.y + (frameHeight - frame.size.height) / 2;
    
    self.image = image;
    
    self.frame = frame;
}

- (void)imageWithURLString:(NSString *)urlString {
    [self imageWithURL:[NSURL URLWithString:urlString]];
}

- (void)imageWithURL:(NSURL *)url {
    [self imageWithURL:url andPlaceholderImage:nil];
}

- (void)imageWithURL:(NSURL *)url andPlaceholderImage:(UIImage *)placeholder
{
    self.image = placeholder;
    
    //    if (!url) return;
    
    [self imageWithURL:url placeholderImage:placeholder completionHandler:^(NSURLResponse *response, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"Error %@",connectionError);
        }
    }];
}

- (void)imageWithURLString:(NSString *)urlString andPlaceholderImage:(UIImage *)placeholder
{
    [self imageWithURL:urlString ? [NSURL URLWithString:urlString] : nil andPlaceholderImage:placeholder];
}

- (void)imageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completionHandler:(void(^)(NSURLResponse *response, NSError *connectionError)) completionhandler {
    
    self.image = placeholder;
    
    //if (!url) return;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(!connectionError) {
            self.image = [[UIImage alloc] initWithData:data];
        }
        completionhandler(response,connectionError);
        
    }];
}

- (void)imageWithURLString:(NSString *)urlString placeholderImage:(UIImage *)placeholder completionHandler:(void(^)(NSURLResponse *response, NSError *connectionError)) completionHandler {
    [self imageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholder completionHandler:completionHandler];
}
@end
