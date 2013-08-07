//
//  VSFFeedBackProcess.h
//  VsFootball
//
//  Created by hjy on 8/2/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VSFNetwork;
@class VSFResponseEntity;

/*!
    @protocol VSFFeedbackProcessDelegate
 
    @abstract Feed back process delegate
 
    @discussion Feed back process delegate
*/
@protocol VSFFeedbackProcessDelegate <NSObject>
/*!
    @method setFeedbackResult:
    @abstract set the response data to delegate
    @discussion set the response data to delegate
    @param respEntity VSFResponseEntity Entity
    @result void
*/
- (void)setFeedbackResult:(VSFResponseEntity *)respEntity;
@end

/*!
    @class VSFFeedBackProcess
 
    @abstract Feed back processor
 
    @discussion Feed back processor
*/
@interface VSFFeedBackProcess : NSObject {
    VSFNetwork *feedbackRequest;
}

// Response data target
@property (nonatomic, assign) id<VSFFeedbackProcessDelegate> delegate;

/*!
    @method sendFeedbackInformation:gameId:screen:
    @abstract send feed back interface
    @discussion send feed back interface
    @param comment content of the feed back
    @param gameId game id
    @param screen screen id
    @result void
*/
- (void)sendFeedbackInformation:(NSString *)comment gameId:(NSNumber *)gameId screen:(NSString *)screen;

@end
