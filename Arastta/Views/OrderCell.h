//
//  OrderCell.h
//  Arastta
//
//  Created by Ayhan Dorman on 30/06/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblOrderId;
@property (strong, nonatomic) IBOutlet UILabel *lblCustomerName;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderDate;
@property (strong, nonatomic) IBOutlet UILabel *lblCustomerId;
@property (strong, nonatomic) IBOutlet UILabel *lblProductCount;

@end
