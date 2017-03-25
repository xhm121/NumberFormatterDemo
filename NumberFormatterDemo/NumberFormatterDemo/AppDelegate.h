//
//  AppDelegate.h
//  NumberFormatterDemo
//
//  Created by 121 on 2017/3/25.
//  Copyright © 2017年 121. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

