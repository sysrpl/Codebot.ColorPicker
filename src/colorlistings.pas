unit ColorListings;

{$mode delphi}

interface

uses
  SysUtils, Classes, Graphics,
  Codebot.System,
  Codebot.Graphics,
  Codebot.Graphics.Types;

type
  TColorPair = record
    Color: TColor;
    Name: string;
    LazName: string;
  end;

  TColorList = TArrayList<TColorPair>;

procedure BuildCommonColors(var Colors: TColorList);
procedure BuildSystemColors(var Colors: TColorList);

implementation

procedure BuildCommonColors(var Colors: TColorList);

  procedure ColorPair(Color: TColor; const Name, LazName: string);
  var
    P: TColorPair;
  begin
    P.Color := Color;
    P.Name := Name;
    P.LazName := LazName;
    Colors.Push(P);
  end;

begin
  Colors.Clear;
  ColorPair(clWhite, 'White', 'clWhite');
  ColorPair(clBlack, 'Black', 'clBlack');
  ColorPair(clMaroon, 'Maroon', 'clMaroon');
  ColorPair(clGreen, 'Green', 'clGreen');
  ColorPair(clOlive, 'Olive', 'clOlive');
  ColorPair(clNavy, 'Navy', 'clNavy');
  ColorPair(clPurple, 'Purple', 'clPurple');
  ColorPair(clTeal, 'Teal', 'clTeal');
  ColorPair(clGray, 'Gray', 'clGray');
  ColorPair(clSilver, 'Silver', 'clSilver');
  ColorPair(clRed, 'Red', 'clRed');
  ColorPair(clLime, 'Lime', 'clLime');
  ColorPair(clYellow, 'Yellow', 'clYellow');
  ColorPair(clBlue, 'Blue', 'clBlue');
  ColorPair(clFuchsia, 'Fuchsia', 'clFuchsia');
  ColorPair(clAqua, 'Aqua', 'clAqua');
  ColorPair(clLtGray, 'Light Gray', 'clLtGray');
  ColorPair(clDkGray, 'Dark  Gray', 'clDkGray');
  ColorPair(clMoneyGreen, 'Money Green', 'clMoneyGreen');
  ColorPair(clSkyBlue, 'Sky Blue', 'clSkyBlue');
  ColorPair(clCream, 'Cream', 'clCream');
  ColorPair(clMedGray, 'Medium  Gray', 'clMedGray');
  ColorPair(clAliceBlue, 'AliceBlue', 'clAliceBlue');
  ColorPair(clAntiqueWhite, 'Antique White', 'clAntiqueWhite');
  ColorPair(clAquamarine, 'Aquamarine', 'clAquamarine');
  ColorPair(clAzure, 'Azure', 'clAzure');
  ColorPair(clBeige, 'Beige', 'clBeige');
  ColorPair(clBisque, 'Bisque', 'clBisque');
  ColorPair(clBlanchedAlmond, 'Blanched Almond', 'clBlanchedAlmond');
  ColorPair(clBlueViolet, 'Blue Violet', 'clBlueViolet');
  ColorPair(clBrown, 'Brown', 'clBrown');
  ColorPair(clBurlywood, 'Burlywood', 'clBurlywood');
  ColorPair(clCadetBlue, 'Cadet Blue', 'clCadetBlue');
  ColorPair(clChartreuse, 'Chartreuse', 'clChartreuse');
  ColorPair(clChocolate, 'Chocolate', 'clChocolate');
  ColorPair(clCoral, 'Coral', 'clCoral');
  ColorPair(clCornFlowerBlue, 'Corn Flower Blue', 'clCornFlowerBlue');
  ColorPair(clCornSilk, 'Corn Silk', 'clCornSilk');
  ColorPair(clCrimson, 'Crimson', 'clCrimson');
  ColorPair(clCyan, 'Cyan', 'clCyan');
  ColorPair(clDarkBlue, 'Dark Blue', 'clDarkBlue');
  ColorPair(clDarkCyan, 'Dark Cyan', 'clDarkCyan');
  ColorPair(clDarkGoldenrod, 'Dark Goldenrod', 'clDarkGoldenrod');
  ColorPair(clDarkGray, 'Dark Gray', 'clDarkGray');
  ColorPair(clDarkGreen, 'Dark Green', 'clDarkGreen');
  ColorPair(clDarkKhaki, 'Dark Khaki', 'clDarkKhaki');
  ColorPair(clDarkMagenta, 'Dark Magenta', 'clDarkMagenta');
  ColorPair(clDarkOliveGreen, 'Dark OliveGreen', 'clDarkOliveGreen');
  ColorPair(clDarkOrange, 'Dark Orange', 'clDarkOrange');
  ColorPair(clDarkOrchid, 'Dark Orchid', 'clDarkOrchid');
  ColorPair(clDarkRed, 'Dark Red', 'clDarkRed');
  ColorPair(clDarkSalmon, 'Dark Salmon', 'clDarkSalmon');
  ColorPair(clDarkseaGreen, 'Dark Sea Green', 'clDarkseaGreen');
  ColorPair(clDarkslateBlue, 'Dark Slate Blue', 'clDarkslateBlue');
  ColorPair(clDarkSlateGray, 'Dark SlateGray', 'clDarkSlateGray');
  ColorPair(clDarkTurquoise, 'Dark Turquoise', 'clDarkTurquoise');
  ColorPair(clDarkViolet, 'Dark Violet', 'clDarkViolet');
  ColorPair(clDeepPink, 'Deep Pink', 'clDeepPink');
  ColorPair(clDeepSkyBlue, 'Deep Sky Blue', 'clDeepSkyBlue');
  ColorPair(clDimGray, 'Dim Gray', 'clDimGray');
  ColorPair(clDodgerBlue, 'Dodger Blue', 'clDodgerBlue');
  ColorPair(clFireBrick, 'Fire Brick', 'clFireBrick');
  ColorPair(clFloralWhite, 'Floral White', 'clFloralWhite');
  ColorPair(clForestGreen, 'Forest Green', 'clForestGreen');
  ColorPair(clGainsboro, 'Gainsboro', 'clGainsboro');
  ColorPair(clGhostWhite, 'Ghost White', 'clGhostWhite');
  ColorPair(clGold, 'Gold', 'clGold');
  ColorPair(clGoldenrod, 'Goldenrod', 'clGoldenrod');
  ColorPair(clGreenYellow, 'Green Yellow', 'clGreenYellow');
  ColorPair(clHoneydew, 'Honeydew', 'clHoneydew');
  ColorPair(clHotPink, 'HotPink', 'clHotPink');
  ColorPair(clIndianRed, 'IndianRed', 'clIndianRed');
  ColorPair(clIndigo, 'Indigo', 'clIndigo');
  ColorPair(clIvory, 'Ivory', 'clIvory');
  ColorPair(clKhaki, 'Khaki', 'clKhaki');
  ColorPair(clLavender, 'Lavender', 'clLavender');
  ColorPair(clLavenderBlush, 'Lavender Blush', 'clLavenderBlush');
  ColorPair(clLawnGreen, 'Lawn Green', 'clLawnGreen');
  ColorPair(clLemonChiffon, 'Lemon Chiffon', 'clLemonChiffon');
  ColorPair(clLightBlue, 'Light Blue', 'clLightBlue');
  ColorPair(clLightCoral, 'Light Coral', 'clLightCoral');
  ColorPair(clLightCyan, 'Light Cyan', 'clLightCyan');
  ColorPair(clLightGoldenrodYellow, 'Light Goldenrod Yellow', 'clLightGoldenrodYellow');
  ColorPair(clLightGreen, 'Light Green', 'clLight Green');
  ColorPair(clLightGray, 'Light Gray', 'clLight Gray');
  ColorPair(clLightPink, 'Light Pink', 'clLightPink');
  ColorPair(clLightSalmon, 'Light Salmon', 'clLightSalmon');
  ColorPair(clLightSeaGreen, 'Light Sea Green', 'clLightSeaGreen');
  ColorPair(clLightSkyBlue, 'Light Sky Blue', 'clLightSkyBlue');
  ColorPair(clLightSlateGray, 'Light Slate Gray', 'clLightSlateGray');
  ColorPair(clLightSteelBlue, 'Light Steel Blue', 'clLightSteelBlue');
  ColorPair(clLightYellow, 'Light Yellow', 'clLightYellow');
  ColorPair(clLimeGreen, 'Lime Green', 'clLimeGreen');
  ColorPair(clLinen, 'Linen', 'clLinen');
  ColorPair(clMagenta, 'Magenta', 'clMagenta');
  ColorPair(clMediumAquamarine, 'Medium  Aquamarine', 'clMedAquamarine');
  ColorPair(clMediumBlue, 'Medium Blue', 'clMedBlue');
  ColorPair(clMediumOrchid, 'Medium Orchid', 'clMedOrchid');
  ColorPair(clMediumPurple, 'Medium Purple', 'clMedPurple');
  ColorPair(clMediumSeaGreen, 'Medium Sea Green', 'clMedSeaGreen');
  ColorPair(clMediumSlateBlue, 'Medium Slate Blue', 'clMedSlateBlue');
  ColorPair(clMediumSpringGreen, 'Medium Spring Green', 'clMedSpringGreen');
  ColorPair(clMediumTurquoise, 'Medium Turquoise', 'clMedTurquoise');
  ColorPair(clMediumVioletRed, 'Medium Violet Red', 'clMedVioletRed');
  ColorPair(clMidnightBlue, 'Midnight Blue', 'clMidnightBlue');
  ColorPair(clMintCream, 'Mint Cream', 'clMintCream');
  ColorPair(clMistyRose, 'Misty Rose', 'clMistyRose');
  ColorPair(clMoccasin, 'Moccasin', 'clMoccasin');
  ColorPair(clNavajoWhite, 'Navajo White', 'clNavajoWhite');
  ColorPair(clOldLace, 'Old Lace', 'clOldLace');
  ColorPair(clOliveDrab, 'Olive Drab', 'clOliveDrab');
  ColorPair(clOrange, 'Orange', 'clOrange');
  ColorPair(clOrangeRed, 'OrangeRed', 'clOrangeRed');
  ColorPair(clOrchid, 'Orchid', 'clOrchid');
  ColorPair(clPaleGoldenrod, 'Pale Goldenrod', 'clPaleGoldenrod');
  ColorPair(clPaleGreen, 'Pale Green', 'clPaleGreen');
  ColorPair(clPaleTurquoise, 'Pale Turquoise', 'clPaleTurquoise');
  ColorPair(clPaleVioletRed, 'Pale Violet Red', 'clPalevioletRed');
  ColorPair(clPapayaWhip, 'Papaya Whip', 'clPapayaWhip');
  ColorPair(clPeachPuff, 'Peach Puff', 'clPeachPuff');
  ColorPair(clPeru, 'Peru', 'clPeru');
  ColorPair(clPink, 'Pink', 'clPink');
  ColorPair(clPlum, 'Plum', 'clPlum');
  ColorPair(clPowderBlue, 'Powder Blue', 'clPowderBlue');
  ColorPair(clRosyBrown, 'Rosy Brown', 'clRosyBrown');
  ColorPair(clRoyalBlue, 'Royal Blue', 'clRoyalBlue');
  ColorPair(clSaddleBrown, 'Saddle Brown', 'clSaddleBrown');
  ColorPair(clSalmon, 'Salmon', 'clSalmon');
  ColorPair(clSandyBrown, 'Sandy Brown', 'clSandyBrown');
  ColorPair(clSeaGreen, 'Sea Green', 'clSeaGreen');
  ColorPair(clSeaShell, 'Sea Shell', 'clSeaShell');
  ColorPair(clSienna, 'Sienna', 'clSienna');
  ColorPair(clSkyBlue, 'Sky Blue', 'clSkyBlue');
  ColorPair(clSlateBlue, 'Slate Blue', 'clSlateBlue');
  ColorPair(clSlateGray, 'Slate Gray', 'clSlateGray');
  ColorPair(clSnow, 'Snow', 'clSnow');
  ColorPair(clSpringGreen, 'Spring Green', 'clSpringGreen');
  ColorPair(clSteelBlue, 'Steel Blue', 'clSteelBlue');
  ColorPair(clTan, 'Tan', 'clTan');
  ColorPair(clThistle, 'Thistle', 'clThistle');
  ColorPair(clTomato, 'Tomato', 'clTomato');
  ColorPair(clTurquoise, 'Turquoise', 'clTurquoise');
  ColorPair(clViolet, 'Violet', 'clViolet');
  ColorPair(clWheat, 'Wheat', 'clWheat');
  ColorPair(clWhiteSmoke, 'White Smoke', 'clWhiteSmoke');
  ColorPair(clYellowGreen, 'Yellow Green', 'clYellowGreen');
end;

procedure BuildSystemColors(var Colors: TColorList);

  procedure ColorPair(Color: TColor; const Name, LazName: string);
  var
    P: TColorPair;
  begin
    P.Color := Color;
    P.Name := Name;
    P.LazName := LazName;
    Colors.Push(P);
  end;

begin
  Colors.Clear;
  ColorPair(clScrollBar, 'Scroll Bar', 'clScrollBar');
  ColorPair(clBackground, 'Background', 'clBackground');
  ColorPair(clActiveCaption, 'Active Caption', 'clActiveCaption');
  ColorPair(clInactiveCaption, 'Inactive Caption', 'clInactiveCaption');
  ColorPair(clMenu, 'Menu', 'clMenu');
  ColorPair(clWindow, 'Window', 'clWindow');
  ColorPair(clWindowFrame, 'Window Frame', 'clWindowFrame');
  ColorPair(clMenuText, 'Menu Text', 'clMenuText');
  ColorPair(clWindowText, 'Window Text', 'clWindowText');
  ColorPair(clCaptionText, 'Caption Text', 'clCaptionText');
  ColorPair(clActiveBorder, 'Active Border', 'clActiveBorder');
  ColorPair(clInactiveBorder, 'Inactive Border', 'clInactiveBorder');
  ColorPair(clAppWorkspace, 'App Workspace', 'clAppWorkspace');
  ColorPair(clHighlight, 'Highlight', 'clHighlight');
  ColorPair(clHighlightText, 'Highlight Text', 'clHighlightText');
  ColorPair(clBtnFace, 'Button Face', 'clBtnFace');
  ColorPair(clBtnShadow, 'Button Shadow', 'clBtnShadow');
  ColorPair(clGrayText, 'Gray Text', 'clGrayText');
  ColorPair(clBtnText, 'Button Text', 'clBtnText');
  ColorPair(clInactiveCaptionText, 'Inactive Caption Text', 'clInactiveCaptionText');
  ColorPair(clBtnHighlight, 'BtnHighlight', 'clBtnHighlight');
  ColorPair(cl3DDkShadow, '3D Dark Shadow', 'cl3DDkShadow');
  ColorPair(cl3DLight, '3D Light', 'cl3DLight');
  ColorPair(clInfoText, 'Info Text', 'clInfoText');
  ColorPair(clInfoBk, 'Info Background', 'clInfoBk');
  ColorPair(clHotLight, 'Hot Light', 'clHotLight');
  ColorPair(clGradientActiveCaption, 'Gradient Active Caption', 'clGradientActiveCaption');
  ColorPair(clGradientInactiveCaption, 'Gradient Inactive Caption', 'clGradientInactiveCaption');
  ColorPair(clMenuHighlight, 'Menu Highlight', 'clMenuHighlight');
  ColorPair(clMenuBar, 'Menu Bar', 'clMenuBar');
  ColorPair(clForm, 'Form', 'clForm');
end;

end.

