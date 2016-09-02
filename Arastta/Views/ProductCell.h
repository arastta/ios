//
//  ProductCell.h
//  Arastta
//
//  Created by Ayhan Dorman on 11/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgProductImage;
@property (strong, nonatomic) IBOutlet UILabel *lblProductName;
@property (strong, nonatomic) IBOutlet UILabel *lblProductPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblProductId;
@property (strong, nonatomic) IBOutlet UILabel *lblProductQuantity;
@property (strong, nonatomic) IBOutlet UILabel *lblProductModel;
@property (strong, nonatomic) IBOutlet UILabel *lblProductStatus;

@end
