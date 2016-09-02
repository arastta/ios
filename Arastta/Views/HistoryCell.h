//
//  HistoryCellTableViewCell.h
//  Arastta
//
//  Created by Ayhan Dorman on 27/07/16.
//  Copyright © 2016 Arastta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblDateAdded;

@end
