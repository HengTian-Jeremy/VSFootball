//
//  VSFContacts.h
//  VsFootball
//
//  Created by hjy on 8/7/13.
//  Copyright (c) 2013 engagemobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface VSFContacts : NSObject {
    CFErrorRef error;
    ABAddressBookRef addressBook;
}

@property (nonatomic, retain) NSMutableArray *contactsArray;

@end
