//
//  AddToDoViewController.m
//  Every-Do-It-Again
//
//  Created by Dave Augerinos on 2017-03-01.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "AddToDoViewController.h"

@interface AddToDoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation AddToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    // Update the user interface for the detail item.
    self.titleTextField.layer.borderWidth = 0.5;
    self.priorityTextField.layer.borderWidth = 0.5;
    self.descriptionTextView.layer.borderWidth = 0.5;
}

- (IBAction)addButtonPressed:(UIButton *)sender {

    [self addNewToDo];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addNewToDo {
    
    if(![self.titleLabel.text isEqualToString: @""] && ![self.priorityTextField.text isEqualToString: @""] && ![self.descriptionTextView.text isEqualToString: @""] ) {
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDo" inManagedObjectContext:self.managedObjectContext];
        
        NSManagedObject *todo = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        
        NSNumber *priority = [NSNumber numberWithInt:[self.priorityTextField.text intValue]];
        
        [todo setValue:self.titleTextField.text forKey:@"title"];
        [todo setValue:priority forKey:@"priority"];
        [todo setValue:self.descriptionTextView.text forKey:@"todoDescription"];
        
        [self.managedObjectContext save:nil];
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewToDo) name:UITextFieldTextDidChangeNotification object:nil];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view endEditing:YES];
    
    [self addNewToDo];
    
    return NO;
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,-110,self.view.frame.size.width,self.view.frame.size.height)];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.titleTextField resignFirstResponder];
    [self.priorityTextField resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
}

@end
