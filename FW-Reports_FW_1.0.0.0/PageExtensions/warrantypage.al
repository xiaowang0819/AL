// 1. 左侧列表 Part (显示完整列表)

page 78030 "Warranty Test Line Subform"

{

    PageType = ListPart;

    SourceTable = "Sales Line";

    Editable = false;



    // 过滤条件移到 Subform 自身

    SourceTableView = WHERE(

        "Document Type" = CONST(Order),

        "WSB Code 1" = FILTER('REQUEST FOR TEST' | 'TEST COMPLETE')

    );



    layout

    {

        area(Content)

        {

            repeater(Control1)

            {

                ShowCaption = false;



                field("Document No."; Rec."Document No.")

                {

                    ApplicationArea = All;

                }

                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")

                {

                    ApplicationArea = All;

                }

                field("No."; Rec."No.")

                {

                    Caption = 'Part No.';

                    ApplicationArea = All;

                }

                field(Status; Rec."WSB Code 1")

                {

                    ApplicationArea = All;

                }

            }

        }

    }



    // 当左侧列表切换选中行时，通知右侧卡片更新

    trigger OnAfterGetCurrRecord()

    begin

        CurrPage.Update(false);

    end;

}



// 2. 右侧可编辑详情 Part

page 78029 "Warranty Testing Details"
{
    PageType = CardPart;
    SourceTable = "Sales Line";
    Editable = true;

    layout
    {
        area(Content)
        {




            // Grid 控件 + GridLayout = Rows 结合，强制垂直按行垂直排列
            // ShowCaption = false;
            // GridLayout = Rows; // 属性写在这里！

            field("Warranty:Test Status"; Rec."WSB Code 1")
            {
                ApplicationArea = All;
            }



            field("Warranty:Tested By"; Rec."WSB Code 5")
            {
                ApplicationArea = All;
            }


            field("Warranty:Test Date"; Rec."WSB Date 1")
            {
                ApplicationArea = All;
            }
            field("Warranty:Gate Serial No."; Rec."WSB Code 4")
            {
                ApplicationArea = All;
            }
            field("Warranty:Part Serial No."; Rec."WSB Code 3")
            {
                ApplicationArea = All;
            }
            field("Warranty:Cost bear By"; Rec."WSB Code 6")
            {
                ApplicationArea = All;
            }


            // 底部 Findings 保持独立组
            group(FindingsGroup)
            {
                Caption = 'Findings & Result';

                field("Warranty:Test Findings"; Rec."WSB Text 2")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the test findings in detail.';
                }
            }
        }
    }
}


// 3. 主页面 (ListPlus)

page 78028 "Warranty Testing Log"

{

    PageType = ListPlus;

    ApplicationArea = All;

    UsageCategory = Lists;

    Caption = 'Warranty Testing Log';

    AdditionalSearchTerms = 'Warranty Test, Testing, 保修测试, 维保测试';

    Editable = true; // 允许整个视图进入编辑模式



    layout

    {

        area(Content)

        {

            group(MainLayout)

            {

                ShowCaption = false;



                // 左侧列表：【关键改动】去掉 SubPageLink，让它列出所有符合条件的销售行

                part(TestList; "Warranty Test Line Subform")

                {

                    ApplicationArea = All;

                }



                // 右侧详情：【关键改动】由 TestList 提供（Provider），并按主键精确绑定当前高亮行

                part(TestingDetails; "Warranty Testing Details")

                {

                    ApplicationArea = All;

                    Provider = TestList;

                    SubPageLink = "Document Type" = FIELD("Document Type"),

                                  "Document No." = FIELD("Document No."),

                                  "Line No." = FIELD("Line No.");

                }

            }

        }

    }

}