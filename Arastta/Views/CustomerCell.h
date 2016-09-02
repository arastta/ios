//
//  CustomerCell.h
//  Arastta
//
//  Created by Ayhan Dorman on 29/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblCustomerName;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblOrders;
@property (strong, nonatomic) IBOutlet UILabel *lblCustomerId;
@property (strong, nonatomic) IBOutlet UILabel *lblRegistered;

@end
