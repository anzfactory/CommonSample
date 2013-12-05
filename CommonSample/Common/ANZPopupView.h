//
//  ANZPopupView.h
//
//  Created by ANZ on 2013/11/01.
//  Copyright (c) 2013年 ANZ Factory. All rights reserved.
//

#import <UIKit/UIKit.h>

// デリゲート
@protocol ANZPopupViewDelegate <NSObject>

@optional
- (void)didTapPositiveButton;       // yes的なボタン押したときのメソッド
- (void)didTapNegativeButton;       // no的なボタン押したときのメソッド
@end

@interface ANZPopupView : UIView

typedef enum {
    ANZPopupViewThemaDefault,    // 白色
    ANZPopupViewThemaBlack,      // 全体的に黒みがかる
    ANZPopupViewThemaBrown       // 全体的に茶色がかる
} ANZPopupViewThema;

// 下のボタンタイプ
typedef enum {
    ANZPopupviewResponseTypeYesNo,      // yes / noの二つ
    ANZPopupviewResponseTypeOnlyClose,  // ひとつのみ表示(残るのはnegativeのほう)
    ANZPopupviewResponseTypeTouchScreen // 画面タップで閉じる感じ(ボタンは非表示に)
} ANZPopupviewResponseType;

// 各パーツ：呼び出し側から編集しても良いけど、位置をいじると内部ロジックが変になるかも
@property (weak, nonatomic) IBOutlet UIView *wrapperView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UIButton *positiveButton;
@property (weak, nonatomic) IBOutlet UIButton *negativeButton;
@property (nonatomic) UILabel* messageLabel;
@property (nonatomic) UIImageView* displayImageView;

@property (nonatomic, weak) id<ANZPopupViewDelegate> delegate;
@property (nonatomic) ANZPopupViewThema thema;                      // デザインテーマ(いろんなアプリでもお手軽に使い回すなら充実させるべき)
@property (nonatomic) ANZPopupviewResponseType responseType;        // ボタンの配置

- (void)showWithTitle:(NSString *)title message:(NSString *)message positiveButtonTitle:(NSString *)positiveTitle negativeButtonTitle:(NSString *)negativeTitle;

- (void)showWithTitle:(NSString *)title image:(UIImage *)image positiveButtonTitle:(NSString *)positiveTitle negativeButtonTitle:(NSString *)negativeTitle;

// 本文もありーの、画像もありーの(未対応...(｡>ω<｡)...どうしてもってなら実装するか下のやつで代用は可能)
//- (void)showWithTitle:(NSString *)title message:(NSString *)message image:(UIImage *)image positiveButtonTitle:(NSString *)positiveTitle negativeButtonTitle:(NSString *)negativeTitle;

// こっちで用意したviewの形式じゃ無理っす的な場合
- (void)showWithCustomView:(UIView *)customView positiveButtonTitle:(NSString *)positiveTitle negativeButtonTitle:(NSString *)negativeTitle;

@end
