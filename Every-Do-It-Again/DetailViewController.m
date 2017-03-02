//
//  DetailViewController.m
//  Every-Do-It-Again
//
//  Created by Dave Augerinos on 2017-03-01.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.titleTextField.text = self.detailItem.title;
        self.priorityTextField.text = [NSString stringWithFormat: @"%i", self.detailItem.priority];
        self.descriptionTextView.text = self.detailItem.todoDescription;
    }
    
    self.titleTextField.layer.borderWidth = 0.5;
    self.priorityTextField.layer.borderWidth = 0.5;
    self.descriptionTextView.layer.borderWidth = 0.5;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(ToDo *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

@end
