//
//  CategoryListDataObject.h
//  simpletest
//
//  Created by Prince Wang on 2021/3/5.
//

#ifndef CategoryListDataObject_h
#define CategoryListDataObject_h


#endif /* CategoryList_h */

// To parse this JSON:
//
//   NSError *error;
//   CategoryListDataObject *categoryListDataObject = [CategoryListDataObject fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class CategoryListDataObject;
@class Data;
@class ShopCategoryList;
@class CategoryList;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface CategoryListDataObject : NSObject
@property (nonatomic, strong) Data *data;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface Data : NSObject
@property (nonatomic, strong) ShopCategoryList *shopCategoryList;
@end

@interface ShopCategoryList : NSObject
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy)   NSArray<CategoryList *> *categoryList;
@end

@interface CategoryList : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *name;
@end

NS_ASSUME_NONNULL_END
