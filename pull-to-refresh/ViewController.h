/*
 * Copyright (c) 2012 Mario Negro. All Rights Reserved
 *
 * This software is the confidential and proprietary information of
 * Mario Negro ("Confidential Information"). You shall not disclose such
 * Confidential Information and shall use it only in accordance with
 * the terms of the license agreement you entered into with Mario Negro.
 */

#import <Foundation/Foundation.h>

#import "MNMPullToRefreshManager.h"

/**
 * 
 */
@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MNMPullToRefreshManagerClient>

@end
