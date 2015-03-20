//
// SettingsViewController.h
//
// Created by Csongor Nagy on 30/01/15.
// Copyright (c) 2014 PubNative
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (nonatomic, weak) NSObject<SettingsViewControllerDelegate>    *delegate;
@property (nonatomic, strong) NSMutableDictionary                       *settings;
@property (nonatomic, strong) PNAdRequestParameters                     *parameters;

@end

@implementation SettingsViewController

- (instancetype)initWitParams:(PNAdRequestParameters*)parameters andDelegate:(id<SettingsViewControllerDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.parameters = parameters;
        self.delegate = delegate;
    }
    return self;
}


#pragma mark - View Lifecycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeForm];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}



#pragma mark - Form

- (void)initializeForm
{
    XLFormDescriptor *formDescriptor = [XLFormDescriptor formDescriptor];
    XLFormSectionDescriptor *section;
    XLFormRowDescriptor *row;
    
    formDescriptor.assignFirstResponderOnShow = YES;
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@""];
    [formDescriptor addFormSection:section];
    
    // App Token
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"app_token" rowType:XLFormRowDescriptorTypeText title:@"App Token"];
    row.required = YES;
    row.value = self.parameters.app_token;
    [section addFormRow:row];
    
    // OS
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"os" rowType:XLFormRowDescriptorTypeText title:@"OS"];
    row.required = YES;
    row.value = self.parameters.os;
    [section addFormRow:row];
    
    // OS Version
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"os_version" rowType:XLFormRowDescriptorTypeText title:@"OS version"];
    row.required = YES;
    row.value = self.parameters.os_version;
    [section addFormRow:row];
    
    // Device Model
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"device_model" rowType:XLFormRowDescriptorTypeText title:@"Device Model"];
    row.required = YES;
    row.value = self.parameters.device_model;
    [section addFormRow:row];
    
    // Device Type
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"device_type" rowType:XLFormRowDescriptorTypeText title:@"Device Type"];
    row.required = YES;
    row.value = self.parameters.device_type;
    [section addFormRow:row];
    
    // Device resolution
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"device_resolution" rowType:XLFormRowDescriptorTypeText title:@"Device Resolution"];
    row.required = YES;
    row.value = self.parameters.device_resolution;
    [section addFormRow:row];
    
    // Locale
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"locale" rowType:XLFormRowDescriptorTypeText title:@"Locale"];
    row.required = YES;
    row.value = self.parameters.locale;
    [section addFormRow:row];
    
    // Cancel Button
    XLFormRowDescriptor * cancelButtonRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"cancelButton" rowType:XLFormRowDescriptorTypeButton title:@"Cancel"];
    [cancelButtonRow.cellConfigAtConfigure setObject:self.view.tintColor forKey:@"textLabel.textColor"];
    [section addFormRow:cancelButtonRow];
    
    // reset Button
    XLFormRowDescriptor * resetButtonRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"resetButton" rowType:XLFormRowDescriptorTypeButton title:@"Reset to defaults"];
    [resetButtonRow.cellConfigAtConfigure setObject:self.view.tintColor forKey:@"textLabel.textColor"];
    [section addFormRow:resetButtonRow];
    
    // Save Button
    XLFormRowDescriptor * buttonRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"saveButton" rowType:XLFormRowDescriptorTypeButton title:@"Save"];
    [buttonRow.cellConfigAtConfigure setObject:self.view.tintColor forKey:@"textLabel.textColor"];
    [section addFormRow:buttonRow];
    
    // Clean Cache
    XLFormRowDescriptor * cleanCacheRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"cleanCacheButton"
                                                                                rowType:XLFormRowDescriptorTypeButton
                                                                                  title:@"Clean Cache"];
    [section addFormRow:cleanCacheRow];
    
    section = [XLFormSectionDescriptor formSection];
    [formDescriptor addFormSection:section];
    
    
    self.form = formDescriptor;
}

- (void)didSelectFormRow:(XLFormRowDescriptor *)formRow
{
    [super didSelectFormRow:formRow];
    
    if ([formRow.tag isEqual:@"saveButton"])
    {
        NSArray * validationErrors = [self formValidationErrors];
        
        if (validationErrors.count > 0)
        {
            NSError *error = [validationErrors firstObject];
            [self showFormValidationError:error];
            return;
        }
        else
        {
            self.parameters = [PNAdRequestParameters requestParameters];
            
            for (id key in self.formValues)
            {
                NSString* setMethod = [NSString stringWithFormat:@"set%@:",
                                       [key stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                    withString:[[key substringToIndex:1] uppercaseString]]];
                SEL setSelector = NSSelectorFromString(setMethod);
                if ([self.parameters respondsToSelector:setSelector])
                {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    [self.parameters performSelector:setSelector withObject:[self.formValues objectForKey:key]];
#pragma clang diagnostic pop
                }
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(willCloseWithParams:)])
            {
                [self.delegate willCloseWithParams:self.parameters];
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else if ([formRow.tag isEqual:@"resetButton"])
    {
        self.parameters = nil;
        self.parameters = [PNAdRequestParameters requestParameters];
        [self.parameters fillWithDefaults];
        [self initializeForm];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
    else if ([formRow.tag isEqual:@"cancelButton"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if ([formRow.tag isEqual:@"cleanCacheButton"])
    {
        [PNCroissantCache cleanCache];
        [PNVideoCacher cleanCache];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
