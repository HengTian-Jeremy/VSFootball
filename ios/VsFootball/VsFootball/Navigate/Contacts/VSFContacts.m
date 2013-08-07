//
//  VSFContacts.m
//  VsFootball
//
//  Created by hjy on 8/7/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import "VSFContacts.h"
#import "VSFContactsEntity.h"

@interface VSFContacts ()

- (void)readAllContacts;

@end

@implementation VSFContacts
@synthesize contactsArray;

- (id)init
{
    self = [super init];
    if (self) {
        contactsArray = [[NSMutableArray alloc] init];
        error = NULL;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0){
            addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
                if (granted) {
                    [self readAllContacts];
                }
            });

        }else{
            addressBook = ABAddressBookCreate();
            [self readAllContacts];
        }
    }
    return self;
}

- (void)readAllContacts
{
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    for (int i = 0; i < CFArrayGetCount(results); i ++) {
        VSFContactsEntity *contactsEntity = [[VSFContactsEntity alloc] init];
        
        ABRecordRef person = CFArrayGetValueAtIndex(results, i);
        // Read first name
        NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        if (firstName != nil) {
            contactsEntity.firstName = firstName;
        }
        
        // Read last name
        NSString *lastName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
        if (lastName != nil) {
            contactsEntity.lastName = lastName;
        }
        
        // Read email
        ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
        int emailCount = ABMultiValueGetCount(email);
        if (emailCount > 0) {
            NSString *emailContent = (__bridge NSString *)ABMultiValueCopyValueAtIndex(email, 0);
            contactsEntity.email = emailContent;
        }
        
        [contactsArray addObject:contactsEntity];
    }
}

@end
